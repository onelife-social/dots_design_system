import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class BadgeLabelTheme {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final DotsStyleColorGradient? backgroundGradient;
  final DotsStyleColorGradient? foregroundGradient;

  final bool blur;

  const BadgeLabelTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundGradient,
    this.foregroundGradient,
    this.blur = true,
  });
}

BadgeLabelTheme getBadgeLabelThemeByTagVariant(DotsTheme theme, BadgeLabelVariant variant) {
  switch (variant) {
    case BadgeLabelVariant.main:
      return BadgeLabelTheme(
        backgroundColor: theme.colors.labelHighlight,
        foregroundColor: theme.colors.labelAlwaysWhite,
      );
    case BadgeLabelVariant.secondary:
      return BadgeLabelTheme(
        backgroundColor: theme.colors.bgHighlight,
        foregroundColor: theme.colors.labelHighlight,
      );
    case BadgeLabelVariant.green:
      return BadgeLabelTheme(
        backgroundColor: theme.colors.labelActive,
        foregroundColor: theme.colors.labelAlwaysWhite,
      );
    case BadgeLabelVariant.premiumPlus:
      return BadgeLabelTheme(
        foregroundColor: theme.colors.labelAlwaysWhite,
        backgroundGradient: theme.styles.bgPremiumPlus,
      );
    case BadgeLabelVariant.premium:
      return BadgeLabelTheme(
        backgroundGradient: theme.styles.bgPremium,
        foregroundColor: theme.colors.labelAlwaysWhite,
      );
  }
}
