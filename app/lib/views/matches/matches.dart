import 'package:flutter/material.dart';

class SageMatches extends StatelessWidget {
  const SageMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
      ),
      body: const Center(
        child: Text(
          'This is the matches view',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
