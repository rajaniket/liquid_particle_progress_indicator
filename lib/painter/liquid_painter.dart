import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// A custom painter that creates a liquid-like animation using a sine wave.
class LiquidPainter extends CustomPainter {
  final double value;
  final double maxValue;

  /// Creates a [LiquidPainter] with the given [value] and [maxValue].
  LiquidPainter(this.value, this.maxValue);

  @override
  void paint(Canvas canvas, Size size) {
    double diameter = size.height;
    double radius = size.height / 2;

    // Defining coordinate points. The wave starts from the bottom and ends at the top as the value changes.
    double pointX = 0;
    double pointY = diameter - ((diameter + 10) * (value / maxValue)); // 10 is an extra offset added to fill the circle completely

    Path path = Path();
    path.moveTo(pointX, pointY);

    // Amplitude: the height of the sine wave
    double amplitude = 10;

    // Period: the time taken to complete one full cycle of the sine wave.
    // f = 1/p, the more the value of the period, the higher the frequency.
    double period = value / maxValue;

    // Phase Shift: the horizontal shift of the sine wave along the x-axis.
    double phaseShift = value * pi * 1.4;

    // Plotting the sine wave by connecting various paths till it reaches the diameter.
    // Using this formula: y = A * sin(ωt + φ) + C
    for (double i = 0; i <= diameter; i++) {
      path.lineTo(
        i + pointX,
        pointY + amplitude * sin((i * 2.1 * period * pi / diameter) + phaseShift),
      );
    }

    // Plotting a vertical line which connects the right end of the sine wave.
    path.lineTo(pointX + diameter, diameter);
    // Plotting a vertical line which connects the left end of the sine wave.
    path.lineTo(pointX, diameter);
    // Closing the path.
    path.close();

    Paint paint = Paint()
      ..shader = SweepGradient(
        colors: gradientColors,
        startAngle: -pi / 2,
        endAngle: 3 * pi / 2,
        tileMode: TileMode.repeated,
      ).createShader(Rect.fromCircle(center: Offset(radius, radius), radius: radius))
      ..style = PaintingStyle.fill;

    // Clipping rectangular-shaped path to Oval.
    Path circleClip = Path()..addOval(Rect.fromCenter(center: Offset(radius, radius), width: diameter, height: diameter));
    canvas.clipPath(circleClip, doAntiAlias: true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
