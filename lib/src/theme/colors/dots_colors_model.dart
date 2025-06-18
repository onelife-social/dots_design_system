import 'package:flutter/widgets.dart';

class DotsColorsModel {
  // Base
  final Color bgBase;
  final Color bgBaseContrast;

  // Container
  final Color bgContainerPrimary;
  final Color bgContainerSecondary;
  final Color bgContainerSecondaryOnBackground;
  final Color bgContainerTertiary;

  // Prime Tag
  final Color bgToastLight;

  // Buttons
  final Color bgSecondaryBtn;
  final Color bgFloatingBtn;
  final Color bgBtnImage;
  final Color bgBtnDisabled;

  // Components
  final Color bgChip;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textQuarternary;

  // Label
  final Color labelPrimary;
  final Color labelSecondary;
  final Color labelAlwaysWhite;

  // Semantic
  final Color labelHighlight;
  final Color bgHighlight;
  final Color labelDestructive;
  final Color bgDestructive;
  final Color labelActive;
  final Color labelInactive;
  final Color bgActive;

  // Miscellaneous

  final Color misc100;
  final Color misc200;
  final Color misc300;
  final Color misc400;
  final Color misc500;
  final Color misc600;
  final Color misc700;
  final Color misc800;
  final Color misc900;
  final Color misc1000;
  final Color misc1100;

  // Gradient
  final Color gradientInitialLineal;
  final Color gradientFinalLineal;
  final Color gradientInitialLinealGreen;
  final Color gradientFinalLinealGreen;
  final Color gradientInitialLinealPurple;
  final Color gradientFinalLinealPurple;

  //generics
  final Color transparent;

  const DotsColorsModel({
    required this.bgBase,
    required this.bgBaseContrast,
    required this.bgContainerPrimary,
    required this.bgContainerSecondary,
    required this.bgContainerSecondaryOnBackground,
    required this.bgContainerTertiary,
    required this.bgSecondaryBtn,
    required this.bgFloatingBtn,
    required this.bgBtnImage,
    required this.bgBtnDisabled,
    required this.bgToastLight,
    required this.bgChip,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textQuarternary,
    required this.labelPrimary,
    required this.labelSecondary,
    required this.labelHighlight,
    required this.labelAlwaysWhite,
    required this.bgHighlight,
    required this.labelDestructive,
    required this.bgDestructive,
    required this.labelActive,
    required this.labelInactive,
    required this.bgActive,
    required this.misc100,
    required this.misc200,
    required this.misc300,
    required this.misc400,
    required this.misc500,
    required this.misc600,
    required this.misc700,
    required this.misc800,
    required this.misc900,
    required this.misc1000,
    required this.misc1100,
    required this.gradientInitialLineal,
    required this.gradientFinalLineal,
    required this.gradientInitialLinealGreen,
    required this.gradientFinalLinealGreen,
    required this.gradientInitialLinealPurple,
    required this.gradientFinalLinealPurple,
    required this.transparent,
  });

