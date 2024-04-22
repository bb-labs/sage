import 'package:flutter/material.dart';

import 'package:app/user/signup/signup_logo_view.dart';
import 'package:app/user/signup/signup_legal_view.dart';
import 'package:app/user/signup/signup_animation_view.dart';
import 'package:app/user/signup/signup_login_services_view.dart';

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
