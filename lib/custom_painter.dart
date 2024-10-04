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
    // Update the particles
    for (var p in particles) {
      var velocity = polarToCartesian(p.speed, p.theta);
      p.position += velocity;

      // Check boundaries and reinitialize if necessary
      if (p.position.dx < 0 || p.position.dx > size.width) {
        p.position = Offset(rgn.nextDouble() * size.width, p.position.dy);
      }
      if (p.position.dy < 0 || p.position.dy > size.height) {
        p.position = Offset(p.position.dx, rgn.nextDouble() * size.height);
      }

      // Paint the particle
      final paint = Paint()..color = p.color;
      canvas.drawCircle(p.position, p.radius, paint);
    }

    
    var center = Offset(size.width / 2, size.height / 2);
    var centerRadius = 100.0;
    var centerPaint = Paint()..color = Colors.blueGrey;
    canvas.drawCircle(center, centerRadius, centerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; 
  }
}
