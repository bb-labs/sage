import 'package:app/views/register/hud/hud.dart';
import 'package:app/views/register/profile.dart';

import 'package:flutter/material.dart';

class SageRegistration extends StatelessWidget {
  const SageRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SageProfile(),
            SageRegistrationHud(),
          ],
        ),
      ),
    );
  }
}
