import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DotsSystemButtonTheme {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final DotsStyleType? blurStyle;

  const DotsSystemButtonTheme({
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.blurStyle,
  });
}

DotsSystemButtonTheme getSystemButtonThemeByVariant(
  DotsTheme theme,
  DotsSystemButtonVariant variant,
) {
  switch (variant) {
    case DotsSystemButtonVariant.active:
      return DotsSystemButtonTheme(
        backgroundColor: theme.colors.bgContainerSecondaryOnBackground,
        textColor: theme.colors.textPrimary,
        iconColor: theme.colors.textPrimary,
        blurStyle: theme.styles.blur50,
      );
    case DotsSystemButtonVariant.disabled:
      return DotsSystemButtonTheme(
        backgroundColor: theme.colors.bgContainerSecondaryOnBackground,
        textColor: theme.colors.textDisabled,
        iconColor: theme.colors.textDisabled,
        blurStyle: theme.styles.blur50,
      );
    case DotsSystemButtonVariant.destructive:
      return DotsSystemButtonTheme(
        backgroundColor: theme.colors.bgContainerSecondaryOnBackground,
        textColor: theme.colors.labelDestructive,
        iconColor: theme.colors.labelDestructive,
        blurStyle: theme.styles.blur50,
      );
  }
}
