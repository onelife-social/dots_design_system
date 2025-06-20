import 'package:flutter/material.dart';

class DotsSquircleClipper extends StatelessWidget {
  const DotsSquircleClipper({
    super.key,
    required this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    required this.child,
  });

  /// Creates a squircle clipper with the specified [borderRadius].
  final BorderRadiusGeometry borderRadius;

  /// The clip behavior to use when clipping the child.
  final Clip clipBehavior;

  /// The child widget to be clipped.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipBehavior: clipBehavior,
      clipper: ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
      child: child,
    );
  }
}
