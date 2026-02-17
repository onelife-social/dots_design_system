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
        return Color(0xFF3C3C3B);
      case DotBookCoverColor.stone:
        return theme.colors.labelAlwaysWhite;
      case DotBookCoverColor.charcoal:
        return theme.colors.labelAlwaysWhite;
      case DotBookCoverColor.cloud:
        return Color(0xFF3E585E);
      case DotBookCoverColor.olive:
        return Color(0xFF52572F);
      case DotBookCoverColor.peach:
        return Color(0xFFA88692);
      case DotBookCoverColor.sand:
        return Color(0xFFA89E91);
      case DotBookCoverColor.beigeCraft:
        return Color(0xFF88683A);
    }
  }
}