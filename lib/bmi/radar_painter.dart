import 'dart:math';

import 'package:flutter/material.dart';

class RadarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final center = Offset(size.width / 2, size.height / 2);
    final double maxRadius = min(size.width / 2, size.height / 2);

    // Draw concentric circles
    for (int i = 0; i < 5; i++) {
      double radius = maxRadius * (i + 1) / 5;
      canvas.drawCircle(center, radius, paint);
    }

    // Draw lines radiating from the center
    for (int i = 0; i < 12; i++) {
      double angle = (2 * pi * i) / 12;
      double startX = center.dx + maxRadius * cos(angle);
      double startY = center.dy + maxRadius * sin(angle);
      double endX = center.dx + maxRadius * 1.1 * cos(angle);
      double endY = center.dy + maxRadius * 1.1 * sin(angle);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
