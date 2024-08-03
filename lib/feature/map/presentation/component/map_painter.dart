import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:flutter/material.dart';

class MapDirectionsPainter extends CustomPainter {
  const MapDirectionsPainter({
    required this.directions,
  });

  final Directions directions;

  @override
  void paint(Canvas canvas, Size size) => _drawDirections(canvas, size);

  void _drawDirections(Canvas canvas, Size size) {
    if (directions.isEmpty) return;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final directionPaint = Paint()
      ..color = Colors.blue // Color for the direction lines
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < directions.length - 1; i++) {
      // Flip the y-coordinate and translate to center
      final point1 = Offset(
        directions[i].dx + centerX,
        centerY - directions[i].dy,
      );
      final point2 = Offset(
        directions[i + 1].dx + centerX,
        centerY - directions[i + 1].dy,
      );

      canvas.drawLine(point1, point2, directionPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
