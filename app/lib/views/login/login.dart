import 'package:flutter/material.dart';

import 'package:app/views/login/logo.dart';
import 'package:app/views/login/legal.dart';
import 'package:app/views/login/animation.dart';
import 'package:app/views/login/services.dart';

class SageLogin extends StatelessWidget {
  const SageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              SageLoginLogo(),
              Spacer(),
              Spacer(),
              SageLoginAnimation(),
              Spacer(),
              Spacer(),
              Spacer(),
              Spacer(),
              Spacer(),
              SageLoginLoginServices(),
              SizedBox(height: 5),
              SageLoginLegal(),
            ],
          ),
        ),
      ),
    );
  }
}
