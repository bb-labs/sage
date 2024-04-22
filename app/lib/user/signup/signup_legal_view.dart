import 'package:flutter/material.dart';

class SageSignUpLegal extends StatelessWidget {
  const SageSignUpLegal({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 11),
          ),
          onPressed: () {},
          child: const Text('Terms of Service'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 11),
          ),
          onPressed: () {},
          child: const Text('Privacy Policy'),
        ),
      ],
    );
  }
}
