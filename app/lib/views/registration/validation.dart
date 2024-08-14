import 'package:app/grpc/client.dart';
import 'package:app/models/navigation.dart';
import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:app/views/registration/registration.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SageRegistrationValidationButtons extends StatelessWidget {
  static const curve = Curves.easeInOut;
  static const duration = Duration(milliseconds: 250);

  final bool validIf;
  const SageRegistrationValidationButtons({super.key, required this.validIf});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    var navigationModel = Provider.of<NavigationModel>(context);

    final pageIndex = navigationModel.registrationScreen.index;
    final isFirstPage = pageIndex == 0;
    final isLastPage = pageIndex == SageRegistration.fieldCount - 1;

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
                navigationModel.registrationController
                    .jumpToPage(pageIndex - 1);
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
              shape: WidgetStateProperty.all(const CircleBorder()),
              padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (validIf) {
                    return ThemeData().colorScheme.onPrimary;
                  }
                  return ThemeData().colorScheme.outlineVariant;
                },
              ),
            ),
            onPressed: () async {
              if (!validIf) return;
              if (isLastPage) {
                context.go('/reel');
                await SageClientSingleton()
                    .instance
                    .updateUser(UpdateUserRequest(user: userModel.user));
                return;
              }
              navigationModel.registrationController.jumpToPage(pageIndex + 1);
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
