import 'package:flutter/material.dart';

class LinearBlurPainter extends CustomPainter {
  final Color topColor;
  final Color bottomColor;
  final BlurStyle blurStyle;
  final double sigma;

  LinearBlurPainter({
    required this.topColor,
    required this.bottomColor,
    this.blurStyle = BlurStyle.solid,
    this.sigma = 100,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          topColor,
          bottomColor,
        ],
      ).createShader(rect);

    paint.maskFilter = MaskFilter.blur(
      blurStyle,
      sigma,
    );

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
