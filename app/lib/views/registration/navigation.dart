import 'package:app/grpc/client.dart';
import 'package:app/models/register.dart';
import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:app/views/registration/registration.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SageNavigationButtons extends StatelessWidget {
  static const curve = Curves.easeInOut;
  static const duration = Duration(milliseconds: 250);

  final bool validated;
  const SageNavigationButtons({super.key, required this.validated});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    var registrationModel = Provider.of<RegistrationModel>(context);

    final pageIndex = registrationModel.pageIndex;
    final pageController = registrationModel.pageController;

    final isFirstPage = pageIndex == 0;
    final isLastPage = pageIndex == SageRegistration.fields.length - 1;

    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
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
                HapticFeedback.heavyImpact();
                pageController.previousPage(duration: duration, curve: curve);
              },
              child: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.black,
              ),
            ),
          ),
          const Spacer(flex: 4),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (validated) {
                    return ThemeData().colorScheme.onPrimary;
                  }
                  return ThemeData().colorScheme.outlineVariant;
                },
              ),
            ),
            onPressed: () async {
              HapticFeedback.heavyImpact();
              if (!validated) return;
              if (isLastPage) {
                context.go('/reel');
                await SageClientSingleton()
                    .instance
                    .updateUser(UpdateUserRequest(user: userModel.user));
                return;
              }
              pageController.nextPage(duration: duration, curve: curve);
            },
            child: Icon(
              isLastPage ? Icons.check : Icons.arrow_forward_ios_sharp,
              color: isLastPage ? Colors.green : Colors.black,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
