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

  T getByRatio<T>(T big, T small) {
    if (MediaQuery.of(this).aspectRatio < kBigRatio) {
      return small;
    } else {
      return big;
    }
  }
}
