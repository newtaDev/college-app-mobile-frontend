import 'package:flutter/material.dart';

class DottedLines extends CustomPainter {
  final int dashWidth;
  final int dashSpace;
  final double strokeWidth;
  final Color color;

  DottedLines({
    this.dashWidth = 4,
    this.dashSpace = 4,
    this.strokeWidth = 1,
    this.color = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    _drawDashedLine(canvas, size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawDashedLine(Canvas canvas, Size size, Paint paint) {
    // Chage to your preferred size

    // Start to draw from left size.
    // Of course, you can change it to match your requirement.
    double startX = 0;
    final double y = size.height;

    // Repeat drawing until we reach the right edge.
    // In our example, size.with = 300 (from the SizedBox)
    while (startX < size.width) {
      // Draw a small line.
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);

      // Update the starting X
      startX += dashWidth + dashSpace;
    }
  }
}
