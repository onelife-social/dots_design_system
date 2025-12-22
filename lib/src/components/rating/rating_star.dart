import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum RatingIconVariant {
  disabled,
  detractor,
  neutral,
  promoter,
}

class DotsRatingStar extends StatelessWidget {
  // Number of stars
  final String text;

  // Variant of the star to select color gradient
  final RatingIconVariant variant;

  // Icon data by default star
  final DotsIconData? iconData;

  // Size of the icon
  final double iconSize;

  // Function to be executed on tap
  final Function()? onTap;

  const DotsRatingStar({
    super.key,
    required this.text,
    required this.variant,
    this.onTap,
    this.iconData,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: context.dotsTheme.typo.main.labelSmallMedium.copyWith(
              color: variant == RatingIconVariant.disabled
                  ? context.dotsTheme.colors.textDisabled
                  : context.dotsTheme.colors.textQuarternary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    _gradientTopColorForVariant(variant, context.dotsTheme),
                    _gradientBottomColorForVariant(variant, context.dotsTheme),
                  ],
                  stops: const [0.0, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              child: DotsIcon(
                iconData: iconData ?? DotsIconData.star,
                size: iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color _gradientTopColorForVariant(RatingIconVariant variant, DotsTheme theme) {
  switch (variant) {
    case RatingIconVariant.disabled:
      return theme.colors.textDisabled;
    case RatingIconVariant.detractor:
      return theme.colors.friends001;
    case RatingIconVariant.neutral:
      return theme.colors.class008;
    case RatingIconVariant.promoter:
      return theme.colors.family008;
  }
}

Color _gradientBottomColorForVariant(RatingIconVariant variant, DotsTheme theme) {
  switch (variant) {
    case RatingIconVariant.disabled:
      return theme.colors.textDisabled;
    case RatingIconVariant.detractor:
      return theme.colors.friends003;
    case RatingIconVariant.neutral:
      return theme.colors.friends005;
    case RatingIconVariant.promoter:
      return theme.colors.team007;
  }
}
