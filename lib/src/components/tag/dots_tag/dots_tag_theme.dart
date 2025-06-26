import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DotsTagTheme {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final DotsStyleColorGradient? backgroundGradient;
  final DotsStyleColorGradient? foregroundGradient;

  final bool blur;

  const DotsTagTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundGradient,
    this.foregroundGradient,
    this.blur = true,
  });
}

DotsTagTheme getTagThemeByTagVariant(DotsTheme theme, DotsTagVariant variant) {
  switch (variant) {
    case DotsTagVariant.main:
      return DotsTagTheme(
        backgroundColor: theme.colors.labelHighlight,
        foregroundColor: theme.colors.labelAlwaysWhite,
      );
    case DotsTagVariant.secondary:
      return DotsTagTheme(
        backgroundColor: theme.colors.bgHighlight,
        foregroundColor: theme.colors.labelHighlight,
      );
    case DotsTagVariant.green:
      return DotsTagTheme(
        backgroundColor: theme.colors.bgActive,
        foregroundColor: theme.colors.labelActive,
      );
    case DotsTagVariant.premiumPlus:
      return DotsTagTheme(
        foregroundColor: theme.colors.labelAlwaysWhite,
        backgroundGradient: theme.styles.bgPremiumPlus,
      );
    case DotsTagVariant.premium:
      return DotsTagTheme(
        backgroundGradient: theme.styles.bgPremium,
        foregroundColor: theme.colors.labelAlwaysWhite,
      );
  }
}
