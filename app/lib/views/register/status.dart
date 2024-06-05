import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SageStatusCarousel extends StatelessWidget {
  static const iconSize = 15.0;

  const SageStatusCarousel({
    super.key,
    required this.pageIndex,
    required CarouselController carouselController,
  }) : _carouselController = carouselController;

  final int pageIndex;
  final CarouselController _carouselController;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Icon(
          Icons.waving_hand_outlined,
          color: Colors.black,
          size: pageIndex == 0 ? iconSize * 2 : iconSize,
        ),
        Icon(
          Icons.transgender,
          color: Colors.black,
          size: pageIndex == 1 ? iconSize * 2 : iconSize,
        ),
        Icon(
          Icons.emoji_people_outlined,
          color: Colors.black,
          size: pageIndex == 2 ? iconSize * 2 : iconSize,
        ),
        Icon(
          Icons.celebration_outlined,
          color: Colors.black,
          size: pageIndex == 3 ? iconSize * 2 : iconSize,
        ),
        Icon(
          Icons.location_on_outlined,
          color: Colors.black,
          size: pageIndex == 4 ? iconSize * 2 : iconSize,
        ),
      ],
      carouselController: _carouselController,
      options: CarouselOptions(
        scrollPhysics: const NeverScrollableScrollPhysics(),
        enableInfiniteScroll: false,
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.20,
        animateToClosest: true,
      ),
    );
  }
}
