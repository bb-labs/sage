import 'package:app/models/navigation.dart';
import 'package:app/models/user.dart';
import 'package:app/views/fields/birthday.dart';
import 'package:app/views/fields/fields.dart';
import 'package:app/views/fields/name.dart';
import 'package:app/views/fields/location.dart';
import 'package:app/views/fields/preferences.dart';
import 'package:app/views/registration/validation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageRegistration extends StatelessWidget {
  const SageRegistration({super.key});

  static int fieldCount = 4;

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    var navigationModel = Provider.of<NavigationModel>(context);

    final eighteenYearsAgoToday =
        DateTime.now().subtract(const Duration(days: 365 * 18 + 5));

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        navigationModel.registrationScreen = RegistrationScreen.values[index];
      },
      controller: navigationModel.registrationController,
      children: [
        SageFieldEditor(
          validator: SageRegistrationValidationButtons(
              validIf: userModel.name.isNotEmpty),
          child: const SageWhatIsYourName(),
        ),
        SageFieldEditor(
          validator: SageRegistrationValidationButtons(
              validIf: userModel.birthday.isBefore(eighteenYearsAgoToday)),
          child: const SageWhatIsYourBirthday(),
        ),
        SageFieldEditor(
          validator: SageRegistrationValidationButtons(
              validIf: userModel.gender.isNotEmpty &&
                  userModel.preferredGenders.isNotEmpty),
          child: const SageWhatAreYourPreferences(),
        ),
        SageFieldEditor(
          validator: SageRegistrationValidationButtons(
              validIf: userModel.preferredLocation != null),
          overflow: true,
          child: const SageWhereDoYouWantToDate(),
        ),
      ],
    );
  }
}
