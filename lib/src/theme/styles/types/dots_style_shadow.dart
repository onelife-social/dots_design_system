import 'dart:ui';

import 'dots_style_type.dart';

/// Creates a style for a shadow effect.
class DotsStyleShadow implements DotsStyleType {
  final Color color;
  final Offset offset;

  final double blurRadius;
  final double spreadRadius;
  final BlurStyle blurStyle;
  const DotsStyleShadow({
    required this.color,
    this.offset = Offset.zero,
    required this.blurRadius,
    this.spreadRadius = 0,
    this.blurStyle = BlurStyle.normal,
  });

  @override
  DotsStyleShadow? lerp(DotsStyleType? other, double t) {
    if (other is DotsStyleShadow) {
      return DotsStyleShadow(
        color: Color.lerp(color, other.color, t) ?? color,
        offset: Offset.lerp(offset, other.offset, t) ?? offset,
        blurRadius: lerpDouble(blurRadius, other.blurRadius, t) ?? blurRadius,
        spreadRadius: lerpDouble(spreadRadius, other.spreadRadius, t) ?? spreadRadius,
        blurStyle: t < 0.5 ? other.blurStyle : blurStyle,
      );
    } else {
      return null;
    }
  }
}
