import 'package:app/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SageGetStartedButton extends StatelessWidget {
  const SageGetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthModel>(context);

    return Container(
      alignment: const Alignment(0, 0.75),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          minimumSize: const Size(350, 50),
        ),
        onPressed: () {
          context.go("/signup");
        },
        child: const Text("Get Started"),
      ),
    );
  }
}
