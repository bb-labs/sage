import 'package:app/models/auth.dart';
import 'package:app/models/user.dart';
import 'package:app/grpc/interceptors/auth.dart';
import 'package:app/grpc/client.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:go_router/go_router.dart';

import 'package:grpc/grpc.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SageAppleSignup extends StatelessWidget {
  const SageAppleSignup({super.key});

  @override
  Widget build(BuildContext context) {
    var authModel = Provider.of<AuthModel>(context);
    var userModel = Provider.of<UserModel>(context);

    return SignInButton(
      Buttons.Apple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 17),
      onPressed: () async {
        // Sign in with Apple
        final cred = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        // Create and store the user
        var response = await SageClientSingleton().instance.createUser(
              CreateUserRequest(
                user: User(
                  id: cred.userIdentifier,
                  email: cred.email,
                  firstName: cred.givenName,
                  lastName: cred.familyName,
                ),
              ),
              options: CallOptions(
                providers: [SageAuthInterceptor.metadataFromApple(cred)],
              ),
            );

        authModel.status = AuthStatus.welcome;
        userModel.user = response.user;
        await userModel.store();

        if (context.mounted) {
          context.go('/intro');
        }
      },
    );
  }
}
