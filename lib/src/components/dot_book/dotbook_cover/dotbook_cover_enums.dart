import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotBookCoverType {
  linen,
  printedSquare,
  printedCircle,
}

enum DotBookCoverColor {
  white,
  stone,
  charcoal,
  cloud,
  olive,
  peach,
  sand,
  beigeCraft,
}

extension DotBookCoverColorTextExtension on DotBookCoverColor {
  Color textColor(BuildContext context, DotBookCoverType variant) {
    final theme = context.dotsTheme;

    if (variant == DotBookCoverType.linen) {
      return theme.colors.labelAlwaysWhite;
    }

    switch (this) {
      case DotBookCoverColor.white:
        return theme.colors.textPrimary;
      case DotBookCoverColor.stone:
        return theme.colors.textPrimary;
      case DotBookCoverColor.charcoal:
        return theme.colors.labelAlwaysWhite;
      case DotBookCoverColor.cloud:
        return theme.colors.textPrimary;
      case DotBookCoverColor.olive:
        return theme.colors.labelAlwaysWhite;
      case DotBookCoverColor.peach:
        return theme.colors.textPrimary;
      case DotBookCoverColor.sand:
        return theme.colors.textPrimary;
      case DotBookCoverColor.beigeCraft:
        return theme.colors.textPrimary;
    }
  }
}