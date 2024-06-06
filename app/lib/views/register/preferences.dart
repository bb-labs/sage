import 'package:app/views/register/age.dart';
import 'package:app/views/register/location.dart';
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
            Spacer(flex: 7),
            SageWhichAgeDoYouPrefer(),
            Spacer(),
            SageWhatAreYourProximityPreferences(),
            Spacer(flex: 7),
          ],
        ),
      ),
    );
  }
}
