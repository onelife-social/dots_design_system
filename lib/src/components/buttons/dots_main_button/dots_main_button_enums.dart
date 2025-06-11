import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

enum DotsMainButtonSize {
  mainAction(
    padding: EdgeInsets.symmetric(horizontal: 24),
    height: 52,
    spacing: 6,
  ),
  large(
    padding: EdgeInsets.symmetric(horizontal: 32),
    height: 44,
    spacing: 4,
  ),
  medium(
    padding: EdgeInsets.symmetric(horizontal: 20),
    height: 36,
    spacing: 4,
  ),
  small(
    padding: EdgeInsets.symmetric(horizontal: 16),
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
  secondaryLight,
  secondaryDark,
  destructive,
  disabled,
  ghost,
  premium;

  bool get isMain => this == DotsMainButtonVariant.main;
  bool get isSecondary => this == DotsMainButtonVariant.secondary;
  bool get isSecondaryLight => this == DotsMainButtonVariant.secondaryLight;
  bool get isSecondaryDark => this == DotsMainButtonVariant.secondaryDark;
  bool get isDestructive => this == DotsMainButtonVariant.destructive;
  bool get isDisabled => this == DotsMainButtonVariant.disabled;
  bool get isGhost => this == DotsMainButtonVariant.ghost;
  bool get isPremium => this == DotsMainButtonVariant.premium;
}
