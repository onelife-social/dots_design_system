import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DotsCloseButtonTheme {
  final Color? backgroundColor;
  final Color foregroundColor;

  const DotsCloseButtonTheme({
    this.backgroundColor,
    required this.foregroundColor,
  });
}

DotsCloseButtonTheme getCloseButtonThemeByVariant(DotsTheme theme, DotsCloseButtonVariant variant) {
  switch (variant) {
    case DotsCloseButtonVariant.softContrast:
      return DotsCloseButtonTheme(
        backgroundColor: theme.colors.bgContainerSecondaryOnBackground,
        foregroundColor: theme.colors.textQuarternary,
      );
    case DotsCloseButtonVariant.highContrast:
      return DotsCloseButtonTheme(
        backgroundColor: theme.colors.bgSecondaryBtn,
        foregroundColor: theme.colors.textTertiary,
      );
    case DotsCloseButtonVariant.inverted:
      return DotsCloseButtonTheme(
        backgroundColor: theme.colors.textQuarternary,
        foregroundColor: theme.colors.bgContainerPrimary,
      );
  }
}
