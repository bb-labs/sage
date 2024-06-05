import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SageNavigationButtons extends StatelessWidget {
  static const curve = Curves.easeInOut;
  static const duration = Duration(milliseconds: 650);

  const SageNavigationButtons({
    super.key,
    required this.isFirstPage,
    required this.isLastPage,
    required PageController pageController,
    required CarouselController carouselController,
  })  : _pageController = pageController,
        _carouselController = carouselController;

  final bool isFirstPage;
  final bool isLastPage;
  final PageController _pageController;
  final CarouselController _carouselController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: !isFirstPage,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            onPressed: () {
              _pageController.previousPage(duration: duration, curve: curve);
              _carouselController.previousPage(
                  duration: duration, curve: curve);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.black,
            ),
          ),
        ),
        const Spacer(flex: 4),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: !isLastPage,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            onPressed: () {
              _pageController.nextPage(duration: duration, curve: curve);
              _carouselController.nextPage(duration: duration, curve: curve);
            },
            child: const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
