import 'package:app/models/register.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class SageProgressCarousel extends StatelessWidget {
  static const iconSize = 15.0;

  const SageProgressCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    var registrationModel = Provider.of<RegistrationModel>(context);

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
          size: registrationModel.pageIndex == index ? iconSize * 2 : iconSize,
        );
      }).toList(),
      carouselController: registrationModel.carouselController,
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
