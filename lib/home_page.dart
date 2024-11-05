import 'dart:math';
import 'package:flutter/material.dart';
import 'package:generative_art/custom_painter.dart';
import 'package:generative_art/particle.dart';

class MyPainter extends StatefulWidget {
  const MyPainter({super.key});

  @override
  State<MyPainter> createState() => _MyPainterState();
}

Color getRandomColor(Random rgn) {
  var a = rgn.nextInt(256);
  var r = rgn.nextInt(256);
  var g = rgn.nextInt(256);
  var b = rgn.nextInt(256);
  return Color.fromARGB(a, r, g, b);
}

double maxRadius = 6;
double maxSpeed = 0.2;
double maxTheta = 2.0 * pi;

class _MyPainterState extends State<MyPainter> {
  late List<Particle> particles;
  Random rgn = Random();

  @override
  void initState() {
    super.initState();
    particles = List.generate(10, (index) {
      return Particle(
        position: Offset(-1, -1), // Initial position can be set to a valid random value if needed
        color: getRandomColor(rgn),
        speed: rgn.nextDouble() * maxSpeed,
        theta: rgn.nextDouble() * maxTheta,
        radius: rgn.nextDouble() * maxRadius,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: CustomPaint(
            painter: MyPainterCanvas(particles),
            child: Container(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
