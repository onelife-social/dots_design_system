import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// Theme data for [PageControl], with values that vary by [PageControlVariant].
class PageControlThemeData {
  const PageControlThemeData({
    required this.dotSize,
    required this.dotSpacing,
    required this.activeColor,
    required this.dotColor,
    this.activeBackgroundColor,
    required this.contentPadding,
  });

  /// Diameter of each dot.
  final double dotSize;

  /// Horizontal space between dots.
  final double dotSpacing;

  /// Color of the active dot.
  final Color activeColor;

  /// Color of inactive dots.
  final Color dotColor;

  /// Background color of the pill behind the active dot (background variant only).
  final Color? activeBackgroundColor;

  /// Padding around the whole row of dots.
  final EdgeInsets contentPadding;
}

PageControlThemeData getPageControlTheme(
  DotsTheme theme,
  PageControlVariant variant,
  Color? dotColor,
  Color? activeColor,
) {
  switch (variant) {
    case PageControlVariant.main:
      return PageControlThemeData(
        dotSize: 8,
        dotSpacing: 8,
        activeColor: activeColor ?? theme.colors.labelPrimary,
        dotColor: dotColor ?? theme.colors.labelSecondary,
        activeBackgroundColor: null,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      );
    case PageControlVariant.background:
      return PageControlThemeData(
        dotSize: 6,
        dotSpacing: 12,
        activeColor: activeColor ?? theme.colors.labelActive,
        dotColor: dotColor ?? theme.colors.labelSecondary,
        activeBackgroundColor: theme.colors.bgActive,
        contentPadding: EdgeInsets.zero,
      );
  }
}
