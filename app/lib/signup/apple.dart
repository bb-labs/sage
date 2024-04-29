import 'package:app/auth.dart';
import 'package:app/client.dart';
import 'package:app/pb/sage.pb.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SageAppleSignup extends StatelessWidget {
  const SageAppleSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Apple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 17),
      onPressed: () async {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        if (credential.identityToken == null) {
          return;
        }

        SageAuthSingleton().token = credential.identityToken!;
        SageAuthSingleton().code = credential.authorizationCode;

        final response = await SageClientSingleton().instance.createUser(
              CreateUserRequest(
                user: User(
                  id: credential.userIdentifier,
                  email: credential.email,
                  firstName: credential.givenName,
                  lastName: credential.familyName,
                ),
              ),
            );

        print(response);
      },
    );
  }
}
