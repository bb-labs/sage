import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SageGetStartedButton extends StatelessWidget {
  const SageGetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, 0.75),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(350, 50),
        ),
        onPressed: () {
          print("Get Started");
          context.go("/register");
        },
        child: const Text("Get Started"),
      ),
    );
  }
}
