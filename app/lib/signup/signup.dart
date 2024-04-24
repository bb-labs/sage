import 'package:flutter/material.dart';

import 'package:app/signup/logo.dart';
import 'package:app/signup/legal.dart';
import 'package:app/signup/animation.dart';
import 'package:app/signup/services.dart';

class SageSignUp extends StatelessWidget {
  const SageSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
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
    );
  }
}
