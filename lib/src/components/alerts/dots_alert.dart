import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsAlert extends StatelessWidget {
  /// The alert variant (e.g., no buttons, one button, input, etc.).
  ///
  /// Defaults to [DotsAlertVariant.noButtons].
  final DotsAlertVariant variant;

  /// The icon to display in the alert.
  final DotsIconData iconData;

  /// The title text of the alert.
  final String title;

  /// The optional message or description text of the alert.
  final String? message;

  /// Callback when the close button is tapped.
  final VoidCallback? onClose;

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

  const DotsAlert._({
    super.key,
    this.variant = DotsAlertVariant.noButtons,
    required this.iconData,
    required this.title,
    this.message,
    this.onClose,
    this.onInputChanged,
    this.inputHint,
    this.selectorItemList,
    this.mainButtonText,
    this.mainButtonOnTap,
    this.secondaryButtonText,
    this.secondaryButtonOnTap,
  });

  factory DotsAlert.noButtons({
    Key? key,
    required DotsIconData iconData,
    required String title,
    required String message,
    VoidCallback? onClose,
  }) =>
      DotsAlert._(
        key: key,
        variant: DotsAlertVariant.noButtons,
        iconData: iconData,
        title: title,
        message: message,
        onClose: onClose,
      );

  factory DotsAlert.oneButton({
    Key? key,
    required DotsIconData iconData,
    required String title,
    required String message,
    VoidCallback? onClose,
    required String mainButtonText,
    required VoidCallback mainButtonOnTap,
  }) =>
      DotsAlert._(
        key: key,
        variant: DotsAlertVariant.oneButton,
        iconData: iconData,
        title: title,
        message: message,
        onClose: onClose,
        mainButtonText: mainButtonText,
        mainButtonOnTap: mainButtonOnTap,
      );

  factory DotsAlert.twoHorizontalButtons({
    Key? key,
    required DotsIconData iconData,
    required String title,
    required String message,
    VoidCallback? onClose,
    required String mainButtonText,
    required VoidCallback mainButtonOnTap,
    required String secondaryButtonText,
    required VoidCallback secondaryButtonOnTap,
  }) =>
      DotsAlert._(
        key: key,
        variant: DotsAlertVariant.twoHorizontalButtons,
        iconData: iconData,
        title: title,
        message: message,
        onClose: onClose,
        mainButtonText: mainButtonText,
        mainButtonOnTap: mainButtonOnTap,
        secondaryButtonText: secondaryButtonText,
        secondaryButtonOnTap: secondaryButtonOnTap,
      );

  factory DotsAlert.twoVerticalButtons({
    Key? key,
    required DotsIconData iconData,
    required String title,
    required String message,
    VoidCallback? onClose,
    required String mainButtonText,
    required VoidCallback mainButtonOnTap,
    required String secondaryButtonText,
    required VoidCallback secondaryButtonOnTap,
  }) =>
      DotsAlert._(
        key: key,
        variant: DotsAlertVariant.twoVerticalButtons,
        iconData: iconData,
        title: title,
        message: message,
        onClose: onClose,
        mainButtonText: mainButtonText,
        mainButtonOnTap: mainButtonOnTap,
        secondaryButtonText: secondaryButtonText,
        secondaryButtonOnTap: secondaryButtonOnTap,
      );

  factory DotsAlert.input({
    Key? key,
    required DotsIconData iconData,
    required String title,
    VoidCallback? onClose,
    required Function(String)? onInputChanged,
    required String? inputHint,
    required String mainButtonText,
    required VoidCallback mainButtonOnTap,
    required String secondaryButtonText,
    required VoidCallback secondaryButtonOnTap,
  }) =>
      DotsAlert._(
        key: key,
        variant: DotsAlertVariant.input,
        iconData: iconData,
        title: title,
        onClose: onClose,
        onInputChanged: onInputChanged,
        inputHint: inputHint,
        mainButtonText: mainButtonText,
        mainButtonOnTap: mainButtonOnTap,
        secondaryButtonText: secondaryButtonText,
        secondaryButtonOnTap: secondaryButtonOnTap,
      );

  factory DotsAlert.selector({
    Key? key,
    required DotsIconData iconData,
    required String title,
    required String message,
    VoidCallback? onClose,
    required List<DotsListItemModel> selectorItemList,
    required String mainButtonText,
    required VoidCallback mainButtonOnTap,
    required String secondaryButtonText,
    required VoidCallback secondaryButtonOnTap,
  }) =>
      DotsAlert._(
        key: key,
        variant: DotsAlertVariant.selector,
        iconData: iconData,
        title: title,
        message: message,
        onClose: onClose,
        selectorItemList: selectorItemList,
        mainButtonText: mainButtonText,
        mainButtonOnTap: mainButtonOnTap,
        secondaryButtonText: secondaryButtonText,
        secondaryButtonOnTap: secondaryButtonOnTap,
      );

  @override
  Widget build(BuildContext context) {
    final DotsTheme theme = context.dotsTheme;

    return Container(
      color: Colors.black.dotsWithOpacity(0.5),
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        content: IntrinsicHeight(
          child: Stack(
            children: [
              Container(
                width: 320,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme.colors.bgContainerSecondary,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: theme.colors.borderAlert,
                    width: 1.4,
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _icon(theme),
                          Padding(
                            padding: variant.isInput
                                ? const EdgeInsets.symmetric(vertical: 16)
                                : variant.isSelector
                                    ? const EdgeInsets.only(top: 16)
                                    : const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: theme.typo.main.bodyLargeBold,
                                ),
                                const SizedBox(height: 8),
                                _description(theme),
                              ],
                            ),
                          ),
                          if (!variant.isNoButtons) ...[
                            SizedBox(height: variant.isSelector ? 16 : 8),
                            _actions(),
                          ]
                        ],
                      ),
                    ),
                    if (!variant.isTwoHorizontalButtons)
                      Positioned(
                        top: 16,
                        right: 16,
                        child: DotsCloseButton(
                          icon: DotsIconData.cross,
                          size: DotsCloseButtonSize.small,
                          variant: DotsCloseButtonVariant.softContrast,
                          onTap: onClose,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon(DotsTheme theme) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
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
      ),
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
        DotsTextField(
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
    return Text(
      message!,
      textAlign: TextAlign.center,
      style: theme.typo.main.bodyDefaultRegular,
    );
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

      default:
        return const Offstage();
    }
  }

  Widget _mainButton(DotsMainButtonVariant variant, String? text, VoidCallback? onTap) {
    return DotsMainButton(
      variant: variant,
      size: DotsMainButtonSize.large,
      content: text ?? '',
      onTap: onTap,
    );
  }
}
