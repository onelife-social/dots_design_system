import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsDecoratedBox extends StatelessWidget {
  const DotsDecoratedBox(
      {super.key,
      this.styleType,
      required this.child,
      this.decoration = const BoxDecoration(),
      this.squircleClip = false});

  final bool squircleClip;
  final DotsStyleType? styleType;
  final Widget child;
  final BoxDecoration decoration;

  @override
  Widget build(BuildContext context) {
    final styleType = this.styleType;
    final borderRadius = decoration.borderRadius ?? BorderRadius.zero;
    if (styleType is DotsStyleColorDodge) {
      return _DotsDecoratedBoxClipperSelector(
        squircleClip: squircleClip,
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: styleType.blur, sigmaY: styleType.blur),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              styleType.colorToDodge,
              BlendMode.colorDodge,
            ),
            child: DecoratedBox(
              decoration: decoration.copyWith(
                color: styleType.mainColor,
                borderRadius: BorderRadius.zero,
              ),
              child: child,
            ),
          ),
        ),
      );
    }

    if (styleType is DotsStyleColorGradient) {
      return _DotsDecoratedBoxClipperSelector(
        squircleClip: squircleClip,
        borderRadius: borderRadius,
        child: DecoratedBox(
          decoration: decoration.copyWith(
            borderRadius: BorderRadius.zero,
            gradient: LinearGradient(
              colors: [styleType.startColor, styleType.endColor],
              begin: styleType.beginAlignment,
              end: styleType.endAlignment,
            ),
          ),
          child: child,
        ),
      );
    }

    if (styleType is DotsStyleBlur) {
      return _DotsDecoratedBoxClipperSelector(
        squircleClip: squircleClip,
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: styleType.blur, sigmaY: styleType.blur),
          child: child,
        ),
      );
    }
    return DecoratedBox(
      decoration: decoration,
    );
  }
}

class _DotsDecoratedBoxClipperSelector extends StatelessWidget {
  const _DotsDecoratedBoxClipperSelector({
    required this.squircleClip,
    required this.borderRadius,
    required this.child,
  });

  final bool squircleClip;
  final BorderRadiusGeometry borderRadius;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (squircleClip) {
      return DotsSquircleClipper(
        borderRadius: borderRadius,
        child: child,
      );
    } else {
      return ClipRRect(
        borderRadius: borderRadius,
        child: child,
      );
    }
  }
}
