import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SageGoogleSignup extends StatelessWidget {
  const SageGoogleSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      onPressed: () {
        print("Sign in with Google");
        print(String.fromEnvironment('APP_CONTAINER_PROTOCOL_VERSION'));
      },
    );
  }
}
