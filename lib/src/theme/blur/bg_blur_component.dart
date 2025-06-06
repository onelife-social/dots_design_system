import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BgBlurComponent extends StatelessWidget {
  const BgBlurComponent(
      {super.key, required this.child, this.borderRadius = DotsBorderRadius.r100});

  final Widget child;
  final BorderRadiusGeometry borderRadius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: child,
      ),
    );
  }
}