  DotsColorsModel lerp(DotsColorsModel? other, double t) {
    return DotsColorsModel(
      bgBase: Color.lerp(bgBase, other?.bgBase, t) ?? bgBase,
      bgBaseContrast: Color.lerp(bgBaseContrast, other?.bgBaseContrast, t) ?? bgBaseContrast,
      bgContainerPrimary:
          Color.lerp(bgContainerPrimary, other?.bgContainerPrimary, t) ?? bgContainerPrimary,
      bgContainerSecondary:
          Color.lerp(bgContainerSecondary, other?.bgContainerSecondary, t) ?? bgContainerSecondary,
      bgContainerSecondaryOnBackground: Color.lerp(
              bgContainerSecondaryOnBackground, other?.bgContainerSecondaryOnBackground, t) ??
          bgContainerSecondaryOnBackground,
      bgContainerTertiary:
          Color.lerp(bgContainerTertiary, other?.bgContainerTertiary, t) ?? bgContainerTertiary,
      bgSecondaryBtn: Color.lerp(bgSecondaryBtn, other?.bgSecondaryBtn, t) ?? bgSecondaryBtn,
      bgToastLight: Color.lerp(bgToastLight, other?.bgToastLight, t) ?? bgToastLight,
      bgFloatingBtn: Color.lerp(bgFloatingBtn, other?.bgFloatingBtn, t) ?? bgFloatingBtn,
      bgBtnImage: Color.lerp(bgBtnImage, other?.bgBtnImage, t) ?? bgBtnImage,
      bgBtnDisabled: Color.lerp(bgBtnDisabled, other?.bgBtnDisabled, t) ?? bgBtnDisabled,
      bgChip: Color.lerp(bgChip, other?.bgChip, t) ?? bgChip,
      textPrimary: Color.lerp(textPrimary, other?.textPrimary, t) ?? textPrimary,
      textSecondary: Color.lerp(textSecondary, other?.textSecondary, t) ?? textSecondary,
      textTertiary: Color.lerp(textTertiary, other?.textTertiary, t) ?? textTertiary,
      textQuarternary: Color.lerp(textQuarternary, other?.textQuarternary, t) ?? textQuarternary,
      labelPrimary: Color.lerp(labelPrimary, other?.labelPrimary, t) ?? labelPrimary,
      labelSecondary: Color.lerp(labelSecondary, other?.labelSecondary, t) ?? labelSecondary,
      labelHighlight: Color.lerp(labelHighlight, other?.labelHighlight, t) ?? labelHighlight,
      labelAlwaysWhite:
          Color.lerp(labelAlwaysWhite, other?.labelAlwaysWhite, t) ?? labelAlwaysWhite,
      bgHighlight: Color.lerp(bgHighlight, other?.bgHighlight, t) ?? bgHighlight,
      labelDestructive:
          Color.lerp(labelDestructive, other?.labelDestructive, t) ?? labelDestructive,
      bgDestructive: Color.lerp(bgDestructive, other?.bgDestructive, t) ?? bgDestructive,
      labelActive: Color.lerp(labelActive, other?.labelActive, t) ?? labelActive,
      labelInactive: Color.lerp(labelInactive, other?.labelInactive, t) ?? labelInactive,
      bgActive: Color.lerp(bgActive, other?.bgActive, t) ?? bgActive,
      misc100: Color.lerp(misc100, other?.misc100, t) ?? misc100,
      misc200: Color.lerp(misc200, other?.misc200, t) ?? misc200,
      misc300: Color.lerp(misc300, other?.misc300, t) ?? misc300,
      misc400: Color.lerp(misc400, other?.misc400, t) ?? misc400,
      misc500: Color.lerp(misc500, other?.misc500, t) ?? misc500,
      misc600: Color.lerp(misc600, other?.misc600, t) ?? misc600,
      misc700: Color.lerp(misc700, other?.misc700, t) ?? misc700,
      misc800: Color.lerp(misc800, other?.misc800, t) ?? misc800,
      misc900: Color.lerp(misc900, other?.misc900, t) ?? misc900,
      misc1000: Color.lerp(misc1000, other?.misc1000, t) ?? misc1000,
      misc1100: Color.lerp(misc1100, other?.misc1100, t) ?? misc1100,
      gradientInitialLineal: Color.lerp(gradientInitialLineal, other?.gradientInitialLineal, t) ??
          gradientInitialLineal,
      gradientFinalLineal:
          Color.lerp(gradientFinalLineal, other?.gradientFinalLineal, t) ?? gradientFinalLineal,
      gradientInitialLinealGreen:
          Color.lerp(gradientInitialLinealGreen, other?.gradientInitialLinealGreen, t) ??
              gradientInitialLinealGreen,
      gradientFinalLinealGreen:
          Color.lerp(gradientFinalLinealGreen, other?.gradientFinalLinealGreen, t) ??
              gradientFinalLinealGreen,
      gradientInitialLinealPurple:
          Color.lerp(gradientInitialLinealPurple, other?.gradientInitialLinealPurple, t) ??
              gradientInitialLinealPurple,
      gradientFinalLinealPurple:
          Color.lerp(gradientFinalLinealPurple, other?.gradientFinalLinealPurple, t) ??
              gradientFinalLinealPurple,
      transparent: Color.lerp(transparent, other?.transparent, t) ?? transparent,
    );
  }
}
