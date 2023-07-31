import 'dart:math';
import 'package:flutter/material.dart';

class ParticlePainter extends CustomPainter {
  List<Particle> particles;
  double progress;

  // Constructor to initialize the ParticlePainter with particles and progress.
  ParticlePainter(this.particles, this.progress);

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

class Particle {
  double angle;
  double speed;
  Color color;

  // Constructor to create a Particle with angle, color, and speed.
  Particle({
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
    // Shifting the coordinate to the center.
    double positionX = size.width / 2 + distanceY;
    double positionY = size.width / 2 + distanceX;
    // Drawing particle
    canvas.drawCircle(Offset(positionY, positionX), 4, paint);
  }
}
