import 'dart:ui';

class Coordinates extends Offset {
  const Coordinates(
    super.dx,
    super.dy,
  );

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
    );
  }
}
