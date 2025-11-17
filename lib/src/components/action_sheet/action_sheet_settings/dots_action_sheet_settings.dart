import 'dart:ui';

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
    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: Container(
            child: showBlurBackground
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(color: Color(0xFF000000).dotsWithOpacity(0.3)),
                  )
                : null,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: bottomPosition,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: context.screenHeight * 0.8),
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: context.dotsTheme.colors.bgBaseContrast,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                ),
                child: Stack(
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
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
