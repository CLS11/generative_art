import 'dart:math';

import 'package:flutter/material.dart';
import 'package:generative_art/particle.dart';

Offset PolarToCartersian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

class MyPainterCanvas extends CustomPainter {
  List<Particle> particles;
  final Random rgn = Random();
  MyPainterCanvas(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    //Update the objects
    this.particles.forEach((p) {
      var velocity = PolarToCartersian(p.speed, p.theta);
      var dx = p.position.dx + velocity.dx;
      var dy = p.position.dy + velocity.dy;

      //If either of the position falls out of canvas
      //Re-initialise them
      if (p.position.dx < 0 || p.position.dx > size.width) {
        dx = rgn.nextDouble() * size.width;
      }
      if (p.position.dy < 0 || p.position.dy > size.height) {
        dy = rgn.nextDouble() * size.height;
      }
      p.position = Offset(dx, dy);
    });
    //Paint the objects
    this.particles.forEach((p) {
      var paint = Paint();
      paint.color = Colors.red;
      canvas.drawCircle(p.position, p.radius, paint);
    });

    final dx = size.width / 2;
    final dy = size.height / 2;

    final c = Offset(dx, dy);
    const radius = 100.0;

    final paint = Paint()..color = Colors.red;

    canvas.drawCircle(c, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
