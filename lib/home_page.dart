import 'dart:math' show Random, pi;
import 'package:flutter/material.dart';
import 'package:generative_art/custom_painter.dart';
import 'package:generative_art/particle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Color getRandomColor(Random rgn) {
  var a = rgn.nextInt(256);
  var r = rgn.nextInt(256);
  var g = rgn.nextInt(256);
  var b = rgn.nextInt(256);
  return Color.fromARGB(a, r, g, b);
}

const double maxRadius = 6;
const double maxSpeed = 0.2;
const double maxTheta = 2.0 * pi;

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late List<Particle> particles;
  late Animation<double> animation; // Make late
  late AnimationController controller; // Make late
  final Random rgn = Random();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();

    particles = List.generate(10, (index) {
      return Particle()
        ..color = getRandomColor(rgn)
        ..position = Offset(rgn.nextDouble() * 400, rgn.nextDouble() * 400)
        ..speed = rgn.nextDouble() * maxSpeed
        ..theta = rgn.nextDouble() * maxTheta
        ..radius = rgn.nextDouble() * maxRadius;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generative Art'),
      ),
      body: CustomPaint(
        painter: Painter(particles),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
