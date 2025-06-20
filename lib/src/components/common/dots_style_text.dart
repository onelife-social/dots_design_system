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

  /// Creates a text widget with optional style type and text alignment.
  final DotsStyleType? styleType;

  /// The style type for the text, which can be used to apply specific styles.
  final String text;

  /// The text to display.
  ///
  /// If null, the default text style will be used.
  final TextStyle? style;

  /// The text alignment for the text.
  ///
  /// If null, the default text alignment will be used.
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
