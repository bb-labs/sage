import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SageReadyToGo extends StatelessWidget {
  const SageReadyToGo({super.key});

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
            const Spacer(),
            const Spacer(),
            const Text("Well, Let's Go!", style: TextStyle(fontSize: 45)),
            const SizedBox(height: 45),
            SizedBox(
              height: 300,
              child: OverflowBox(
                minHeight: 600,
                maxHeight: 600,
                child: Lottie.asset(
                  "assets/ready.json",
                  frameRate: FrameRate.max,
                  reverse: true,
                ),
              ),
            ),
            const Text(
                "Welcome to the most authentic dating app out there. We're excited to have you!",
                style: TextStyle(fontSize: 20)),
            const Spacer(),
            const Spacer(),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
