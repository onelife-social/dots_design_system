import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum ActionSheetInputVariant {
  main,
  colors,
  date;

  bool get isMain => this == ActionSheetInputVariant.main;
  bool get isColors => this == ActionSheetInputVariant.colors;
  bool get isDate => this == ActionSheetInputVariant.date;
}

class DotsActionSheetInput extends StatelessWidget {

  /// The [variant] parameter determines the type of action sheet.
  /// - [ActionSheetInputVariant.main] is the default variant.
  /// - [ActionSheetInputVariant.colors] is for color selection.
  /// - [ActionSheetInputVariant.date] is for date selection.
  final ActionSheetInputVariant variant;

  /// The [title] parameter is the title of the action sheet.
  final String title;

  /// The [subtitle] parameter is the subtitle of the action sheet.
  final String subtitle;

  /// The [onBackButtonTap] is a callback for the back button.
  final Function()? onBackButtonTap;

  /// The [onClose] is a callback for closing the action sheet tapping outside.
  final VoidCallback? onClose;

  /// The [showBlurBackground] parameter determines if the background should be blurred.
  final bool showBlurBackground;

  /// The [iconData] is the icon for the folder.
  final DotsIconData? iconData;

  /// The [onIconTap] is a callback for the folder icon tap.
  final Function()? onIconTap;

  /// The [initialValue] is the initial value for the text field.
  final String? initialValue;

  /// The [onMainButtonTap] is a callback for the main button tap.
  final Function() onMainButtonTap;

  /// The [actionButtonText] is the text for the action button.
  final String actionButtonText;

  /// The [colorController] is a ValueNotifier for the selected color.
  final ValueNotifier<DotsColorOption>? colorController;

  /// The [selectedColor] is the currently selected color.
  final DotsColorOption? selectedColor;

  /// The [dateLabel] is the label for the date input.
  final String? dateLabel;
  
  /// The [dateValue] is the value for the date input.
  final String? dateValue;

  /// The [onDateTap] is a callback for the date input tap.
  final Function()? onDateTap;

  /// The [dateIconData] is the icon for the date input.
  final DotsIconData? dateIconData;

  const DotsActionSheetInput({
    super.key,
    this.variant = ActionSheetInputVariant.main,
    required this.title,
    required this.subtitle,
    required this.onMainButtonTap,
    required this.actionButtonText,
    this.onBackButtonTap,
    this.onClose,
    this.showBlurBackground = true,
    this.iconData,
    this.onIconTap,
    this.initialValue,
    this.colorController,
    this.selectedColor = DotsColorOption.grey,
    this.dateLabel,
    this.dateValue,
    this.onDateTap,
    this.dateIconData
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: Container(
            child: showBlurBackground
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.dotsWithOpacity(0.3),
                    ),
                  )
                : null,
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: theme.colors.bgBaseContrast,
              borderRadius: DotsBorderRadius.r32,
            ),
            width: context.getByRatio(358, 288),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Header(title: title, onBackButtonTap: onBackButtonTap),
                SizedBox(height: context.getByRatio(16, 10)),
                if (variant.isColors && colorController != null)
                    ValueListenableBuilder<DotsColorOption>(
                      valueListenable: colorController!,
                      builder: (context, selectedColor, _) {
                        return _Body(
                          variant: variant,
                          subtitle: subtitle,
                          iconData: iconData,
                          onIconTap: onIconTap,
                          initialValue: initialValue,
                          onMainButtonTap: onMainButtonTap,
                          actionButtonText: actionButtonText,
                          selectedColor: selectedColor,
                          onColorSelected: (color) {
                            colorController!.value = color;
                          },
                        );
                      },
                    )
                  else
                    _Body(
                      variant: variant,
                      subtitle: subtitle,
                      iconData: iconData,
                      onIconTap: onIconTap,
                      initialValue: initialValue,
                      onMainButtonTap: onMainButtonTap,
                      actionButtonText: actionButtonText,
                      selectedColor: selectedColor,
                      dateLabel: dateLabel,
                      dateValue: dateValue,
                      onDateTap: onDateTap,
                      dateIconData: dateIconData,
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final Function()? onBackButtonTap;

  const _Header({
    required this.title,
    this.onBackButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Row(
        children: [
          if (onBackButtonTap != null) ...[
            DotsIconButton(
              icon: DotsIconData.chevronLeft,
              size: DotsIconButtonSize.medium,
              variant: DotsIconButtonVariant.noBackground,
              onTap: onBackButtonTap,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  title,
                  style: theme.typo.secondary.title02H6,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(width: 36),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final String? subtitle;
  final ActionSheetInputVariant variant;
  final DotsIconData? iconData;
  final Function()? onIconTap;
  final String? initialValue;
  final Function()? onMainButtonTap;
  final String actionButtonText;
  final DotsColorOption? selectedColor;
  final ValueChanged<DotsColorOption>? onColorSelected;
  final String? dateLabel;
  final String? dateValue;
  final Function()? onDateTap;
  final DotsIconData? dateIconData;

  const _Body({
    this.subtitle,
    required this.variant,
    this.iconData,
    this.onIconTap,
    this.initialValue,
    required this.onMainButtonTap,
    required this.actionButtonText,
    this.selectedColor,
    this.onColorSelected,
    this.dateLabel,
    this.dateValue,
    this.onDateTap,
    this.dateIconData = DotsIconData.calendar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final double elementsGap = context.getByRatio(16, 10);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (subtitle != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              subtitle ?? '',
              style: theme.typo.main.labelDefaultRegular.copyWith(
                color: theme.colors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
        ],
        if (!variant.isDate) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DotsIconButton(
              icon: iconData ?? DotsIconData.add,
              size: DotsIconButtonSize.extraLarge,
              variant: DotsIconButtonVariant.solid,
              onTap: onIconTap,
              color: selectedColor?.getColor(context) ?? theme.colors.textQuarternary,
            ),
          ),
          SizedBox(height: elementsGap),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DotsTextField(
                initialValue: initialValue,
                alignCenter: true,
              ),
            ],
          ),
        ),
        if (variant.isDate) ...[
          SizedBox(height: elementsGap),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DotsItemInput(
              label: dateLabel,
              value: dateValue,
              onTap: onDateTap,
              icon: dateIconData,
              position: DotsItemInputPosition.onlyOne,
            ),
          ),
        ],
        if (variant.isColors) ...[
          SizedBox(height: elementsGap),
          DotsColorOptionsRow(
            size: 32,
            spacing: 18,
            selectedColor: selectedColor,
            onColorSelected: onColorSelected ?? (_) {},
          ),
        ],
        SizedBox(height: elementsGap),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Row(
            children: [
              Expanded(
                child: DotsMainButton(
                  expand: true,
                  variant: DotsMainButtonVariant.main,
                  size: DotsMainButtonSize.mainAction,
                  onTap: onMainButtonTap,
                  content: actionButtonText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
}
}