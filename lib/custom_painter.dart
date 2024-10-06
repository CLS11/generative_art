import 'dart:math';
import 'package:flutter/material.dart';
import 'package:generative_art/particle.dart';

Offset polarToCartesian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

class Painter extends CustomPainter {
  Painter(this.particles);
  final List<Particle> particles;
  final Random rgn = Random();

  @override
  void paint(Canvas canvas, Size size) {
    particles.forEach(
      (p) {
        var paint = Paint();
        paint.blendMode = BlendMode.modulate;
        paint.color = p.color;
        canvas.drawCircle(p.position, p.radius, paint);
      },
    );
  }

  @override
  bool shouldRepaint(CustomPainter o) {
    return true;
  }
}
