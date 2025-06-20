import 'package:dots_design_system/src/theme/dots_theme_lib.dart';
import 'package:flutter/material.dart';

ThemeData dotsThemeDataLight = ThemeData(extensions: <ThemeExtension<dynamic>>[
  DotsTheme(DotsColors.light, DotsStyles.light),
]);
ThemeData dotsThemeDataDark = ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    DotsTheme(DotsColors.dark, DotsStyles.dark),
  ],
);

extension DotsThemeOnContext on BuildContext {
  DotsTheme get dotsTheme {
    final theme = Theme.of(this).extension<DotsTheme>();

    if (theme == null) {
      throw Exception('No Dots theme on context');
    }
    return theme;
  }
}

class DotsTheme extends ThemeExtension<DotsTheme> {
  final DotsColorsModel colors;
  final DotsStylesModel styles;
  final DotsTypoModel typo;

  factory DotsTheme(
    DotsColorsModel colors,
    DotsStylesModel styles,
  ) {
    return DotsTheme._(
      colors,
      styles,
      DotsTypo.all(colors.textPrimary),
    );
  }

  DotsTheme._(
    this.colors,
    this.styles,
    this.typo,
  );

  @override
  ThemeExtension<DotsTheme> lerp(covariant DotsTheme? other, double t) {
    return DotsTheme._(
      colors.lerp(other?.colors, t),
      styles.lerp(other?.styles, t),
      typo.lerp(other?.typo, t),
    );
  }

  DotsTheme copyWith({
    DotsColorsModel? colors,
    DotsTypoModel? typo,
    DotsStylesModel? styles,
  }) {
    return DotsTheme._(
      colors ?? this.colors,
      styles ?? this.styles,
      typo ?? this.typo,
    );
  }
}
