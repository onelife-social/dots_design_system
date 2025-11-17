import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetRadioButtons extends StatelessWidget {
  /// Widget displayed at the top of the sheet.
  final Widget? topWidget;

  /// Title text.
  final String title;

  /// Subtitle text.
  final String subtitle;

  /// List of `RadioCardIcons`.
  final List<RadioCardIcons> items;

  /// Optional label for the main action button.
  final String? buttonLabel;

  /// Callback for main action button tap.
  final Function()? onTapButton;

  /// Whether to show the close button.
  ///
  /// Defaults to `false`.
  final bool showCloseButton;

  /// Callback for closing the sheet.
  final VoidCallback? onClose;

  /// Whether to show a blurred background.
  ///
  /// Defaults to `true`.
  final bool showBlurBackground;

  /// Position from the bottom of the screen.
  ///
  /// Defaults to `56`.
  final double bottomPosition;

  const DotsActionSheetRadioButtons({
    super.key,
    this.topWidget,
    required this.title,
    required this.subtitle,
    required this.items,
    this.buttonLabel,
    this.onTapButton,
    this.showCloseButton = false,
    this.onClose,
    this.showBlurBackground = true,
    this.bottomPosition = 56,
  });

  @override
  Widget build(BuildContext context) {
    final maxSheetHeight = context.screenHeight - 96;

    return DotsActionSheetContainer(
      bottomPosition: bottomPosition,
      horizontalPadding: 16,
      maxHeight: maxSheetHeight,
      showBlurBackground: showBlurBackground,
      onClose: onClose,
      showCloseButton: false,
      applyHorizontalPadding: false,
      containerPadding: EdgeInsets.zero,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          DotsActionSheetRadioButtonsContent(
            topWidget: topWidget,
            title: title,
            subtitle: subtitle,
            items: items,
            buttonLabel: buttonLabel,
            onTapButton: onTapButton,
            maxSheetHeight: maxSheetHeight,
          ),
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: const Center(child: Grabber()),
          ),
          if (showCloseButton)
            Positioned(
              top: 12,
              right: 16,
              child: DotsCloseButton(
                icon: DotsIconData.cross,
                size: DotsCloseButtonSize.medium,
                variant: DotsCloseButtonVariant.softContrast,
                addBlur: false,
                onTap: onClose,
              ),
            ),
        ],
      ),
    );
  }
}
