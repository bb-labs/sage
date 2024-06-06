import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:flutter/material.dart';
import 'package:protobuf/protobuf.dart';
import 'package:provider/provider.dart';

class SageWhichAgeDoYouPrefer extends StatelessWidget {
  const SageWhichAgeDoYouPrefer({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            "I'm looking for someone aged",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: SliderTheme(
            data: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.always,
            ),
            child: RangeSlider(
              values: RangeValues(
                userModel.user.preferences.hasAgeMin()
                    ? userModel.user.preferences.ageMin.toDouble()
                    : 18,
                userModel.user.preferences.hasAgeMax()
                    ? userModel.user.preferences.ageMax.toDouble()
                    : 50,
              ),
              max: 50,
              min: 18,
              labels: RangeLabels(
                userModel.user.preferences.ageMin.toString(),
                userModel.user.preferences.ageMax.toString(),
              ),
              onChanged: (RangeValues values) {
                final newUser = userModel.user.deepCopy();
                newUser.preferences = newUser.hasPreferences()
                    ? newUser.preferences
                    : Preferences();
                newUser.preferences.ageMin = values.start.toInt();
                newUser.preferences.ageMax = values.end.toInt();
                userModel.user = newUser;
              },
            ),
          ),
        ),
      ],
    );
  }
}
