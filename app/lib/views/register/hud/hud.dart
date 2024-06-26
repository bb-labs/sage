import 'package:app/views/register/hud/navigation.dart';
import 'package:app/views/register/hud/progress.dart';

import 'package:flutter/material.dart';

class SageRegistrationHud extends StatelessWidget {
  const SageRegistrationHud({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SageProgressCarousel(),
        Spacer(flex: 8),
        SageNavigationButtons(),
        Spacer(flex: 1),
      ],
    );
  }
}
