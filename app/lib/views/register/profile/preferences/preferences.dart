import 'package:app/views/register/profile/preferences/age.dart';
import 'package:app/views/register/profile/preferences/gender.dart';
import 'package:flutter/material.dart';

class SageWhatAreYourPreferences extends StatelessWidget {
  const SageWhatAreYourPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Spacer(),
            SageGenderSelect(mode: SageGenderSelectMode.identify),
            SizedBox(height: 40),
            SageGenderSelect(mode: SageGenderSelectMode.interested),
            SizedBox(height: 40),
            SageWhichAgeDoYouPrefer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
