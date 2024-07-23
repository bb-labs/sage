import 'package:app/views/settings/navigation.dart';
import 'package:flutter/material.dart';

class SageSettingField extends StatelessWidget {
  final Widget child;
  final bool overflow;
  const SageSettingField({
    super.key,
    required this.child,
    this.overflow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const SageSettingsNavigationButtons(),
      body: overflow
          ? OverflowBox(minHeight: 1500, maxHeight: 1500, child: child)
          : child,
    );
  }
}
