import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

const List<String> dotsColorNames = [
  'null',
  'bgBase',
  'bgBaseContrast',
  'bgContainerPrimary',
  'bgContainerSecondary',
  'bgContainerSecondaryOnBackground',
  'bgContainerTertiary',
  'bgAlert',
  'bgToastLight',
  'bgSecondaryBtn',
  'bgFloatingBtn',
  'bgBtnImage',
  'bgBtnDisabled',
  'bgChip',
  'textPrimary',
  'textSecondary',
  'textTertiary',
  'textQuarternary',
  'labelPrimary',
  'labelSecondary',
  'labelAlwaysWhite',
  'labelHighlight',
  'bgHighlight',
  'labelDestructive',
  'bgDestructive',
  'labelActive',
  'labelInactive',
  'bgActive',
  'misc100',
  'misc200',
  'misc300',
  'misc400',
  'misc500',
  'misc600',
  'misc700',
  'misc800',
  'misc900',
  'misc1000',
  'misc1100',
  'gradientInitialLineal',
  'gradientFinalLineal',
  'gradientInitialLinealGreen',
  'gradientFinalLinealGreen',
  'gradientInitialLinealPurple',
  'gradientFinalLinealPurple',
  'transparent',
  'borderAlert',
  'borderLabel',
];

Color? _getDotsColorByName(dynamic themeColors, String? name) {
  if (name == null || name == 'null') return null;
  switch (name) {
    case 'bgBase':
      return themeColors.bgBase;
    case 'bgBaseContrast':
      return themeColors.bgBaseContrast;
    case 'bgContainerPrimary':
      return themeColors.bgContainerPrimary;
    case 'bgContainerSecondary':
      return themeColors.bgContainerSecondary;
    case 'bgContainerSecondaryOnBackground':
      return themeColors.bgContainerSecondaryOnBackground;
    case 'bgContainerTertiary':
      return themeColors.bgContainerTertiary;
    case 'bgAlert':
      return themeColors.bgAlert;
    case 'bgToastLight':
      return themeColors.bgToastLight;
    case 'bgSecondaryBtn':
      return themeColors.bgSecondaryBtn;
    case 'bgFloatingBtn':
      return themeColors.bgFloatingBtn;
    case 'bgBtnImage':
      return themeColors.bgBtnImage;
    case 'bgBtnDisabled':
      return themeColors.bgBtnDisabled;
    case 'bgChip':
      return themeColors.bgChip;
    case 'textPrimary':
      return themeColors.textPrimary;
    case 'textSecondary':
      return themeColors.textSecondary;
    case 'textTertiary':
      return themeColors.textTertiary;
    case 'textQuarternary':
      return themeColors.textQuarternary;
    case 'labelPrimary':
      return themeColors.labelPrimary;
    case 'labelSecondary':
      return themeColors.labelSecondary;
    case 'labelAlwaysWhite':
      return themeColors.labelAlwaysWhite;
    case 'labelHighlight':
      return themeColors.labelHighlight;
    case 'bgHighlight':
      return themeColors.bgHighlight;
    case 'labelDestructive':
      return themeColors.labelDestructive;
    case 'bgDestructive':
      return themeColors.bgDestructive;
    case 'labelActive':
      return themeColors.labelActive;
    case 'labelInactive':
      return themeColors.labelInactive;
    case 'bgActive':
      return themeColors.bgActive;
    case 'misc100':
      return themeColors.misc100;
    case 'misc200':
      return themeColors.misc200;
    case 'misc300':
      return themeColors.misc300;
    case 'misc400':
      return themeColors.misc400;
    case 'misc500':
      return themeColors.misc500;
    case 'misc600':
      return themeColors.misc600;
    case 'misc700':
      return themeColors.misc700;
    case 'misc800':
      return themeColors.misc800;
    case 'misc900':
      return themeColors.misc900;
    case 'misc1000':
      return themeColors.misc1000;
    case 'misc1100':
      return themeColors.misc1100;
    case 'gradientInitialLineal':
      return themeColors.gradientInitialLineal;
    case 'gradientFinalLineal':
      return themeColors.gradientFinalLineal;
    case 'gradientInitialLinealGreen':
      return themeColors.gradientInitialLinealGreen;
    case 'gradientFinalLinealGreen':
      return themeColors.gradientFinalLinealGreen;
    case 'gradientInitialLinealPurple':
      return themeColors.gradientInitialLinealPurple;
    case 'gradientFinalLinealPurple':
      return themeColors.gradientFinalLinealPurple;
    case 'transparent':
      return themeColors.transparent;
    case 'borderAlert':
      return themeColors.borderAlert;
    case 'borderLabel':
      return themeColors.borderLabel;
    default:
      return null;
  }
}

Color? knobColorSelector(BuildContext context, String label) {
  final themeColors = context.dotsTheme.colors;
  final selectedColorName = context.knobs.options<String>(
    label: label,
    initial: dotsColorNames.first,
    options: dotsColorNames.map((name) => Option(label: name, value: name)).toList(),
  );

  return _getDotsColorByName(themeColors, selectedColorName);
}
