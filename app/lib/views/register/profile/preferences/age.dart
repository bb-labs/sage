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
                userModel.user.preferences.hasAgeMin()
                    ? userModel.user.preferences.ageMin
                    : 18,
                userModel.user.preferences.hasAgeMax()
                    ? userModel.user.preferences.ageMax
                    : 40,
              ),
            ),
            child: RangeSlider(
              values: RangeValues(
                userModel.user.preferences.hasAgeMin()
                    ? userModel.user.preferences.ageMin.toDouble()
                    : 18,
                userModel.user.preferences.hasAgeMax()
                    ? userModel.user.preferences.ageMax.toDouble()
                    : 40,
              ),
              max: 40,
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
