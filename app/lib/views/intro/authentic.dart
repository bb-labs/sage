import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SageAuthenticYou extends StatelessWidget {
  const SageAuthenticYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const Spacer(flex: 2),
            const Text("Show 'Em the Reel You", style: TextStyle(fontSize: 45)),
            SizedBox(
              height: 300,
              child: OverflowBox(
                minHeight: 600,
                maxHeight: 600,
                child: Lottie.asset(
                  "assets/authentic.json",
                  frameRate: FrameRate.max,
                  reverse: true,
                ),
              ),
            ),
            const Text(
                "Ditch the elaborate profile. The people just want to see... you.",
                style: TextStyle(fontSize: 20)),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
