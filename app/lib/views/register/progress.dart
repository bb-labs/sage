import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SageProgressCarousel extends StatelessWidget {
  static const iconSize = 15.0;

  const SageProgressCarousel({
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
        Icons.waving_hand_outlined,
        Icons.celebration_outlined,
        Icons.transgender,
        Icons.location_on_outlined,
      ].mapIndexed((index, icon) {
        return Icon(
          icon,
          color: Colors.black,
          size: pageIndex == index ? iconSize * 2 : iconSize,
        );
      }).toList(),
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
