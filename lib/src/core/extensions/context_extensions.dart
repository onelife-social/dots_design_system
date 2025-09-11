import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  DotsTheme get dotsTheme {
    final theme = Theme.of(this).extension<DotsTheme>();

    if (theme == null) {
      throw Exception('No Dots theme on context');
    }
    return theme;
  }

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isSmallScreen => MediaQuery.of(this).aspectRatio <= kBigRatio;

  T getByRatio<T>(T big, T small) {
    if (isSmallScreen) {
      return small;
    } else {
      return big;
    }
  }

  /// Returns a width based on a fraction of the screen width.
  double widthByPercent(double fraction) {
    assert(fraction >= 0 && fraction <= 1, 'Fraction must be between 0 and 1');
    return screenWidth * fraction;
  }

  /// Returns a height based on a fraction of the screen height.
  double heightByPercent(double fraction) {
    assert(fraction >= 0 && fraction <= 1, 'Fraction must be between 0 and 1');
    return screenHeight * fraction;
  }
}
