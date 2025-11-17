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
    return DotsActionSheetContainer(
      bottomPosition: bottomPosition,
      showBlurBackground: showBlurBackground,
      onClose: onClose,
      applyHorizontalPadding: false,
      child: DotsActionSheetInputContent(
        variant: variant,
        title: title,
        subtitle: subtitle,
        onBackButtonTap: onBackButtonTap,
        onCloseButtonTap: onCloseButtonTap,
        iconData: iconData,
        onIconTap: onIconTap,
        onMainButtonTap: onMainButtonTap,
        enableMainButton: enableMainButton,
        actionButtonText: actionButtonText,
        colorController: colorController,
        selectedColor: selectedColor,
        dateLabel: dateLabel,
        dateValue: dateValue,
        onDateTap: onDateTap,
        dateIconData: dateIconData,
        textFieldController: textFieldController,
        focus: focus,
        onChanged: onChanged,
        onTapTextFieldBtn: onTapTextFieldBtn,
        inputHintText: inputHintText,
        maxTextLength: maxTextLength,
        image: image,
        userLabel: userLabel,
      ),
    );
  }
}
