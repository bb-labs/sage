import 'dart:io';

import 'package:app/views/login/services/apple.dart';
import 'package:app/views/login/services/google.dart';
import 'package:app/views/login/animation.dart';
import 'package:app/views/login/logo.dart';
import 'package:flutter/material.dart';

import 'package:app/views/login/legal.dart';

class SageLogin extends StatelessWidget {
  const SageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const SageLoginLogo(),
              const Spacer(),
              const SageLoginAnimation(),
              const Spacer(flex: 4),
              Platform.isIOS
                  ? const SageAppleSignup()
                  : const SageGoogleSignup(),
              const SageLoginLegal(),
            ],
          ),
        ),
      ),
    );
  }
}
