import 'package:flutter/material.dart';

class SpaceshipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final spaceshipPaint = Paint()
      ..color = Colors.cyanAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    final spaceshipPath = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(spaceshipPath, spaceshipPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
