import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SageAuthInterceptor implements ClientInterceptor {
  static String codeRequestHeaderKey = "x-auth-code";
  static String tokenRequestHeaderKey = "authorization";
  static String refreshRequestHeaderKey = "x-auth-refresh";

  static MetadataProvider metadataFromApple(
      AuthorizationCredentialAppleID apple) {
    return (Map<String, String> metadata, String _) {
      metadata[codeRequestHeaderKey] = apple.authorizationCode;
      if (apple.identityToken != null) {
        metadata[tokenRequestHeaderKey] = apple.identityToken!;
      }
    };
  }

  static getMetadata(Map<String, String> metadata, String _) async {
    final prefs = await SharedPreferences.getInstance();

    final code = prefs.getString(codeRequestHeaderKey);
    final token = prefs.getString(tokenRequestHeaderKey);
    final refresh = prefs.getString(refreshRequestHeaderKey);

    if (code != null) {
      metadata[codeRequestHeaderKey] = code;
    }
    if (token != null) {
      metadata[tokenRequestHeaderKey] = token;
    }
    if (refresh != null) {
      metadata[refreshRequestHeaderKey] = refresh;
    }
  }

  static setSharedPreferences(Map<String, String> metadata) async {
    final prefs = await SharedPreferences.getInstance();

    // Remove auth code, we've successfully redeemed it for a refresh token
    // at this point if it's still in the shared preferences.
    await prefs.remove(SageAuthInterceptor.codeRequestHeaderKey);

    if (metadata.containsKey(codeRequestHeaderKey)) {
      prefs.setString(codeRequestHeaderKey, metadata[codeRequestHeaderKey]!);
    }
    if (metadata.containsKey(tokenRequestHeaderKey)) {
      prefs.setString(tokenRequestHeaderKey, metadata[tokenRequestHeaderKey]!);
    }
    if (metadata.containsKey(refreshRequestHeaderKey)) {
      prefs.setString(
          refreshRequestHeaderKey, metadata[refreshRequestHeaderKey]!);
    }
  }

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    throw UnimplementedError();
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    final response = invoker(
      method,
      request,
      options.mergedWith(
          CallOptions(providers: [SageAuthInterceptor.getMetadata])),
    );

    response.headers.then(SageAuthInterceptor.setSharedPreferences);

    return response;
  }
}
