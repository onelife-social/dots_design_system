import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum ActionSheetInputVariant {
  main,
  colors,
  date,
  user;

  bool get isMain => this == ActionSheetInputVariant.main;
  bool get isColors => this == ActionSheetInputVariant.colors;
  bool get isDate => this == ActionSheetInputVariant.date;
  bool get isUser => this == ActionSheetInputVariant.user;
}

class DotsActionSheetInput extends StatelessWidget {
  /// The [variant] parameter determines the type of action sheet.
  /// - [ActionSheetInputVariant.main] is the default variant.
  /// - [ActionSheetInputVariant.colors] is for color selection.
  /// - [ActionSheetInputVariant.date] is for date selection.
  /// - [ActionSheetInputVariant.user] is for user atributes input.
  final ActionSheetInputVariant variant;

  /// The [title] parameter is the title of the action sheet.
  final String? title;

  /// The [subtitle] parameter is the subtitle of the action sheet.
  final String? subtitle;

  /// The [onBackButtonTap] is a callback for the back button.
  final Function()? onBackButtonTap;

  /// The [onClose] is a callback for closing the action sheet tapping outside.
  final VoidCallback? onClose;

  /// The [onCloseButtonTap] is a callback for the close button tap.
  final VoidCallback? onCloseButtonTap;

  /// The [bottomPosition] is the position of the action sheet from the bottom.
  final double bottomPosition;

  /// The [showBlurBackground] parameter determines if the background should be blurred.
  final bool showBlurBackground;

  /// The [iconData] is the icon for the folder.
  final DotsIconData? iconData;

  /// The [onIconTap] is a callback for the folder icon tap.
  final Function()? onIconTap;

  /// The [onMainButtonTap] is a callback for the main button tap.
  final Function()? onMainButtonTap;

  /// The [enableMainButton] determines if the main button is enabled.
  final bool enableMainButton;

  /// The [actionButtonText] is the text for the action button.
  final String? actionButtonText;

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

  /// The [textFieldController] is the controller for the text field.
  /// The controller must have an initial value set as the name of the folder.
  final TextEditingController textFieldController;

  /// The [focus] is a FocusNode to manage focus state of the text field.
  final FocusNode? focus;

  /// The [onChanged] is a callback for the text field value changes.
  final ValueChanged<String>? onChanged;

  /// The [onTapTextFieldBtn] is a callback for the text field button tap.
  final VoidCallback? onTapTextFieldBtn;

  /// The [inputHintText] is a hint text for the text field.
  final String? inputHintText;

  /// The [maxTextLength] is the maximum length of text that can be entered in the text field.
  final int? maxTextLength;

  /// The [image] is the image for the user variant.
  final ImageProvider? image;

  /// The [userLabel] is the label for the user variant.
  final String? userLabel;

