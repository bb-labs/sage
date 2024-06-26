import 'package:app/models/register.dart';
import 'package:app/views/register/profile/info/birthday.dart';
import 'package:app/views/register/profile/info/name.dart';
import 'package:app/views/register/profile/preferences/location.dart';
import 'package:app/views/register/profile/preferences/preferences.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageProfile extends StatelessWidget {
  const SageProfile({super.key});

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
