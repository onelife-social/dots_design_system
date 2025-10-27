import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

enum DotsMainButtonSize {
  mainAction(
    padding: EdgeInsets.symmetric(horizontal: 24),
    height: 52,
    spacing: 6,
  ),
  large(
    padding: EdgeInsets.symmetric(horizontal: 20),
    height: 44,
    spacing: 4,
  ),
  medium(
    padding: EdgeInsets.symmetric(horizontal: 16),
    height: 36,
    spacing: 4,
  ),
  small(
    padding: EdgeInsets.symmetric(horizontal: 12),
    height: 28,
    spacing: 4,
  );

  final EdgeInsetsGeometry padding;
  final double height;
  final double spacing;

  bool get isMainAction => this == DotsMainButtonSize.mainAction;
  bool get isLarge => this == DotsMainButtonSize.large;
  bool get isMedium => this == DotsMainButtonSize.medium;
  bool get isSmall => this == DotsMainButtonSize.small;

  const DotsMainButtonSize({required this.padding, required this.height, required this.spacing});

  TextStyle getTextStyle(DotsTheme theme) {
    switch (this) {
      case DotsMainButtonSize.mainAction:
      case DotsMainButtonSize.large:
        return theme.typo.main.bodyDefaultMedium;
      case DotsMainButtonSize.medium:
        return theme.typo.main.labelDefaultBold;
      case DotsMainButtonSize.small:
        return theme.typo.main.labelSmallMedium;
    }
  }
}

enum DotsMainButtonVariant {
  main,
  secondary,
  secondaryPremium,
  secondaryPremiumPlus,
  secondaryLight,
  secondaryDark,
  destructive,
  disabled,
  ghost,
  premiumPlus,
  premium,
  surfacePremium,
  surfacePremiumPlus;

  bool get isMain => this == DotsMainButtonVariant.main;
  bool get isSecondary => this == DotsMainButtonVariant.secondary;
  bool get isSecondaryPremium => this == DotsMainButtonVariant.secondaryPremium;
  bool get isSecondaryPremiumPlus => this == DotsMainButtonVariant.secondaryPremiumPlus;
  bool get isSecondaryLight => this == DotsMainButtonVariant.secondaryLight;
  bool get isSecondaryDark => this == DotsMainButtonVariant.secondaryDark;
  bool get isDestructive => this == DotsMainButtonVariant.destructive;
  bool get isDisabled => this == DotsMainButtonVariant.disabled;
  bool get isGhost => this == DotsMainButtonVariant.ghost;
  bool get isPremium => this == DotsMainButtonVariant.premium;
  bool get isPremiumPlus => this == DotsMainButtonVariant.premiumPlus;
  bool get isSurfacePremium => this == DotsMainButtonVariant.surfacePremium;
  bool get isSurfacePremiumPlus => this == DotsMainButtonVariant.surfacePremiumPlus;
}

enum DotsMainButtonIconPosition {
  left,
  right;

  bool get isLeft => this == DotsMainButtonIconPosition.left;
  bool get isRight => this == DotsMainButtonIconPosition.right;
}
