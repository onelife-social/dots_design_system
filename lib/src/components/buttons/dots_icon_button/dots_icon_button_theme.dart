import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DotsIconButtonTheme {
  final Color? backgroundColor;
  final Color foregroundColor;

  const DotsIconButtonTheme({
    this.backgroundColor,
    required this.foregroundColor,
  });
}

DotsIconButtonTheme getIconButtonThemeByVariant(DotsTheme theme, DotsIconButtonVariant variant) {
  switch (variant) {
    case DotsIconButtonVariant.solid:
      return DotsIconButtonTheme(
        backgroundColor: theme.colors.bgContainerSecondary,
        foregroundColor: theme.colors.textPrimary,
      );
    case DotsIconButtonVariant.photo:
      return DotsIconButtonTheme(
        backgroundColor: theme.colors.bgSecondaryBtnMaterialLight,
        foregroundColor: theme.colors.labelAlwaysWhite,
      );
    case DotsIconButtonVariant.active:
      return DotsIconButtonTheme(
        backgroundColor: theme.colors.labelHighlight,
        foregroundColor: theme.colors.labelAlwaysWhite,
      );
    case DotsIconButtonVariant.noBackground:
      return DotsIconButtonTheme(
        foregroundColor: theme.colors.textPrimary,
      );
  }
}
