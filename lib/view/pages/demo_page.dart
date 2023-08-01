import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../controllers/particle_controller.dart';
import '../../painter/liquid_painter.dart';
import '../../painter/radial_painter.dart';
import '../widgets/particle_widget.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ParticleController _particleController = ParticleController();
  bool isPlaying = false;
  int maxDuration = 10;
  bool isParticlesReady = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: maxDuration))
      ..addListener(() {
        if (isParticlesReady && _controller.value * maxDuration >= maxDuration - 0.2) {
          isParticlesReady = false;
          _particleController.start();
        }
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isPlaying = false;
        }
        if (status == AnimationStatus.forward) {
          isParticlesReady = true;
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double val = (_controller.value * maxDuration);
    return Scaffold(
      backgroundColor: const Color(0xFF232424),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                (val.toInt() * 10).toString(),
                style: const TextStyle(color: Colors.white, fontSize: 50),
              ),
              Text(
                ".${val.toStringAsFixed(1).substring(val.toString().indexOf(".") + 1)}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ParticleAnimation(
                        controller: _particleController,
                        numberOfParticles: 1500,
                        minAngle: 0,
                        maxAngle: 2 * 3.14,
                        minSpeed: 700,
                        maxSpeed: 7000,
                        duration: const Duration(seconds: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CustomPaint(
                          painter: LiquidPainter(
                            _controller.value * maxDuration,
                            maxDuration.toDouble(),
                          ),
                        ),
                      ),
                      CustomPaint(
                          painter: RadialProgressPainter(
                        value: _controller.value * maxDuration,
                        backgroundGradientColors: gradientColors,
                        minValue: 0,
                        maxValue: maxDuration.toDouble(),
                      )),
                    ],
                  ),
                );
              }),
          const SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white54,
                  width: 2,
                ),
                shape: BoxShape.circle),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isPlaying) {
                    _controller.reset();
                  } else {
                    _controller.reset();
                    _controller.forward();
                  }
                  isPlaying = !isPlaying;
                });
              },
              child: AnimatedContainer(
                height: isPlaying ? 25 : 60,
                width: isPlaying ? 25 : 60,
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isPlaying ? 4 : 100),
                  color: Colors.white54,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
