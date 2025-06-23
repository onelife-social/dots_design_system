import 'package:flutter/widgets.dart';

import 'dots_style_type.dart';

/// Creates a style that applies a color gradient effect with [startColor] and [endColor].
/// The [beginAlignment] and [endAlignment] parameters control the direction of the gradient.
class DotsStyleColorGradient implements DotsStyleType {
  final Color startColor;
  final Color endColor;

  final Alignment beginAlignment;
  final Alignment endAlignment;
  const DotsStyleColorGradient({
    required this.startColor,
    required this.endColor,
    this.beginAlignment = const Alignment(0.00, 0.50),
    this.endAlignment = const Alignment(1.00, 0.50),
  });

  @override
  DotsStyleColorGradient? lerp(DotsStyleType? other, double t) {
    if (other is DotsStyleColorGradient) {
      return DotsStyleColorGradient(
        startColor: Color.lerp(startColor, other.startColor, t) ?? startColor,
        endColor: Color.lerp(endColor, other.endColor, t) ?? endColor,
        beginAlignment: Alignment.lerp(beginAlignment, other.beginAlignment, t) ?? beginAlignment,
        endAlignment: Alignment.lerp(endAlignment, other.endAlignment, t) ?? endAlignment,
      );
    } else {
      return null;
    }
  }
}
