import 'package:app/views/login/services/apple.dart';
import 'package:app/views/login/services/google.dart';
import 'package:flutter/material.dart';

class SageLoginServices extends StatelessWidget {
  const SageLoginServices({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SageAppleSignup(),
        SizedBox(height: 15),
        SageGoogleSignup(),
        SizedBox(height: 15),
      ],
    );
  }
}
