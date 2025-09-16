import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DotsMainButtonTheme {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? foregroundSecondaryColor;
  final DotsStyleColorGradient? backgroundGradient;
  final DotsStyleColorGradient? foregroundGradient;
  final DotsStyleType? blurStyle;

  final bool shadow;

  const DotsMainButtonTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.foregroundSecondaryColor,
    this.backgroundGradient,
    this.foregroundGradient,
    this.blurStyle,
    this.shadow = false,
  });
}

DotsMainButtonTheme getButtonThemeByButtonVariant(
    DotsTheme theme, DotsMainButtonVariant variant, DotsMainButtonSize size) {
  switch (variant) {
    case DotsMainButtonVariant.main:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.labelHighlight,
        foregroundColor: theme.colors.labelAlwaysWhite,
        foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
      );
    case DotsMainButtonVariant.secondary:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.bgSecondaryBtn,
        foregroundColor: theme.colors.textSecondary,
        foregroundSecondaryColor: theme.colors.textSecondary.dotsWithOpacity(0.6),
        blurStyle: theme.styles.blur50,
      );
    case DotsMainButtonVariant.secondaryPremium:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.bgContainerSecondaryOnBackground,
        foregroundGradient: theme.styles.textPremium,
      );
    case DotsMainButtonVariant.secondaryPremiumPlus:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.bgContainerSecondaryOnBackground,
        foregroundGradient: theme.styles.textPremiumPlus,
      );
    case DotsMainButtonVariant.secondaryLight:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.bgFloatingBtn,
        foregroundColor: theme.colors.labelAlwaysWhite,
        foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
        blurStyle: theme.styles.blur50,
      );
    case DotsMainButtonVariant.secondaryDark:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.bgBtnImage,
        foregroundColor: theme.colors.textSecondary,
        foregroundSecondaryColor: theme.colors.textSecondary.dotsWithOpacity(0.6),
        blurStyle: theme.styles.blur50,
        shadow: true,
      );
    case DotsMainButtonVariant.destructive:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.labelDestructive,
        foregroundColor: theme.colors.labelAlwaysWhite,
        foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
      );
    case DotsMainButtonVariant.disabled:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.bgContainerSecondaryOnBackground,
        foregroundColor: theme.colors.textQuarternary,
        foregroundSecondaryColor: theme.colors.textQuarternary.dotsWithOpacity(0.6),
        blurStyle: theme.styles.blur50,
      );
    case DotsMainButtonVariant.ghost:
      return DotsMainButtonTheme(
        foregroundColor: theme.colors.labelHighlight,
        foregroundSecondaryColor: theme.colors.labelHighlight.dotsWithOpacity(0.6),
      );
    case DotsMainButtonVariant.premiumPlus:
      if (size.isMainAction) {
        return DotsMainButtonTheme(
          foregroundColor: theme.colors.labelAlwaysWhite,
          foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
          backgroundGradient: theme.styles.bgPremiumPlus,
        );
      }
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.bgBtnImage,
        foregroundGradient: theme.styles.bgPremiumPlus,
        blurStyle: theme.styles.blur50,
        shadow: true,
      );
    case DotsMainButtonVariant.premium:
      if (size.isMainAction) {
        return DotsMainButtonTheme(
          foregroundColor: theme.colors.labelAlwaysWhite,
          foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
          backgroundGradient: theme.styles.bgPremium,
        );
      }
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.bgBtnImage,
        foregroundGradient: theme.styles.bgPremium,
        blurStyle: theme.styles.blur50,
        shadow: true,
      );
    case DotsMainButtonVariant.surfacePremium:
      return DotsMainButtonTheme(
        foregroundGradient: theme.styles.textPremium,
        backgroundColor: theme.colors.bgContainerSecondary,
        blurStyle: theme.styles.blur10,
      );
  }
}
