import 'package:flutter/material.dart';
import 'dart:math'; // Untuk fungsi Random()

class CloudBackground extends StatelessWidget {
  const CloudBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CloudPainter(),
      child: Container(),
    );
  }
}

class _CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    // Gambar beberapa awan acak
    final random = Random();
    for (int i = 0; i < 5; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height * 0.6;
      _drawCloud(canvas, paint, Offset(x, y));
    }
  }

  void _drawCloud(Canvas canvas, Paint paint, Offset center) {
    canvas.drawCircle(center, 20, paint);
    canvas.drawCircle(center + const Offset(15, -10), 25, paint);
    canvas.drawCircle(center + const Offset(30, 0), 20, paint);
    canvas.drawCircle(center + const Offset(15, 10), 25, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}