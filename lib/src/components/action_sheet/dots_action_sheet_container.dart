import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetContainer extends StatelessWidget {
  final Widget child;
  final double bottomPosition;
  final double horizontalPadding;
  final double? maxHeight;
  final bool showBlurBackground;
  final VoidCallback? onClose;
  final bool showCloseButton;
  final VoidCallback? onCloseButtonTap;
  final bool applyHorizontalPadding;
  final EdgeInsets? containerPadding;

  const DotsActionSheetContainer({
    super.key,
    required this.child,
    this.bottomPosition = 56,
    this.horizontalPadding = 16,
    this.maxHeight,
    this.showBlurBackground = true,
    this.onClose,
    this.showCloseButton = false,
    this.onCloseButtonTap,
    this.applyHorizontalPadding = true,
    this.containerPadding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Stack(
      children: [
        if (showBlurBackground)
          GestureDetector(
            onTap: onClose,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Color(0xFF000000).dotsWithOpacity(0.3),
              ),
            ),
          )
        else if (onClose != null)
          GestureDetector(
            onTap: onClose,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: bottomPosition,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight ?? context.screenHeight * 0.8,
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: containerPadding ?? (applyHorizontalPadding ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colors.bgBaseContrast,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: child,
                  ),
                  if (showCloseButton)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: DotsCloseButton(
                        icon: DotsIconData.cross,
                        size: DotsCloseButtonSize.medium,
                        variant: DotsCloseButtonVariant.softContrast,
                        addBlur: false,
                        onTap: onCloseButtonTap ?? onClose,
                      ),
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

