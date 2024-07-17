import 'package:app/views/registration/navigation.dart';
import 'package:flutter/material.dart';

class SageField extends StatelessWidget {
  final Widget child;
  final bool validated;
  const SageField({super.key, required this.child, required this.validated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SageNavigationButtons(validated: validated),
      body: child,
    );
  }
}
