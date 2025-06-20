import 'package:flutter/material.dart';

class DotsSquircleClipper extends StatelessWidget {
  const DotsSquircleClipper({
    Key? key,
    required this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    required this.child,
  }) : super(key: key);

  final BorderRadiusGeometry borderRadius;
  final Clip clipBehavior;
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
