import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class CardTag extends StatelessWidget {
  /// Size of the tag.
  final double size;

  /// Icon to display inside the tag.
  final DotsIconData iconData;

  /// Size of the icon inside the tag.
  final double iconSize;

  const CardTag({
    Key? key,
    this.size = 24,
    this.iconSize = 16,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
        child: Container(
          width: size,
          height: size,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: theme.colors.bgToastLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size),
            ),
          ),
          child: Center(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    DotsColors.light.gradientInitialLinealPurple,
                    DotsColors.light.gradientFinalLinealPurple,
                  ],
                  stops: const [0.0, 1.0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: DotsIcon(
                iconData: iconData,
                color: Colors.white,
                size: iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
