import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SageSignUpLoginServices extends StatelessWidget {
  const SageSignUpLoginServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SignInButton(
          Buttons.Google,
          padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onPressed: () {
            print("Sign in with Google");
          },
        ),
        const SizedBox(height: 15),
        SignInButton(
          Buttons.Apple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 17),
          onPressed: () async {
            final credential = await SignInWithApple.getAppleIDCredential(
              scopes: [
                AppleIDAuthorizationScopes.email,
                AppleIDAuthorizationScopes.fullName,
              ],
            );
            print(credential);
          },
        ),
        const SizedBox(height: 15),
        SignInButton(
          Buttons.Facebook,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 17),
          onPressed: () {
            print("Sign in with Facebook");
          },
        )
      ],
    );
  }
}
