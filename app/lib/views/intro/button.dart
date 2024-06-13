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
          minimumSize: const Size(350, 50),
        ),
        onPressed: () {
          context.go("/register");
        },
        child: const Text("Get Started"),
      ),
    );
  }
}
