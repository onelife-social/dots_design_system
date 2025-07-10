import 'dart:ui';

import 'dots_style_type.dart';

/// Creates a style that applies the squircle effect to the border
class DotsStyleSquircle implements DotsStyleType {
  // Radius of the squircle corner
  final double radius;

  /// Smoothing factor for the corners of the squircle.
  /// A value between 0.0 and 1.0, where 0.0 is a sharp corner and 1.0 is a fully rounded corner.
  /// Default value is 0.5.
  final double cornerSmoothing;

  const DotsStyleSquircle({
    required this.radius,
    this.cornerSmoothing = 0.5,
  });

  @override
  DotsStyleSquircle? lerp(DotsStyleType? other, double t) {
    if (other is DotsStyleSquircle) {
      return DotsStyleSquircle(
        radius: lerpDouble(radius, other.radius, t) ?? radius,
      );
    } else {
      return null;
    }
  }
}
