import 'package:app/models/register.dart';
import 'package:app/views/registration/fields/birthday.dart';
import 'package:app/views/registration/fields/name.dart';
import 'package:app/views/registration/fields/location.dart';
import 'package:app/views/registration/fields/preferences.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageRegistration extends StatelessWidget {
  const SageRegistration({super.key});

  static const fields = [
    SageWhatIsYourName(),
    SageWhatIsYourBirthday(),
    SageWhatAreYourPreferences(),
    SageWhereDoYouWantToDate(),
  ];

  @override
  Widget build(BuildContext context) {
    var registrationModel = Provider.of<RegistrationModel>(context);

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (newPageIndex) {
        registrationModel.pageIndex = newPageIndex;
      },
      controller: registrationModel.pageController,
      children: fields,
    );
  }
}
