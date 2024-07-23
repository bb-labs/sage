import 'package:app/views/registration/navigation.dart';
import 'package:flutter/material.dart';

class SageRegistrationField extends StatelessWidget {
  final Widget child;
  final bool validated;
  const SageRegistrationField({
    super.key,
    required this.child,
    required this.validated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SageNavigationButtons(validated: validated),
      body: child,
    );
  }
}
