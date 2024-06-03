import 'package:flutter/material.dart';

class SageHome extends StatelessWidget {
  const SageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hey I'm the home page"),
            ],
          ),
        ),
      ),
    );
  }
}
