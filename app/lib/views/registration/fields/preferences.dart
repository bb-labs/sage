import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:app/proto/sage.pbgrpc.dart';
import 'package:app/views/registration/fields/fields.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class SageWhatAreYourPreferences extends StatelessWidget {
  const SageWhatAreYourPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    return SageField(
      validated:
          userModel.gender.isNotEmpty && userModel.preferredGenders.isNotEmpty,
      child: const Column(
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
    );
  }
}

enum SageGenderSelectMode { identify, interested }

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
        HapticFeedback.lightImpact();
        switch (mode) {
          case SageGenderSelectMode.identify:
            userModel.toggleGender(gender);
          case SageGenderSelectMode.interested:
            userModel.togglePrefferedGender(gender);
        }
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            final newUserGenders = mode == SageGenderSelectMode.identify
                ? userModel.gender
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
            "between the ages of",
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
            data: SliderThemeData(
              showValueIndicator: ShowValueIndicator.never,
              rangeThumbShape: IndicatorRangeSliderThumbShape(
                userModel.preferredAgeMin.toInt().toString(),
                userModel.preferredAgeMax.toInt().toString(),
              ),
            ),
            child: RangeSlider(
              divisions: UserModel.maxAge - UserModel.minAge,
              values: RangeValues(
                userModel.preferredAgeMin,
                userModel.preferredAgeMax,
              ),
              min: UserModel.minAge.toDouble(),
              max: UserModel.maxAge.toDouble(),
              labels: RangeLabels(
                userModel.preferredAgeMin.toString(),
                userModel.preferredAgeMax.toString(),
              ),
              onChanged: (RangeValues values) {
                HapticFeedback.selectionClick();
                userModel.preferredAgeMin = values.start;
                userModel.preferredAgeMax = values.end;
              },
            ),
          ),
        ),
      ],
    );
  }
}

class IndicatorRangeSliderThumbShape<T> extends RangeSliderThumbShape {
  IndicatorRangeSliderThumbShape(this.start, this.end);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(15, 40);
  }

  T start;
  T end;
  late TextPainter labelTextPainter = TextPainter()
    ..textDirection = TextDirection.ltr;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;
    final Paint strokePaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.yellow
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, 12, Paint()..color = Colors.white);
    canvas.drawCircle(center, 12, strokePaint);
    if (thumb == null) {
      return;
    }
    final value = thumb == Thumb.start ? start : end;
    labelTextPainter.text = TextSpan(
        text: value.toString(),
        style: const TextStyle(fontSize: 20, color: Colors.black));
    labelTextPainter.layout();
    labelTextPainter.paint(canvas,
        center.translate(-labelTextPainter.width / 2, labelTextPainter.height));
  }
}
