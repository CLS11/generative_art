import 'dart:ui';

class Particle {
  Offset position;
  Color color;
  double speed;
  double theta;
  double radius;

  Particle({
    required this.position,
    required this.color,
    required this.speed,
    required this.theta,
    required this.radius,
  });
}
