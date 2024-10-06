import 'dart:math' show Random, cos, pi, sin;
import 'package:flutter/material.dart';
import 'package:generative_art/custom_painter.dart';
import 'package:generative_art/particle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Color getRandomColor(Random rgn) {
  final a = rgn.nextInt(256);
  final r = rgn.nextInt(256);
  final g = rgn.nextInt(256);
  final b = rgn.nextInt(256);
  return Color.fromARGB(a, r, g, b);
}

const double maxRadius = 6;
const double maxSpeed = 0.2;
const double maxTheta = 2.0 * pi;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late List<Particle> particles;
  late Animation<double> animation;
  late AnimationController controller;
  final Random rgn = Random();

  @override
  void initState() {
    super.initState();

    particles = List.generate(10, (index) {
      return Particle()
        ..color = getRandomColor(rgn)
        ..position = Offset(rgn.nextDouble() * 400, rgn.nextDouble() * 400)
        ..speed = rgn.nextDouble() * maxSpeed
        ..theta = rgn.nextDouble() * maxTheta
        ..radius = rgn.nextDouble() * maxRadius
        ..origin = Offset(rgn.nextDouble() * 400, rgn.nextDouble() * 400);
    });

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    animation = Tween<double>(begin: 0, end: 2 * pi).animate(controller)
      ..addListener(() {
        setState(updateBlobField);
      });

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*body: CustomPaint(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Slider(
              value: radiusFactor,
              min: 1.0,
              max: 10.0,
              onChanged: (v) {
                setState(() {
                  radiusFactor = v;
                });
              },
            ),
          ],
        ),
        painter: Painter(particles),
      ),*/
        );
  }

  void createBlobField() {
    // The size of screen
    final size = MediaQuery.of(context).size;
    // Center of the screen
    final o = Offset(size.width / 2, size.height / 2);
    // Number of blobs
    const n = 5;
    // Radius of the blob
    final r = size.width / n;
    // Alpha blending value
    const a = 0.2;
    blobField(r, n, a, o);
  }

  void blobField(double r, int n, double a, Offset o) {
    // Exit condition for recursive call
    if (r < 10) return;
    particles.add(Particle()
      ..radius = r
      ..position = o
      ..origin = o
      ..color = Colors.black);
    // Add orbital blobs
    var theta = 0.0; // Angle of the arc
    final dTheta = 2 * pi / n; // Angle between child blobs
    for (var i = 0; i < n; i++) {
      // Get position of the child blob
      final pos = polarToCartesian(r, theta) + o;
      particles.add(
        Particle()
          ..theta = theta
          ..radius = r / 3 // 1/3rd of the orbit radius
          ..position = pos
          ..origin = o
          ..color = getColor(i.toDouble() / n, a),
      );

      // Increase the angle
      theta += dTheta;
      const f = 0.5;
      blobField(r * f, n, a * 1.5, pos);
    }
  }

  double t = 0;
  double dt = 0.01;
  double radiusFactor = 10;

  void updateBlobField() {
    // Move the particles
    for (var p in particles) {
      p.position =
          polarToCartesian(p.radius * radiusFactor, p.theta + t) + p.origin;
    }
    t += dt;
    radiusFactor = mapRange(sin(t), -1, 1, 2, -10); // Increment time
  }

  double mapRange(
      double value, double min1, double max1, double min2, double max2) {
    double range1 = min1 - max1;
    double range2 = min2 - max2;
    return min2 + range2 * value / range1;
  }

  Color getColor(double d, double a) {
    final r = (sin(d * 2 * pi) * 127.0 + 127.0).toInt();
    final g = (cos(d * 2 * pi) * 127.0 + 127.0).toInt();
    final b = rgn.nextInt(256);
    return Color.fromARGB(255, r, g, b);
  }
}
