import 'package:flutter/material.dart';

class SageFieldEditor extends StatelessWidget {
  final bool overflow;
  final Widget child;
  final Widget validator;
  const SageFieldEditor({
    super.key,
    required this.child,
    this.overflow = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: validator,
      body: overflow
          ? OverflowBox(minHeight: 1500, maxHeight: 1500, child: child)
          : child,
    );
  }
}
