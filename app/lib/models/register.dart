import 'package:flutter/material.dart';

class RegistrationModel with ChangeNotifier {
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}
