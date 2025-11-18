import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetSettings extends StatelessWidget {
  final VoidCallback? onClose;
  final bool showBlurBackground;
  final double bottomPosition;
  final VoidCallback? onTapCloseButton;
  final ImageProvider image;
  final ImageErrorListener? onImageError;
  final double imageWidth;
  final double imageHeight;
  final String title;
  final String? subtitle;
  final List<DotsSystemButton> buttons;

  const DotsActionSheetSettings({
    super.key,
    required this.image,
    required this.title,
    required this.buttons,
    this.subtitle,
    this.onClose,
    this.showBlurBackground = true,
    this.bottomPosition = 56,
    this.onTapCloseButton,
    this.onImageError,
    this.imageWidth = 100,
    this.imageHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return DotsActionSheetContainer(
      bottomPosition: bottomPosition,
      horizontalPadding: 16,
      showBlurBackground: showBlurBackground,
      onClose: onClose,
      containerPadding: const EdgeInsets.all(16),
      child: DotsActionSheetSettingsContent(
        image: image,
        title: title,
        subtitle: subtitle,
        buttons: buttons,
        onTapCloseButton: onTapCloseButton,
        onImageError: onImageError,
        imageWidth: imageWidth,
        imageHeight: imageHeight,
      ),
    );
  }
}
