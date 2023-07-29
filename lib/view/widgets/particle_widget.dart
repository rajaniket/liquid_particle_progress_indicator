import 'dart:math';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../controllers/particle_controller.dart';
import '../../painter/particle_painter.dart';

class ParticleAnimation extends StatefulWidget {
  const ParticleAnimation({Key? key, required this.controller, this.maxAngle = pi, this.minAngle = 0, this.numberOfParticles = 300})
      : super(key: key);

  final ParticleController controller;
  final double minAngle;
  final double maxAngle;
  final int numberOfParticles;

  @override
  State<ParticleAnimation> createState() => _ParticleAnimationState();
}

class _ParticleAnimationState extends State<ParticleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List<ConfettiDot> particles = []; // Store all the particles for animation.

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
          widget.controller.stop(); // Stop the animation when it is completed or dismissed.
        }
      })
      ..addListener(() {
        setState(() {});
      });
    // Listen to the controller for any change.
    widget.controller.addListener(_onControllerChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.controller.removeListener(() {});
    widget.controller.removeListener(_onControllerChange);
    super.dispose();
  }

  void _onControllerChange() {
    if (widget.controller.isAnimating) {
      _generateParticles(); // Generate particles and start the animation.
      _animationController.forward();
    } else {
      particles.clear(); // Clear particles and reset the animation.
      _animationController.reset();
    }
  }

  // Generate particles with random angles and speeds.
  void _generateParticles() {
    particles.clear(); // Clear previously stored particles.
    for (int i = 0; i < widget.numberOfParticles; i++) {
      // Generate a random angle between minAngle and maxAngle.
      double randomAngle = widget.minAngle + Random().nextDouble() * (widget.maxAngle - widget.minAngle);
      // Generate a random speed between 800 to 2000.
      double speed = 800.0 + Random().nextDouble() * 1200.0;
      particles.add(
        ConfettiDot(
          angle: randomAngle,
          color: _getRandomColor(), // Get a random color for the particle.
          speed: speed, // Random speed between 800 and 2000.
        ),
      );
    }
  }

  // Generate random colors for particles.
  Color _getRandomColor() {
    List<Color> colors = gradientColors;
    return colors[Random().nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConfettiPainter(particles, _animationController.value), // Paint the confetti particles.
    );
  }
}
