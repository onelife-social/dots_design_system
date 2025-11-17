import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetSettingsContent extends StatelessWidget {
  final VoidCallback? onTapCloseButton;
  final ImageProvider image;
  final ImageErrorListener? onImageError;
  final double imageWidth;
  final double imageHeight;
  final String title;
  final String? subtitle;
  final List<DotsSystemButton> buttons;

  const DotsActionSheetSettingsContent({
    super.key,
    required this.image,
    required this.title,
    required this.buttons,
    this.subtitle,
    this.onTapCloseButton,
    this.onImageError,
    this.imageWidth = 100,
    this.imageHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 24,
          children: [
            const Grabber(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 16,
                children: [
                  ImageWithIcon(
                    image: image,
                    onError: onImageError,
                    width: imageWidth,
                    height: imageHeight,
                    circularImage: true,
                  ),
                  Column(
                    spacing: 6,
                    children: [
                      Text(
                        title,
                        style: context.dotsTheme.typo.main.titleH5.copyWith(
                          color: context.dotsTheme.colors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: context.dotsTheme.typo.main.bodyDefaultRegular
                              .copyWith(
                                color: context.dotsTheme.colors.textPrimary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Column(spacing: 8, children: buttons),
          ],
        ),
        if (onTapCloseButton != null)
          Positioned(
            top: 0,
            right: 0,
            child: DotsCloseButton(
              size: DotsCloseButtonSize.medium,
              onTap: onTapCloseButton,
            ),
          ),
      ],
    );
  }
}

