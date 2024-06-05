import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SageKeepGhostsAway extends StatelessWidget {
  const SageKeepGhostsAway({super.key});

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
            const Text("Yup, Ghosting Is Over", style: TextStyle(fontSize: 45)),
            SizedBox(
              height: 300,
              child: OverflowBox(
                minHeight: 600,
                maxHeight: 600,
                child: Lottie.asset(
                  "assets/ghosted.json",
                  frameRate: FrameRate.max,
                  reverse: true,
                ),
              ),
            ),
            const Text(
                "We hate ghosting. In fact, that's why we call ourselves Sage; it keeps the ghosts away!",
                style: TextStyle(fontSize: 20)),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
