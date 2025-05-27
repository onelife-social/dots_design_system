import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DotsButtonTheme {
  final Color? backgroundColor;
  final Color foregroundColor;
  final Color foregroundSecondaryColor;
  final Gradient? gradient;

  final double? blur;

  const DotsButtonTheme({
    this.backgroundColor,
    required this.foregroundColor,
    required this.foregroundSecondaryColor,
    this.gradient,
    this.blur,
  });
}

DotsButtonTheme getButtonThemeByButtonVariant(DotsTheme theme, DotsButtonVariant variant) {
  switch (variant) {
    case DotsButtonVariant.main:
      return DotsButtonTheme(
        backgroundColor: theme.colors.labelHighlight,
        foregroundColor: theme.colors.labelAlwaysWhite,
        foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
      );
    case DotsButtonVariant.secondary:
      return DotsButtonTheme(
        backgroundColor: theme.colors.bgSecondaryBtn,
        foregroundColor: theme.colors.textSecondary,
        foregroundSecondaryColor: theme.colors.textSecondary.dotsWithOpacity(0.6),
      );
    case DotsButtonVariant.secondaryLight:
      return DotsButtonTheme(
        backgroundColor: theme.colors.bgSecondaryBtnMaterialLight,
        foregroundColor: theme.colors.labelAlwaysWhite,
        foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
      );
    case DotsButtonVariant.secondaryDark:
      return DotsButtonTheme(
        backgroundColor: theme.colors.bgSecondaryBtnMaterialDark,
        foregroundColor: theme.colors.textSecondary,
        foregroundSecondaryColor: theme.colors.textSecondary.dotsWithOpacity(0.6),
      );
    case DotsButtonVariant.destructive:
      return DotsButtonTheme(
        backgroundColor: theme.colors.labelDestructive,
        foregroundColor: theme.colors.labelAlwaysWhite,
        foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
      );
    case DotsButtonVariant.disabled:
      return DotsButtonTheme(
        backgroundColor: theme.colors.bgBtnDisabled,
        foregroundColor: theme.colors.textQuarternary,
        foregroundSecondaryColor: theme.colors.textQuarternary.dotsWithOpacity(0.6),
      );
    case DotsButtonVariant.ghost:
      return DotsButtonTheme(
        foregroundColor: theme.colors.labelHighlight,
        foregroundSecondaryColor: theme.colors.labelHighlight.dotsWithOpacity(0.6),
      );
    case DotsButtonVariant.premium:
      return DotsButtonTheme(
        // TODO add background
        foregroundColor: theme.colors.labelAlwaysWhite,
        foregroundSecondaryColor: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.6),
      );
  }
}
