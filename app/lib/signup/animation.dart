import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SageSignUpAnimation extends StatelessWidget {
  const SageSignUpAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 120,
          child: OverflowBox(
            minHeight: 700,
            maxHeight: 700,
            child: Lottie.asset(
              "assets/sage.json",
              frameRate: FrameRate.max,
              reverse: true,
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Lottie.asset(
              "assets/ghost.json",
              frameRate: FrameRate.max,
            )),
      ],
    );
  }
}
