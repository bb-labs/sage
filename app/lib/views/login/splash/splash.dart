import 'package:app/views/login/splash/animation.dart';
import 'package:app/views/login/splash/logo.dart';

import 'package:flutter/material.dart';

class SageSplashPage extends StatelessWidget {
  const SageSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SageLoginLogo(),
        SageLoginAnimation(),
      ],
    );
  }
}
