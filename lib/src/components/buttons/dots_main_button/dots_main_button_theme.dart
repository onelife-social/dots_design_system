import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DotsMainButtonTheme {
  final Color? backgroundColor;
  final Color foregroundColor;
  final Color foregroundSecondaryColor;
  final Gradient? gradient;

  final bool blur;

  const DotsMainButtonTheme({
    this.backgroundColor,
    required this.foregroundColor,
    required this.foregroundSecondaryColor,
    this.gradient,
    this.blur = false,
  });
}

DotsMainButtonTheme getButtonThemeByButtonVariant(DotsTheme theme, DotsMainButtonVariant variant) {
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
        blur: true,
      );
    case DotsMainButtonVariant.secondaryLight:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.bgFloatingBtn,
        foregroundColor: theme.colors.labelAlwaysWhite,
        foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
        blur: true,
      );
    case DotsMainButtonVariant.secondaryDark:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.bgBtnImage,
        foregroundColor: theme.colors.textSecondary,
        foregroundSecondaryColor: theme.colors.textSecondary.dotsWithOpacity(0.6),
        blur: true,
      );
    case DotsMainButtonVariant.destructive:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.labelDestructive,
        foregroundColor: theme.colors.labelAlwaysWhite,
        foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
      );
    case DotsMainButtonVariant.disabled:
      return DotsMainButtonTheme(
        backgroundColor: theme.colors.bgBtnDisabled,
        foregroundColor: theme.colors.textQuarternary,
        foregroundSecondaryColor: theme.colors.textQuarternary.dotsWithOpacity(0.6),
        blur: true,
      );
    case DotsMainButtonVariant.ghost:
      return DotsMainButtonTheme(
        foregroundColor: theme.colors.labelHighlight,
        foregroundSecondaryColor: theme.colors.labelHighlight.dotsWithOpacity(0.6),
      );
    case DotsMainButtonVariant.premium:
      return DotsMainButtonTheme(
        // TODO add background
        foregroundColor: theme.colors.labelAlwaysWhite,
        foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
        blur: true,
      );
  }
}
