import 'package:app/models/register.dart';
import 'package:app/views/register/profile/profile.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SageNavigationButtons extends StatelessWidget {
  static const curve = Curves.easeInOut;
  static const duration = Duration(milliseconds: 650);

  const SageNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var registrationModel = Provider.of<RegistrationModel>(context);

    final pageIndex = registrationModel.pageIndex;
    final pageController = registrationModel.pageController;
    final carouselController = registrationModel.carouselController;

    final isFirstPage = pageIndex == 0;
    final isLastPage = pageIndex == SageProfile.fields.length - 1;

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
              pageController.previousPage(duration: duration, curve: curve);
              carouselController.previousPage(duration: duration, curve: curve);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.black,
            ),
          ),
        ),
        const Spacer(flex: 4),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () {
            if (isLastPage) {
              context.go('/profile');
              return;
            }
            pageController.nextPage(duration: duration, curve: curve);
            carouselController.nextPage(duration: duration, curve: curve);
          },
          child: Icon(
            isLastPage ? Icons.check : Icons.arrow_forward_ios_sharp,
            color: isLastPage ? Colors.green : Colors.black,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
