import 'package:app/views/register/birthday.dart';
import 'package:app/views/register/navigation.dart';
import 'package:app/views/register/gender.dart';
import 'package:app/views/register/name.dart';
import 'package:app/views/register/preferences.dart';
import 'package:app/views/register/status.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SageRegistration extends StatefulWidget {
  const SageRegistration({super.key});

  @override
  State<SageRegistration> createState() => _SageRegistrationState();
}

class _SageRegistrationState extends State<SageRegistration> {
  static const numFields = 4;

  int pageIndex = 0;
  final PageController _pageController = PageController();
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (newPageIndex) {
                setState(() {
                  pageIndex = newPageIndex;
                });
              },
              controller: _pageController,
              children: const [
                SageWhatIsYourName(),
                SageWhatIsYourBirthday(),
                SageWhichGendersAreYouInto(),
                SageWhatAreYourPreferences(),
              ],
            ),
            Column(
              children: [
                SageStatusCarousel(
                  pageIndex: pageIndex,
                  carouselController: _carouselController,
                ),
                const Spacer(flex: 8),
                SageNavigationButtons(
                  isFirstPage: pageIndex == 0,
                  isLastPage: pageIndex == numFields - 1,
                  pageController: _pageController,
                  carouselController: _carouselController,
                ),
                const Spacer(flex: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
