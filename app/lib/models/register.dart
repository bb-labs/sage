import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RegistrationModel with ChangeNotifier {
  int _pageIndex = 0;
  final PageController _pageController = PageController();
  final CarouselController _carouselController = CarouselController();

  PageController get pageController => _pageController;
  CarouselController get carouselController => _carouselController;
  int get pageIndex => _pageIndex;
  set pageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}
