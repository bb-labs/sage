import 'package:app/main.dart';
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

        final response = await SageClientSingleton().client.createUser(
              CreateUserRequest(
                user: User(
                  id: credential.userIdentifier,
                  email: credential.email,
                  name: credential.givenName,
                ),
              ),
            );

        print(response);
      },
    );
  }
}
