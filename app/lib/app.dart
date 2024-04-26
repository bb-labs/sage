import 'package:flutter/material.dart';
import 'package:app/signup/signup.dart';

class SageApp extends StatelessWidget {
  const SageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SageSignUp(),
        ),
      ),
    );
  }
}
