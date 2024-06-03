import 'package:flutter/material.dart';

import 'package:app/views/signup/logo.dart';
import 'package:app/views/signup/legal.dart';
import 'package:app/views/signup/animation.dart';
import 'package:app/views/signup/services.dart';

class SageSignUp extends StatelessWidget {
  const SageSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              SageSignUpLogo(),
              Spacer(),
              Spacer(),
              SageSignUpAnimation(),
              Spacer(),
              Spacer(),
              Spacer(),
              Spacer(),
              Spacer(),
              SageSignUpLoginServices(),
              SizedBox(height: 5),
              SageSignUpLegal(),
            ],
          ),
        ),
      ),
    );
  }
}
