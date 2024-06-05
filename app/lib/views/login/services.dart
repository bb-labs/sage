import 'package:app/views/login/apple.dart';
import 'package:app/views/login/facebook.dart';
import 'package:app/views/login/google.dart';
import 'package:flutter/material.dart';

class SageLoginLoginServices extends StatelessWidget {
  const SageLoginLoginServices({super.key});

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
