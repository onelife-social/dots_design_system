import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
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
  'gradientInitialPremiumHeader',
  'gradientMiddlePremiumHeader',
  'transparent',
  'borderAlert',
  'borderLabel',
];

const List<String> basicColorNames = [
  'red',
  'green',
  'blue',
  'yellow',
  'orange',
  'purple',
  'pink',
  'brown',
  'grey',
  'black',
  'white',
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
    case 'gradientInitialPremiumHeader':
      return themeColors.gradientInitialPremiumHeader;
    case 'gradientMiddlePremiumHeader':
      return themeColors.gradientMiddlePremiumHeader;
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

Color _getBasicColorByName(String name) {
  switch (name) {
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'yellow':
      return Colors.yellow;
    case 'orange':
      return Colors.orange;
    case 'purple':
      return Colors.purple;
    case 'pink':
      return Colors.pink;
    case 'brown':
      return Colors.brown;
    case 'grey':
      return Colors.grey;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    default:
      return Colors.transparent;
  }
}

Color basicColorSelector(BuildContext context, String label) {
  final selectedColorName = context.knobs.options<String>(
    label: label,
    initial: basicColorNames.first,
    options: basicColorNames.map((name) => Option(label: name, value: name)).toList(),
  );
  return _getBasicColorByName(selectedColorName);
}
