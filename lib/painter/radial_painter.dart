import 'dart:math';
import 'package:flutter/material.dart';

class RadialProgressPainter extends CustomPainter {
  final double value;
  final List<Color> backgroundGradientColors;
  final double minValue;
  final double maxValue;

  // Constructor to initialize the RadialProgressPainter with required parameters.
  RadialProgressPainter({
    required this.value,
    required this.backgroundGradientColors,
    required this.minValue,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2;
    const double strokeWidth = 5;

    // Paint for the progress with gradient colors.
    final Paint progressPaint = Paint()
      ..shader = SweepGradient(
        colors: backgroundGradientColors,
        startAngle: -pi / 2,
        endAngle: 3 * pi / 2,
        tileMode: TileMode.repeated,
      ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Paint for the progress track.
    final Paint progressTrackPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Progress start angle is at the top (-pi/2 in radians).
    double startAngle = -pi / 2;
    // Progress end angle to complete a full cycle (2pi radians).
    double sweepAngle = 2 * pi * value / maxValue;

    // Drawing track.
    canvas.drawCircle(Offset(centerX, centerY), radius, progressTrackPaint);
    // Drawing progress.
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
