import 'package:app/models/register.dart';
import 'package:app/models/user.dart';
import 'package:app/views/fields/birthday.dart';
import 'package:app/views/registration/field.dart';
import 'package:app/views/fields/name.dart';
import 'package:app/views/fields/location.dart';
import 'package:app/views/fields/preferences.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageRegistration extends StatelessWidget {
  const SageRegistration({super.key});

  static int fieldCount = 4;

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    var registrationModel = Provider.of<RegistrationModel>(context);

    final eighteenYearsAgoToday =
        DateTime.now().subtract(const Duration(days: 365 * 18 + 5));

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (newPageIndex) {
        registrationModel.pageIndex = newPageIndex;
      },
      controller: registrationModel.pageController,
      children: [
        SageRegistrationField(
          validated: userModel.name.isNotEmpty,
          child: const SageWhatIsYourName(),
        ),
        SageRegistrationField(
          validated: userModel.birthday.isBefore(eighteenYearsAgoToday),
          child: const SageWhatIsYourBirthday(),
        ),
        SageRegistrationField(
          validated: userModel.gender.isNotEmpty &&
              userModel.preferredGenders.isNotEmpty,
          child: const SageWhatAreYourPreferences(),
        ),
        SageRegistrationField(
          validated: userModel.preferredLocation != null,
          child: const OverflowBox(
            maxHeight: 1500,
            minHeight: 1500,
            child: SageWhereDoYouWantToDate(),
          ),
        ),
      ],
    );
  }
}