  const DotsActionSheetInput({
    super.key,
    this.variant = ActionSheetInputVariant.main,
    this.title,
    this.subtitle,
    this.onMainButtonTap,
    this.enableMainButton = true,
    this.actionButtonText,
    this.onBackButtonTap,
    this.onClose,
    this.onCloseButtonTap,
    this.bottomPosition = 56,
    this.showBlurBackground = true,
    this.iconData,
    this.onIconTap,
    this.colorController,
    this.selectedColor = DotsColorOption.textQuarternary,
    this.dateLabel,
    this.dateValue,
    this.onDateTap,
    this.dateIconData,
    this.onTapTextFieldBtn,
    required this.textFieldController,
    this.focus,
    this.onChanged,
    this.inputHintText,
    this.maxTextLength,
    this.image,
    this.userLabel,
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
        Positioned(
          left: 0,
          right: 0,
          bottom: bottomPosition,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colors.bgBaseContrast,
                borderRadius: DotsBorderRadius.r32,
              ),
              width: context.getByRatio(358, 288),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Header(
                    title: title,
                    onBackButtonTap: onBackButtonTap,
                    onCloseButtonTap: onCloseButtonTap,
                  ),
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
                          onMainButtonTap: onMainButtonTap,
                          enableMainButton: enableMainButton,
                          actionButtonText: actionButtonText,
                          textFieldController: textFieldController,
                          focus: focus,
                          onChanged: onChanged,
                          onTapTextFieldBtn: onTapTextFieldBtn,
                          selectedColor: selectedColor,
                          onColorSelected: (color) {
                            colorController!.value = color;
                          },
                          inputHintText: inputHintText,
                          maxTextLength: maxTextLength,
                        );
                      },
                    )
                  else
                    _Body(
                      variant: variant,
                      subtitle: subtitle,
                      iconData: iconData,
                      onIconTap: onIconTap,
                      onMainButtonTap: onMainButtonTap,
                      enableMainButton: enableMainButton,
                      actionButtonText: actionButtonText,
                      selectedColor: selectedColor,
                      dateLabel: dateLabel,
                      dateValue: dateValue,
                      onDateTap: onDateTap,
                      dateIconData: dateIconData,
                      textFieldController: textFieldController,
                      focus: focus,
                      onTapTextFieldBtn: onTapTextFieldBtn,
                      onChanged: onChanged,
                      inputHintText: inputHintText,
                      maxTextLength: maxTextLength,
                      image: image,
                      userLabel: userLabel,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String? title;
  final Function()? onBackButtonTap;
  final Function()? onCloseButtonTap;

  const _Header({
    this.title,
    this.onBackButtonTap,
    this.onCloseButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final double onBackButtonWidth = 36;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Stack(
        children: [
          Row(
            children: [
              if (onBackButtonTap != null)
                SizedBox(
                  width: onBackButtonWidth,
                  child: DotsIconButton(
                    icon: DotsIconData.chevronLeft,
                    size: DotsIconButtonSize.medium,
                    variant: DotsIconButtonVariant.noBackground,
                    onTap: onBackButtonTap,
                  ),
                ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      title ?? '',
                      style: theme.typo.secondary.title02H6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              if (onBackButtonTap != null) SizedBox(width: onBackButtonWidth),
            ],
          ),
          if (onCloseButtonTap != null)
            Positioned(
              top: 0,
              right: 0,
              child: DotsCloseButton(
                size: DotsCloseButtonSize.medium,
                onTap: onCloseButtonTap,
              ),
            ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final String? subtitle;
  final ImageProvider? image;
  final ActionSheetInputVariant variant;
  final DotsIconData? iconData;
  final Function()? onIconTap;
  final Function()? onMainButtonTap;
  final bool enableMainButton;
  final String? actionButtonText;
  final DotsColorOption? selectedColor;
  final ValueChanged<DotsColorOption>? onColorSelected;
  final String? dateLabel;
  final String? dateValue;
  final Function()? onDateTap;
  final DotsIconData? dateIconData;
  final TextEditingController? textFieldController;
  final FocusNode? focus;
  final VoidCallback? onTapTextFieldBtn;
  final ValueChanged<String>? onChanged;
  final String? inputHintText;
  final int? maxTextLength;
  final String? userLabel;

  const _Body({
    this.subtitle,
    required this.variant,
    this.iconData,
    this.onIconTap,
    this.onMainButtonTap,
    this.enableMainButton = true,
    this.actionButtonText,
    this.selectedColor,
    this.onColorSelected,
    this.dateLabel,
    this.dateValue,
    this.onDateTap,
    this.dateIconData = DotsIconData.calendar,
    this.textFieldController,
    this.focus,
    this.onTapTextFieldBtn,
    this.onChanged,
    this.inputHintText,
    this.maxTextLength,
    this.image,
    this.userLabel,
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
        if (variant.isMain || variant.isColors) ...[
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
        if (variant.isUser) ...[
          ImageWithIcon(
            image: image,
            width: 56,
            height: 56,
            circularImage: true,
          ),
          const SizedBox(height: 10),
          if (userLabel != null && userLabel!.isNotEmpty) ...[
            Text(
              userLabel!,
              style: theme.typo.main.titleH6.copyWith(color: theme.colors.textPrimary),
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(
            height: elementsGap,
          ),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DotsTextField(
            controller: textFieldController,
            focusNode: focus,
            alignCenter: true,
            onTapBtn: onTapTextFieldBtn,
            onChanged: onChanged,
            hintText: inputHintText,
            maxTextLength: maxTextLength,
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
                  enabled: enableMainButton,
                  content: actionButtonText ?? '',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
