import 'package:app/views/intro/button.dart';
import 'package:app/views/intro/ghosting.dart';
import 'package:app/views/intro/authentic.dart';
import 'package:app/views/intro/ready.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SageIntroduction extends StatefulWidget {
  const SageIntroduction({super.key});

  @override
  State<SageIntroduction> createState() => _SageIntroductionState();
}

class _SageIntroductionState extends State<SageIntroduction> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              onPageChanged: (value) {
                setState(() {
                  isLastPage = value == 2;
                });
              },
              controller: _controller,
              children: const [
                SageKeepGhostsAway(),
                SageAuthenticYou(),
                SageReadyToGo(),
              ],
            ),
            Container(
              alignment: const Alignment(0, 0.75),
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const WormEffect(
                  activeDotColor: Colors.black,
                ),
              ),
            ),
            if (isLastPage) const SageGetStartedButton(),
          ],
        ),
      ),
    );
  }
}
