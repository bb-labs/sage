import 'package:app/views/login/splash/splash.dart';
import 'package:flutter/material.dart';

import 'package:app/views/login/splash/legal.dart';
import 'package:app/views/login/services/services.dart';

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
              SageSplashPage(),
              Spacer(),
              SageLoginServices(),
              SizedBox(height: 5),
              SageLoginLegal(),
            ],
          ),
        ),
      ),
    );
  }
}
