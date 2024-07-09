import 'package:flutter/material.dart';

class SageSettings extends StatelessWidget {
  const SageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text(
          'This is the settings view',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
