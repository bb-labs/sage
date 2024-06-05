import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:app/proto/sage.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:protobuf/protobuf.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class SageWhatAreYouInto extends StatelessWidget {
  const SageWhatAreYouInto({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Spacer(),
          SageGenderSelect(
            userModel: userModel,
            mode: SageGenderSelectMode.identify,
          ),
          const SizedBox(height: 40),
          SageGenderSelect(
            userModel: userModel,
            mode: SageGenderSelectMode.interested,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

enum SageGenderSelectMode { identify, interested }

class SageGenderButton extends StatelessWidget {
  const SageGenderButton({
    super.key,
    required this.userModel,
    required this.gender,
    required this.mode,
  });

  final SageGenderSelectMode mode;
  final Gender gender;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final newUser = userModel.user.deepCopy();
        List<Gender> newUserGenders;
        switch (mode) {
          case SageGenderSelectMode.identify:
            newUserGenders = newUser.gender;
          case SageGenderSelectMode.interested:
            newUser.preferences = newUser.hasPreferences()
                ? newUser.preferences.deepCopy()
                : Preferences();
            newUserGenders = newUser.preferences.gender;
        }
        newUserGenders.contains(gender)
            ? newUserGenders.remove(gender)
            : newUserGenders.add(gender);
        userModel.user = newUser;
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            final newUserGenders = mode == SageGenderSelectMode.identify
                ? userModel.user.gender
                : userModel.user.preferences.gender;
            if (newUserGenders.contains(gender)) {
              return ThemeData().colorScheme.outlineVariant;
            }
            return ThemeData().colorScheme.onPrimary;
          },
        ),
      ),
      child: Text(mode == SageGenderSelectMode.identify
          ? toBeginningOfSentenceCase(gender.toString().toLowerCase())
          : toBeginningOfSentenceCase(
              GenderPlural.valueOf(gender.value)!.name.toLowerCase())),
    );
  }
}

class SageGenderSelect extends StatelessWidget {
  const SageGenderSelect({
    super.key,
    required this.userModel,
    required this.mode,
  });

  final UserModel userModel;
  final SageGenderSelectMode mode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            mode == SageGenderSelectMode.identify
                ? 'I identify as a'
                : 'and am interested in dating',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          children: [Gender.WOMAN, Gender.HUMAN, Gender.MAN].map((gender) {
            return SageGenderButton(
              gender: gender,
              userModel: userModel,
              mode: mode,
            );
          }).toList(),
        ),
      ],
    );
  }
}
