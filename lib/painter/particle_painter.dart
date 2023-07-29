import 'dart:math';
import 'package:flutter/material.dart';

class ConfettiPainter extends CustomPainter {
  List<ConfettiDot> particles;
  double progress;

  // Constructor to initialize the ConfettiPainter with particles and progress.
  ConfettiPainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw all the particles.
    for (var dot in particles) {
      dot.draw(canvas, size, progress);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ConfettiDot {
  double angle;
  double speed;
  Color color;

  // Constructor to create a ConfettiDot with angle, color, and speed.
  ConfettiDot({
    required this.angle,
    required this.color,
    required this.speed,
  });

  void draw(Canvas canvas, Size size, double progress) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double velocityX = speed * cos(angle);
    double velocityY = speed * sin(angle);
    double distanceX = progress * velocityX;
    double distanceY = progress * velocityY;
    // Calculating the new position based on angle and speed.
    // Shifting the x-coordinate to the top center.
    double positionX = distanceY;
    double positionY = size.width / 2 + distanceX;
    // Drawing particle
    canvas.drawCircle(Offset(positionY, positionX), 4, paint);
  }
}
