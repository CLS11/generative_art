import 'dart:ui';

import 'package:flutter/material.dart';

class Particle {
  Offset position;
  Color color;

  //Defining the velocity
  double speed;
  double theta;

  double radius;

  Particle({
    this.position = const Offset(0, 0),
    this.color = Colors.black,
    this.speed = 0.0,
    this.theta = 0.0,
    this.radius = 0.0,
  });
}
