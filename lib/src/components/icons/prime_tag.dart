import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class PrimeTag extends StatelessWidget {

  /// Creates a PrimeTag widget.
  final double size;

  /// Optional child widget to display inside the tag.
  final double iconSize;

  const PrimeTag({
    Key? key,
    this.size = 24,
    this.iconSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Positioned(
      left: 0,
      top: 0,
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
              return  LinearGradient(
                  colors: [
                    DotsColors.light.gradientInitialLinealPurple,
                    DotsColors.light.gradientFinalLinealPurple,
                  ],
                  stops: const [0.0, 1.0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    .createShader(bounds);
            },
            child: DotsIcon(
              iconData: DotsIconData.prime1,
              color: Colors.white, 
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}