import 'package:flutter/material.dart';

class MapPainter extends CustomPainter {
  const MapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the store layout
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw grid
    _drawGrid(canvas, size);

    // Draw center cross
    _drawCenterCross(canvas, size);
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
        Offset(0, centerY), Offset(size.width, centerY), crossPaint);

    // Draw vertical line
    canvas.drawLine(
        Offset(centerX, 0), Offset(centerX, size.height), crossPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
