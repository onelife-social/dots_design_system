import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

enum DotsTagSize {
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

  bool get isMedium => this == DotsTagSize.medium;
  bool get isSmall => this == DotsTagSize.small;

  const DotsTagSize({required this.padding, required this.height});

  TextStyle getTextStyle(DotsTheme theme) {
    switch (this) {
      case DotsTagSize.medium:
      case DotsTagSize.small:
        return theme.typo.main.labelSmallMedium;
    }
  }
}

enum DotsTagVariant {
  main,
  secondary,
  green,
  premiumPlus,
  premium;

  bool get isMedium => this == DotsTagVariant.main;
  bool get isSecondary => this == DotsTagVariant.secondary;
  bool get isGreen => this == DotsTagVariant.green;
  bool get isPremium => this == DotsTagVariant.premium;
  bool get isPremiumPlus => this == DotsTagVariant.premiumPlus;
}
