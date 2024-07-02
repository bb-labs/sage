import 'package:app/models/user.dart';

import 'package:flutter/material.dart';
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
                userModel.preferredAgeMin.toInt().toString(),
                userModel.preferredAgeMax.toInt().toString(),
              ),
            ),
            child: RangeSlider(
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
