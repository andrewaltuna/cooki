import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MapPainter extends CustomPainter {
  const MapPainter({
    required this.directions,
  });

  final List<Coordinates> directions;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the store layout
    final paint = Paint()
      ..color = AppColors.backgroundSecondary
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw grid
    _drawGrid(canvas, size);

    // Draw center cross
    _drawCenterCross(canvas, size);

    // Draw directions
    _drawDirections(canvas, size);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const double step = 20.0; // Grid cell size

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw vertical lines from the center
    for (double x = centerX; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double x = centerX; x >= 0; x -= step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    // Draw horizontal lines from the center
    for (double y = centerY; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (double y = centerY; y >= 0; y -= step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  void _drawCenterCross(Canvas canvas, Size size) {
    final crossPaint = Paint()
      ..color = Colors.red // Different color for the center cross
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw horizontal line
    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      crossPaint,
    );

    // Draw vertical line
    canvas.drawLine(
      Offset(centerX, 0),
      Offset(centerX, size.height),
      crossPaint,
    );
  }

  void _drawDirections(Canvas canvas, Size size) {
    if (directions.isEmpty) return;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final directionPaint = Paint()
      ..color = Colors.blue // Color for the direction lines
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
