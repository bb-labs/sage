import 'package:grpc/grpc.dart';

class SageAuthSingleton {
  static final SageAuthSingleton _instance =
      SageAuthSingleton._privateConstructor();

  factory SageAuthSingleton() {
    return _instance;
  }

  SageAuthSingleton._privateConstructor();

  Map<String, String> metadata = {
    SageAuthInterceptor.codeRequestHeaderKey: "",
    SageAuthInterceptor.tokenRequestHeaderKey: "",
    SageAuthInterceptor.refreshRequestHeaderKey: "",
  };

  set token(String token) {
    metadata[SageAuthInterceptor.tokenRequestHeaderKey] = token;
  }

  set code(String code) {
    metadata[SageAuthInterceptor.codeRequestHeaderKey] = code;
  }

  set refresh(String refresh) {
    metadata[SageAuthInterceptor.refreshRequestHeaderKey] = refresh;
  }
}

class SageAuthInterceptor implements ClientInterceptor {
  static String codeRequestHeaderKey = "x-auth-code";
  static String tokenRequestHeaderKey = "authorization";
  static String refreshRequestHeaderKey = "x-auth-refresh";

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    print("TODO: implement interceptStreaming");
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
      options.mergedWith(CallOptions(metadata: SageAuthSingleton().metadata)),
    );

    response.headers.then((headers) {
      if (headers.containsKey(refreshRequestHeaderKey)) {
        SageAuthSingleton().refresh = headers[refreshRequestHeaderKey]!;
      }
      if (headers.containsKey(tokenRequestHeaderKey)) {
        SageAuthSingleton().token = headers[tokenRequestHeaderKey]!;
      }
    });

    return response;
  }
}
