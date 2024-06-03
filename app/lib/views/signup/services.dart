import 'package:app/views/signup/apple.dart';
import 'package:app/views/signup/facebook.dart';
import 'package:app/views/signup/google.dart';
import 'package:flutter/material.dart';

class SageSignUpLoginServices extends StatelessWidget {
  const SageSignUpLoginServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SageGoogleSignup(),
        const SizedBox(height: 15),
        SageAppleSignup(),
        const SizedBox(height: 15),
        const SageFacebookSignup(),
      ],
    );
  }
}
