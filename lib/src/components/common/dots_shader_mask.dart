import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// A widget that applies a shader mask to its child based on the provided [DotsStyleType].
class DotsShaderMask extends StatelessWidget {
  const DotsShaderMask({
    super.key,
    this.styleType,
    required this.child,
  });

  /// The style type for the shader mask, which can be used to apply specific styles.
  ///
  /// If null, no shader mask will be applied.
  final DotsStyleType? styleType;

  /// The child widget to be masked.
  final Widget child;
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
        child: child,
      );
    } else {
      return child;
    }
  }
}
