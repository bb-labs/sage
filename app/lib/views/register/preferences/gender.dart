import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:app/proto/sage.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

enum SageGenderSelectMode { identify, interested }

class SageGenderButton extends StatelessWidget {
  const SageGenderButton({
    super.key,
    required this.gender,
    required this.mode,
  });

  final SageGenderSelectMode mode;
  final Gender gender;

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    return ElevatedButton(
      onPressed: () {
        switch (mode) {
          case SageGenderSelectMode.identify:
            userModel.gender = gender;
          case SageGenderSelectMode.interested:
            userModel.togglePrefferedGender(gender);
        }
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            final newUserGenders = mode == SageGenderSelectMode.identify
                ? [userModel.gender]
                : userModel.preferredGenders;
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
    required this.mode,
  });

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
                : 'interested in dating',
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
              mode: mode,
            );
          }).toList(),
        ),
      ],
    );
  }
}
