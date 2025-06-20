import 'dart:ui';

import 'dots_style_type.dart';

class DotsStyleColorDodge implements DotsStyleType {
  final Color colorToDodge;
  final Color mainColor;
  final double blur;

  const DotsStyleColorDodge({
    required this.colorToDodge,
    required this.mainColor,
    required this.blur,
  });

  @override
  DotsStyleColorDodge? lerp(DotsStyleType? other, double t) {
    if (other is DotsStyleColorDodge) {
      return DotsStyleColorDodge(
        colorToDodge: Color.lerp(colorToDodge, other.colorToDodge, t) ?? colorToDodge,
        mainColor: Color.lerp(mainColor, other.mainColor, t) ?? mainColor,
        blur: lerpDouble(blur, other.blur, t) ?? blur,
      );
    } else {
      return null;
    }
  }
}
