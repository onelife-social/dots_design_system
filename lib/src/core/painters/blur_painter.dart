import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class BlurPainter extends CustomPainter {
  final ui.Image? image;
  final ui.FragmentProgram program;
  final double sigma;

  const BlurPainter({this.image, required this.program, required this.sigma})
      : assert(sigma >= 0 && sigma <= 5.0, 'Sigma must be between 0 and 5');

  @override
  void paint(Canvas canvas, Size size) {
    if (image == null) return;

    final shader = program.fragmentShader();
    shader
      ..setImageSampler(0, image!)
      ..setFloat(0, sigma)
      ..setFloat(1, size.width)
      ..setFloat(2, size.height);

    final paint = Paint()..shader = shader;

    // Draw only the cropped part under this widget
    final rect = Offset.zero & size;
    canvas.saveLayer(rect, paint);
    canvas.drawRect(
      /*image!,
      rect, // Crop this part from full image
      rect, // Draw to same size
      paint,*/
      rect,
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant BlurPainter oldDelegate) {
    return image != oldDelegate.image || sigma != oldDelegate.sigma;
  }
}
