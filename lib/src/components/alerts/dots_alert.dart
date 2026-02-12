import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsAlert extends StatelessWidget {
  /// The alert variant (e.g., no buttons, one button, input, etc.).
  ///
  /// Defaults to `DotsAlertVariant.noButtons`.
  final DotsAlertVariant variant;

  /// The icon to display in the alert.
  final DotsIconData iconData;

  /// The image to display in the alert instead of the icon.
  final ImageProvider? iconImage;

  /// The title text of the alert.
  final String? title;

  /// The optional message or description text of the alert.
  final String? message;

  /// Callback when the close button is tapped.
  final VoidCallback? onClose;

  /// Whether tapping outside the alert closes it (`onClose` is executed).
  ///
  /// Defaults to `true`.
  final bool enableCloseOnTapOutside;

  /// *(Only for input variant)* Callback for input field value changes.
  final Function(String)? onInputChanged;

  /// *(Only for input variant)* Hint text for the input field.
  final String? inputHint;

  /// *(Only for selector variant)* List of selector items.
  final List<DotsListItemModel>? selectorItemList;

  /// Text for the main button.
  final String? mainButtonText;

  /// Callback when the main button is tapped.
  final VoidCallback? mainButtonOnTap;

  /// Text for the secondary button.
  final String? secondaryButtonText;

  /// Callback when the secondary button is tapped.
  final VoidCallback? secondaryButtonOnTap;

  /// Whether to show a close button in the top-right corner.
  final bool showCloseButton;

  /// Whether to show a blur background behind the alert.
  final bool showBlurBackground;

  const DotsAlert._({
    super.key,
    this.variant = DotsAlertVariant.noButtons,
    required this.iconData,
    this.title,
    this.iconImage,
    this.message,
    this.onClose,
    this.enableCloseOnTapOutside = true,
    this.onInputChanged,
    this.inputHint,
    this.selectorItemList,
    this.mainButtonText,
    this.mainButtonOnTap,
    this.secondaryButtonText,
    this.secondaryButtonOnTap,
    required this.showCloseButton,
    required this.showBlurBackground,
  });

  factory DotsAlert.noButtons({
    Key? key,
    required DotsIconData iconData,
    String? title,
    String? message,
    VoidCallback? onClose,
    bool enableCloseOnTapOutside = true,
    bool showCloseButton = false,
    ImageProvider? iconImage,
    bool showBlurBackground = true,
  }) => DotsAlert._(
    key: key,
    variant: DotsAlertVariant.noButtons,
    iconData: iconData,
    iconImage: iconImage,
    title: title,
    message: message,
    onClose: onClose,
    enableCloseOnTapOutside: enableCloseOnTapOutside,
    showCloseButton: showCloseButton,
    showBlurBackground: showBlurBackground,
  );

  factory DotsAlert.oneButton({
    Key? key,
    required DotsIconData iconData,
    String? title,
    String? message,
    VoidCallback? onClose,
    bool enableCloseOnTapOutside = true,
    String? mainButtonText,
    VoidCallback? mainButtonOnTap,
    bool showCloseButton = false,
    ImageProvider? iconImage,
    bool showBlurBackground = true,
  }) => DotsAlert._(
    key: key,
    variant: DotsAlertVariant.oneButton,
    iconData: iconData,
    iconImage: iconImage,
    title: title,
    message: message,
    onClose: onClose,
    enableCloseOnTapOutside: enableCloseOnTapOutside,
    mainButtonText: mainButtonText,
    mainButtonOnTap: mainButtonOnTap,
    showCloseButton: showCloseButton,
    showBlurBackground: showBlurBackground,
  );

  factory DotsAlert.twoHorizontalButtons({
    Key? key,
    required DotsIconData iconData,
    String? title,
    String? message,
    VoidCallback? onClose,
    bool enableCloseOnTapOutside = true,
    String? mainButtonText,
    VoidCallback? mainButtonOnTap,
    String? secondaryButtonText,
    VoidCallback? secondaryButtonOnTap,
    bool showCloseButton = false,
    ImageProvider? iconImage,
    bool showBlurBackground = true,
  }) => DotsAlert._(
    key: key,
    variant: DotsAlertVariant.twoHorizontalButtons,
    iconData: iconData,
    iconImage: iconImage,
    title: title,
    message: message,
    onClose: onClose,
    enableCloseOnTapOutside: enableCloseOnTapOutside,
    mainButtonText: mainButtonText,
    mainButtonOnTap: mainButtonOnTap,
    secondaryButtonText: secondaryButtonText,
    secondaryButtonOnTap: secondaryButtonOnTap,
    showCloseButton: showCloseButton,
    showBlurBackground: showBlurBackground,
  );
  factory DotsAlert.twoHorizontalButtonsDestructive({
    Key? key,
    required DotsIconData iconData,
    String? title,
    String? message,
    VoidCallback? onClose,
    bool enableCloseOnTapOutside = true,
    String? mainButtonText,
    VoidCallback? mainButtonOnTap,
    String? secondaryButtonText,
    VoidCallback? secondaryButtonOnTap,
    bool showCloseButton = false,
    ImageProvider? iconImage,
    bool showBlurBackground = true,
  }) => DotsAlert._(
    key: key,
    variant: DotsAlertVariant.twoHorizontalButtonsDestructive,
    iconData: iconData,
    iconImage: iconImage,
    title: title,
    message: message,
    onClose: onClose,
    enableCloseOnTapOutside: enableCloseOnTapOutside,
    mainButtonText: mainButtonText,
    mainButtonOnTap: mainButtonOnTap,
    secondaryButtonText: secondaryButtonText,
    secondaryButtonOnTap: secondaryButtonOnTap,
    showCloseButton: showCloseButton,
    showBlurBackground: showBlurBackground,
  );

  factory DotsAlert.twoVerticalButtons({
    Key? key,
    required DotsIconData iconData,
    String? title,
    String? message,
    VoidCallback? onClose,
    bool enableCloseOnTapOutside = true,
    String? mainButtonText,
    VoidCallback? mainButtonOnTap,
    String? secondaryButtonText,
    VoidCallback? secondaryButtonOnTap,
    bool showCloseButton = false,
    ImageProvider? iconImage,
    bool showBlurBackground = true,
  }) => DotsAlert._(
    key: key,
    variant: DotsAlertVariant.twoVerticalButtons,
    iconData: iconData,
    iconImage: iconImage,
    title: title,
    message: message,
    onClose: onClose,
    enableCloseOnTapOutside: enableCloseOnTapOutside,
    mainButtonText: mainButtonText,
    mainButtonOnTap: mainButtonOnTap,
    secondaryButtonText: secondaryButtonText,
    secondaryButtonOnTap: secondaryButtonOnTap,
    showCloseButton: showCloseButton,
    showBlurBackground: showBlurBackground,
  );

  factory DotsAlert.twoVerticalButtonsDestructive({
    Key? key,
    required DotsIconData iconData,
    String? title,
    String? message,
    VoidCallback? onClose,
    bool enableCloseOnTapOutside = true,
    String? mainButtonText,
    VoidCallback? mainButtonOnTap,
    String? secondaryButtonText,
    VoidCallback? secondaryButtonOnTap,
    bool showCloseButton = false,
    ImageProvider? iconImage,
    bool showBlurBackground = true,
  }) => DotsAlert._(
    key: key,
    variant: DotsAlertVariant.twoVerticalButtonsDestructive,
    iconData: iconData,
    iconImage: iconImage,
    title: title,
    message: message,
    onClose: onClose,
    enableCloseOnTapOutside: enableCloseOnTapOutside,
    mainButtonText: mainButtonText,
    mainButtonOnTap: mainButtonOnTap,
    secondaryButtonText: secondaryButtonText,
    secondaryButtonOnTap: secondaryButtonOnTap,
    showCloseButton: showCloseButton,
    showBlurBackground: showBlurBackground,
  );

  factory DotsAlert.twoVerticalButtonsNoActive({
    Key? key,
    required DotsIconData iconData,
    String? title,
    String? message,
    VoidCallback? onClose,
    bool enableCloseOnTapOutside = true,
    String? mainButtonText,
    VoidCallback? mainButtonOnTap,
    String? secondaryButtonText,
    VoidCallback? secondaryButtonOnTap,
    bool showCloseButton = false,
    ImageProvider? iconImage,
    bool showBlurBackground = true,
  }) => DotsAlert._(
    key: key,
    variant: DotsAlertVariant.twoVerticalButtonsNoActive,
    iconData: iconData,
    iconImage: iconImage,
    title: title,
    message: message,
    onClose: onClose,
    enableCloseOnTapOutside: enableCloseOnTapOutside,
    mainButtonText: mainButtonText,
    mainButtonOnTap: mainButtonOnTap,
    secondaryButtonText: secondaryButtonText,
    secondaryButtonOnTap: secondaryButtonOnTap,
    showCloseButton: showCloseButton,
    showBlurBackground: showBlurBackground,
  );

  factory DotsAlert.input({
    Key? key,
    required DotsIconData iconData,
    String? title,
    VoidCallback? onClose,
    bool enableCloseOnTapOutside = true,
    Function(String)? onInputChanged,
    String? inputHint,
    String? mainButtonText,
    VoidCallback? mainButtonOnTap,
    String? secondaryButtonText,
    VoidCallback? secondaryButtonOnTap,
    bool showCloseButton = false,
    ImageProvider? iconImage,
    bool showBlurBackground = true,
  }) => DotsAlert._(
    key: key,
    variant: DotsAlertVariant.input,
    iconData: iconData,
    iconImage: iconImage,
    title: title,
    onClose: onClose,
    enableCloseOnTapOutside: enableCloseOnTapOutside,
    onInputChanged: onInputChanged,
    inputHint: inputHint,
    mainButtonText: mainButtonText,
    mainButtonOnTap: mainButtonOnTap,
    secondaryButtonText: secondaryButtonText,
    secondaryButtonOnTap: secondaryButtonOnTap,
    showCloseButton: showCloseButton,
    showBlurBackground: showBlurBackground,
  );

  factory DotsAlert.selector({
    Key? key,
    required DotsIconData iconData,
    String? title,
    String? message,
    VoidCallback? onClose,
    bool enableCloseOnTapOutside = true,
    required List<DotsListItemModel> selectorItemList,
    String? mainButtonText,
    VoidCallback? mainButtonOnTap,
    String? secondaryButtonText,
    VoidCallback? secondaryButtonOnTap,
    bool showCloseButton = false,
    ImageProvider? iconImage,
    bool showBlurBackground = true,
  }) => DotsAlert._(
    key: key,
    variant: DotsAlertVariant.selector,
    iconData: iconData,
    iconImage: iconImage,
    title: title,
    message: message,
    onClose: onClose,
    enableCloseOnTapOutside: enableCloseOnTapOutside,
    selectorItemList: selectorItemList,
    mainButtonText: mainButtonText,
    mainButtonOnTap: mainButtonOnTap,
    secondaryButtonText: secondaryButtonText,
    secondaryButtonOnTap: secondaryButtonOnTap,
    showCloseButton: showCloseButton,
    showBlurBackground: showBlurBackground,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: enableCloseOnTapOutside == true ? onClose : null,
            child: Container(color: Colors.black.dotsWithOpacity(0.5)),
          ),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: showBlurBackground
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: _widgetContent(context),
                  )
                : _widgetContent(context),
          ),
        ),
      ],
    );
  }

  Widget _icon(DotsTheme theme) {
    final iconWidget = Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.5),
        color: theme.colors.labelHighlight.dotsWithOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: DotsIcon(iconData: iconData, color: theme.colors.labelHighlight),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8),
      child: iconImage != null
          ? Image(
              image: iconImage!,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => iconWidget,
            )
          : iconWidget,
    );
  }

  Widget _description(DotsTheme theme) {
    return switch (variant) {
      DotsAlertVariant.input => _inputField(),
      DotsAlertVariant.selector => _selectorField(theme),
      _ => _messageField(theme),
    };
  }

  Widget _inputField() {
    return Row(
      children: [
        DotsTextFieldButton(
          iconData: DotsIconData.search,
          hintText: inputHint,
          onChanged: onInputChanged,
        ),
      ],
    );
  }

  Widget _selectorField(DotsTheme theme) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _messageField(theme),
        ),
        const SizedBox(height: 16),
        DotsMainContainer(
          backgroundColor: theme.colors.bgContainerSecondaryOnBackground,
          forceHeight: false,
          padding: 12,
          radius: 24,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: selectorItemList!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) => DotsListsItem(
              variant: selectorItemList![i].variant,
              image: selectorItemList![i].image,
              label: selectorItemList![i].label,
              onTap: selectorItemList![i].onTap,
            ),
          ),
        ),
      ],
    );
  }

  Widget _messageField(DotsTheme theme) {
    if (!_hasText(message)) {
      return const SizedBox();
    }

    return Text(
      message!,
      textAlign: TextAlign.center,
      style: theme.typo.main.bodyDefaultRegular,
    );
  }

  bool _hasText(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  bool _shouldShowDescription() {
    return switch (variant) {
      DotsAlertVariant.input => true,
      DotsAlertVariant.selector => true,
      _ => _hasText(message),
    };
  }

  Widget _actions() {
    switch (variant) {
      case DotsAlertVariant.oneButton:
        return _mainButton(DotsMainButtonVariant.main, mainButtonText, mainButtonOnTap);

      case DotsAlertVariant.twoHorizontalButtons:
        return Row(
          children: [
            Expanded(
              child: _mainButton(
                DotsMainButtonVariant.secondary,
                secondaryButtonText,
                secondaryButtonOnTap,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _mainButton(
                DotsMainButtonVariant.main,
                mainButtonText,
                mainButtonOnTap,
              ),
            ),
          ],
        );

      case DotsAlertVariant.twoHorizontalButtonsDestructive:
        return Row(
          children: [
            Expanded(
              child: _mainButton(
                DotsMainButtonVariant.secondary,
                secondaryButtonText,
                secondaryButtonOnTap,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _mainButton(
                DotsMainButtonVariant.destructive,
                mainButtonText,
                mainButtonOnTap,
              ),
            ),
          ],
        );

      case DotsAlertVariant.twoVerticalButtons:
        return Column(
          children: [
            _mainButton(DotsMainButtonVariant.main, mainButtonText, mainButtonOnTap),
            _mainButton(DotsMainButtonVariant.ghost, secondaryButtonText, secondaryButtonOnTap),
          ],
        );

      case DotsAlertVariant.twoVerticalButtonsDestructive:
        return Column(
          children: [
            _mainButton(DotsMainButtonVariant.destructive, mainButtonText, mainButtonOnTap),
            _mainButton(DotsMainButtonVariant.ghost, secondaryButtonText, secondaryButtonOnTap),
          ],
        );

      case DotsAlertVariant.twoVerticalButtonsNoActive:
        return Column(
          children: [
            _mainButton(DotsMainButtonVariant.secondary, mainButtonText, mainButtonOnTap),
            const SizedBox(height: 8),
            _mainButton(DotsMainButtonVariant.secondary, secondaryButtonText, secondaryButtonOnTap),
          ],
        );

      case DotsAlertVariant.input:
      case DotsAlertVariant.selector:
        return Row(
          children: [
            Expanded(
              child: _mainButton(
                DotsMainButtonVariant.secondary,
                secondaryButtonText,
                secondaryButtonOnTap,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _mainButton(
                DotsMainButtonVariant.main,
                mainButtonText,
                mainButtonOnTap,
              ),
            ),
          ],
        );

      case DotsAlertVariant.noButtons:
        return const SizedBox();
    }
  }

  Widget _mainButton(DotsMainButtonVariant variant, String? text, VoidCallback? onTap) {
    return DotsMainButton(
      adaptPaddingForText: true,
      variant: variant,
      size: DotsMainButtonSize.large,
      content: text ?? '',
      onTap: onTap,
    );
  }

  Widget _widgetContent(BuildContext context) {
    final theme = context.dotsTheme;
    return Material(
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          color: theme.colors.bgContainerSecondary,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: theme.colors.borderAlert,
            width: 1.4,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showCloseButton) SizedBox(width: DotsCloseButtonSize.medium.size),
                  Expanded(
                    child: Center(child: _icon(theme)),
                  ),
                  if (showCloseButton)
                    DotsCloseButton(
                      icon: DotsIconData.cross,
                      size: DotsCloseButtonSize.medium,
                      variant: DotsCloseButtonVariant.softContrast,
                      onTap: onClose,
                    ),
                ],
              ),
              Padding(
                padding: variant.isInput
                    ? const EdgeInsets.symmetric(vertical: 16)
                    : variant.isSelector
                    ? const EdgeInsets.only(top: 16)
                    : const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_hasText(title))
                      Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: theme.typo.main.bodyLargeBold,
                      ),
                    if (_hasText(title) && _shouldShowDescription()) const SizedBox(height: 8),
                    if (_shouldShowDescription()) _description(theme),
                  ],
                ),
              ),
              if (!variant.isNoButtons) ...[
                SizedBox(height: variant.isSelector ? 16 : 8),
                _actions(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
