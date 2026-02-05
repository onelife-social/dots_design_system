import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BadgeMilestoneTheme {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final bool blur;

  const BadgeMilestoneTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.blur = true,
  });
}

BadgeMilestoneTheme getBadgeMilestoneThemeByVariant(
  DotsTheme theme,
  BadgeMilestoneVariant variant,
) {
  switch (variant) {
    case BadgeMilestoneVariant.main:
      return BadgeMilestoneTheme(
        backgroundColor: theme.colors.bgBase,
        foregroundColor: theme.colors.textTertiary,
        borderColor: theme.colors.bgSecondaryBtn,
        blur: true,
      );
    case BadgeMilestoneVariant.ghost:
      return BadgeMilestoneTheme(
        backgroundColor: theme.colors.bgBase,
        foregroundColor: theme.colors.textTertiary,
        borderColor: null,
        blur: true,
      );
  }
}
