import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class BadgeLabelTheme {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final DotsStyleColorGradient? backgroundGradient;
  final DotsStyleColorGradient? foregroundGradient;
  final Color? borderColor;

  final bool blur;

  const BadgeLabelTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundGradient,
    this.foregroundGradient,
    this.borderColor,
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
    case BadgeLabelVariant.white:
      return BadgeLabelTheme(
        backgroundColor: theme.colors.bgContainerPrimary,
        foregroundColor: theme.colors.textPrimary,
        borderColor: theme.colors.borderButton,
      );
    case BadgeLabelVariant.greenMaterial:
      return BadgeLabelTheme(
        backgroundColor: theme.colors.bgActive,
        foregroundColor: theme.colors.labelActive,
      );
    case BadgeLabelVariant.red:
      return BadgeLabelTheme(
        backgroundColor: theme.colors.labelDestructive,
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
    case BadgeLabelVariant.warning:
      return BadgeLabelTheme(
        backgroundColor: theme.colors.labelWarning,
        foregroundColor: theme.colors.labelAlwaysWhite,
      );
    case BadgeLabelVariant.warningMaterial:
      return BadgeLabelTheme(
        backgroundColor: theme.colors.bgWarning,
        foregroundColor: theme.colors.labelWarning,
      );
  }
}
