import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protobuf/protobuf.dart';
import 'package:provider/provider.dart';

class SageWhatAreYourProximityPreferences extends StatelessWidget {
  const SageWhatAreYourProximityPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            'that lives in my',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          children: [Proximity.HOOD, Proximity.CITY, Proximity.METRO]
              .map((proximity) {
            return SageProximityButton(proximity: proximity);
          }).toList(),
        ),
      ],
    );
  }
}

class SageProximityButton extends StatelessWidget {
  const SageProximityButton({
    super.key,
    required this.proximity,
  });

  final Proximity proximity;

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    return ElevatedButton(
      onPressed: () {
        final newUser = userModel.user.deepCopy();
        newUser.preferences = newUser.hasPreferences()
            ? newUser.preferences.deepCopy()
            : Preferences();
        newUser.preferences.proximity = proximity;
        userModel.user = newUser;
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (userModel.user.preferences.hasProximity() &&
                userModel.user.preferences.proximity == proximity) {
              return ThemeData().colorScheme.outlineVariant;
            }
            return ThemeData().colorScheme.onPrimary;
          },
        ),
      ),
      child: Text(
        toBeginningOfSentenceCase(proximity.toString().toLowerCase()),
      ),
    );
  }
}
