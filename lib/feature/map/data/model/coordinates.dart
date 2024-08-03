import 'dart:ui';

typedef Directions = List<Coordinates>;

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

  Map<String, dynamic> toJson() {
    return {
      'x': dx,
      'y': dy,
    };
  }

  Coordinates scaleTo(double scale) {
    return Coordinates(
      dx * scale,
      dy * scale,
    );
  }

  Coordinates scaleFrom(double scale) {
    return Coordinates(
      dx / scale,
      dy / scale,
    );
  }
}

extension OffsetExtension on Offset {
  Coordinates toCoordinates() {
    return Coordinates(dx, dy);
  }
}
