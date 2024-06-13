import 'package:app/views/profile/birthday.dart';
import 'package:app/views/register/preferences/location.dart';
import 'package:app/views/register/navigation.dart';
import 'package:app/views/profile/name.dart';
import 'package:app/views/register/preferences/preferences.dart';
import 'package:app/views/register/progress.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SageRegistration extends StatefulWidget {
  const SageRegistration({super.key});

  @override
  State<SageRegistration> createState() => _SageRegistrationState();
}

class _SageRegistrationState extends State<SageRegistration> {
  int pageIndex = 0;
  final PageController _pageController = PageController();
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    const registrationFields = [
      SageWhatIsYourName(),
      SageWhatIsYourBirthday(),
      SageWhatAreYourPreferences(),
      SageWhereDoYouWantToDate(),
    ];

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
              children: registrationFields,
            ),
            Column(
              children: [
                SageProgressCarousel(
                  pageIndex: pageIndex,
                  carouselController: _carouselController,
                ),
                const Spacer(flex: 8),
                SageNavigationButtons(
                  isFirstPage: pageIndex == 0,
                  isLastPage: pageIndex == registrationFields.length - 1,
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
