import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

enum BadgeLabelSize {
  large(
    padding: EdgeInsets.symmetric(horizontal: 12),
    height: 34,
  ),
  medium(
    padding: EdgeInsets.symmetric(horizontal: 8),
    height: 22,
  ),
  small(
    padding: EdgeInsets.symmetric(horizontal: 8),
    height: 18,
  );

  final EdgeInsetsGeometry padding;
  final double height;

  bool get isMedium => this == BadgeLabelSize.medium;
  bool get isSmall => this == BadgeLabelSize.small;

  const BadgeLabelSize({required this.padding, required this.height});

  TextStyle getTextStyle(DotsTheme theme) {
    switch (this) {
      case BadgeLabelSize.large:
        return theme.typo.main.bodyDefaultMedium;
      case BadgeLabelSize.medium:
      case BadgeLabelSize.small:
        return theme.typo.main.labelSmallMedium;
    }
  }
}

enum BadgeLabelVariant {
  main,
  secondary,
  green,
  white,
  greenMaterial,
  warning,
  warningMaterial,
  red,
  premiumPlus,
  premium;

  bool get isMedium => this == BadgeLabelVariant.main;
  bool get isSecondary => this == BadgeLabelVariant.secondary;
  bool get isGreen => this == BadgeLabelVariant.green;
  bool get isWhite => this == BadgeLabelVariant.white;
  bool get isGreenMaterial => this == BadgeLabelVariant.greenMaterial;
  bool get isWarning => this == BadgeLabelVariant.warning;
  bool get isWarningMaterial => this == BadgeLabelVariant.warningMaterial;
  bool get isRed => this == BadgeLabelVariant.red;
  bool get isPremium => this == BadgeLabelVariant.premium;
  bool get isPremiumPlus => this == BadgeLabelVariant.premiumPlus;
}
