import 'package:flutter/material.dart';

/// Creating a controller to control the particle animation
class ParticleController extends ChangeNotifier {
  bool _isAnimating = false;

  bool get isAnimating => _isAnimating;

  /// Starts the particle animation.
  ///
  /// It will trigger the animation and update the [isAnimating] flag to true.
  void start() {
    _isAnimating = true;
    notifyListeners();
  }

  /// Stops the particle animation.
  ///
  /// It will reset the animation and update the [isAnimating] flag to false.
  void stop() {
    _isAnimating = false;
    notifyListeners();
  }
}
