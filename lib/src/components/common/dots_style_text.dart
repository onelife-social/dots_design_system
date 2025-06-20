import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsStyleText extends StatelessWidget {
  const DotsStyleText({
    super.key,
    this.styleType,
    required this.text,
    this.style,
    this.textAlign,
  });

  final DotsStyleType? styleType;
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    final styleType = this.styleType;
    if (styleType is DotsStyleColorGradient) {
      return ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [styleType.startColor, styleType.endColor],
            begin: styleType.beginAlignment,
            end: styleType.endAlignment,
          ).createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          );
        },
        child: Text(
          text,
          style: (style ?? TextStyle()).copyWith(color: Colors.white),
          textAlign: textAlign,
        ),
      );
    } else {
      return Text(
        text,
        style: style,
        textAlign: textAlign,
      );
    }
  }
}
