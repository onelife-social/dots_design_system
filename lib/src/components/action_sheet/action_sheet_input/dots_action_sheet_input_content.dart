import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetInputContent extends StatelessWidget {
  final ActionSheetInputVariant variant;
  final String? title;
  final String? subtitle;
  final Function()? onBackButtonTap;
  final VoidCallback? onCloseButtonTap;
  final DotsIconData? iconData;
  final Function()? onIconTap;
  final Function()? onMainButtonTap;
  final bool enableMainButton;
  final String? actionButtonText;
  final ValueNotifier<DotsColorOption>? colorController;
  final DotsColorOption? selectedColor;
  final String? dateLabel;
  final String? dateValue;
  final Function()? onDateTap;
  final DotsIconData? dateIconData;
  final String? textVariantTitle;
  final TextEditingController textFieldController;
  final FocusNode? focus;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTapTextFieldBtn;
  final String? inputHintText;
  final int? maxTextLength;
  final ImageProvider? image;
  final String? userLabel;
  final String? aliasLabelImageText;

  const DotsActionSheetInputContent({
    super.key,
    this.variant = ActionSheetInputVariant.main,
    this.title,
    this.subtitle,
    this.onMainButtonTap,
    this.enableMainButton = true,
    this.actionButtonText,
    this.onBackButtonTap,
    this.onCloseButtonTap,
    this.iconData,
    this.onIconTap,
    this.colorController,
    this.selectedColor = DotsColorOption.textQuarternary,
    this.dateLabel,
    this.dateValue,
    this.onDateTap,
    this.dateIconData,
    this.textVariantTitle,
    this.onTapTextFieldBtn,
    required this.textFieldController,
    this.focus,
    this.onChanged,
    this.inputHintText,
    this.maxTextLength,
    this.image,
    this.userLabel,
    this.aliasLabelImageText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                aliasLabelImageText: aliasLabelImageText,
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
            textVariantTitle: textVariantTitle,
            textFieldController: textFieldController,
            focus: focus,
            onTapTextFieldBtn: onTapTextFieldBtn,
            onChanged: onChanged,
            inputHintText: inputHintText,
            maxTextLength: maxTextLength,
            image: image,
            userLabel: userLabel,
            aliasLabelImageText: aliasLabelImageText,
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

    return Stack(
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
  final String? textVariantTitle;
  final TextEditingController? textFieldController;
  final FocusNode? focus;
  final VoidCallback? onTapTextFieldBtn;
  final ValueChanged<String>? onChanged;
  final String? inputHintText;
  final int? maxTextLength;
  final String? userLabel;
  final String? aliasLabelImageText;

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
    this.textVariantTitle,
    this.textFieldController,
    this.focus,
    this.onTapTextFieldBtn,
    this.onChanged,
    this.inputHintText,
    this.maxTextLength,
    this.image,
    this.userLabel,
    this.aliasLabelImageText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final double elementsGap = context.getByRatio(16, 10);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (subtitle != null) ...[
          Text(
            subtitle ?? '',
            style: theme.typo.main.labelDefaultRegular.copyWith(
              color: theme.colors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
        ],
        if (variant.isMain || variant.isColors) ...[
          DotsIconButton(
            icon: iconData ?? DotsIconData.add,
            size: DotsIconButtonSize.extraLarge,
            variant: DotsIconButtonVariant.solid,
            onTap: onIconTap,
            color: selectedColor?.getColor(context) ?? theme.colors.textQuarternary,
          ),
          SizedBox(height: elementsGap),
        ],
        if (variant.isText) ...[
          Text(
            textVariantTitle ?? '',
            style: theme.typo.main.bodyDefaultRegular.copyWith(
              color: theme.colors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
        ],
        if (variant.isUser) ...[
          ImageWithIcon(
            image: image,
            aliasLabelImageText: aliasLabelImageText,
            aliasLabelImageTextStyle: theme.typo.main.titleH4.copyWith(
              color: theme.colors.textTertiary,
            ),
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
        DotsTextField(
          controller: textFieldController,
          focusNode: focus,
          alignCenter: true,
          onTapBtn: onTapTextFieldBtn,
          onChanged: onChanged,
          hintText: inputHintText,
          maxTextLength: maxTextLength,
        ),
        if (variant.isDate) ...[
          SizedBox(height: elementsGap),
          DotsItemInput(
            label: dateLabel,
            value: dateValue,
            onTap: onDateTap,
            icon: dateIconData,
            position: DotsItemInputPosition.onlyOne,
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
        Row(
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
      ],
    );
  }
}
