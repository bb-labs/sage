import 'package:flutter/material.dart';

class SageCreateAccount extends StatelessWidget {
  const SageCreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hey I'm the create account page"),
            ],
          ),
        ),
      ),
    );
  }
}
