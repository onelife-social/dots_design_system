import 'dart:ui';

import 'dots_style_type.dart';

/// Creates a style that applies a blur effect with the specified [blur] value.
class DotsStyleBlur implements DotsStyleType {
  final double blur;

  const DotsStyleBlur({
    required this.blur,
  });

  @override
  DotsStyleBlur? lerp(DotsStyleType? other, double t) {
    if (other is DotsStyleBlur) {
      return DotsStyleBlur(
        blur: lerpDouble(blur, other.blur, t) ?? blur,
      );
    } else {
      return null;
    }
  }
}
