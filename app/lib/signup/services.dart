import 'package:app/signup/apple.dart';
import 'package:app/signup/facebook.dart';
import 'package:app/signup/google.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SageSignUpLoginServices extends StatelessWidget {
  const SageSignUpLoginServices({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SageGoogleSignup(),
        SizedBox(height: 15),
        SageAppleSignup(),
        SizedBox(height: 15),
        SageFacebookSignup(),
      ],
    );
  }
}
