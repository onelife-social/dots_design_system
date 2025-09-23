import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class DotsDecoratedBox extends StatelessWidget {
  const DotsDecoratedBox(
      {super.key, this.styleType, required this.child, this.decoration = const BoxDecoration()});

  /// The style type for the decorated box, which can be used to apply specific styles.
  ///
  /// If null, the default decoration will be used.
  ///
  /// Supported style types include:
  /// - [DotsStyleColorDodge]: Applies a color dodge effect with a blur.
  /// - [DotsStyleColorGradient]: Applies a linear gradient.
  /// - [DotsStyleBlur]: Applies a blur effect.
  final DotsStyleType? styleType;

  /// The child widget to be decorated.
  final Widget child;

  /// The decoration to apply to the box.
  final Decoration decoration;

  @override
  Widget build(BuildContext context) {
    final styleType = this.styleType;
    Decoration decoration = this.decoration;
    if (decoration is BoxDecoration) {
      decoration = ShapeDecoration.fromBoxDecoration(decoration);
    }

    if (decoration is! ShapeDecoration) {
      throw Exception('Decoration must be a ShapeDecoration or BoxDecoration');
    }

    if (styleType is DotsStyleColorDodge) {
      return _DotsDecoratedBoxClipper(
        shape: decoration.shape,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: styleType.blur, sigmaY: styleType.blur),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              styleType.colorToDodge,
              BlendMode.colorDodge,
            ),
            child: ColoredBox(
              color: styleType.mainColor,
              child: DecoratedBox(
                decoration: decoration,
                child: child,
              ),
            ),
          ),
        ),
      );
    }

    if (styleType is DotsStyleColorGradient) {
      return DecoratedBox(
        decoration: ShapeDecoration(
            shape: decoration.shape,
            color: decoration.color,
            image: decoration.image,
            shadows: decoration.shadows,
            gradient: LinearGradient(
              colors: [styleType.startColor, styleType.endColor],
              begin: styleType.beginAlignment,
              end: styleType.endAlignment,
            )),
        child: child,
      );
    }

    if (styleType is DotsStyleBlur) {
      return _DotsDecoratedBoxClipper(
        shape: decoration.shape,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: styleType.blur, sigmaY: styleType.blur),
          blendMode: BlendMode.src,
          child: child,
        ),
      );
    }
    if (styleType is DotsStyleShadow) {
      return DecoratedBox(
        decoration: ShapeDecoration(
          shape: decoration.shape,
          color: decoration.color,
          image: decoration.image,
          shadows: [
            BoxShadow(
              color: styleType.color,
              blurRadius: styleType.blurRadius,
              offset: styleType.offset,
              spreadRadius: styleType.spreadRadius,
              blurStyle: styleType.blurStyle,
            ),
          ],
        ),
        child: child,
      );
    }
    if (styleType is DotsStyleSquircle) {
      return _DotsDecoratedBoxClipper(
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: styleType.radius,
            cornerSmoothing: styleType.cornerSmoothing,
          ),
        ),
        child: DecoratedBox(
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: styleType.radius,
                cornerSmoothing: styleType.cornerSmoothing,
              ),
            ),
            color: decoration.color,
            image: decoration.image,
            gradient: decoration.gradient,
            shadows: decoration.shadows,
          ),
          child: child,
        ),
      );
    }
    return DecoratedBox(
      decoration: decoration,
      child: child,
    );
  }
}

class _DotsDecoratedBoxClipper extends StatelessWidget {
  const _DotsDecoratedBoxClipper({
    required this.shape,
    required this.child,
  });

  final ShapeBorder shape;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShapeBorderClipper(
        shape: shape,
      ),
      child: child,
    );
  }
}
