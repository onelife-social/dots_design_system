import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetBase extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Function()? onBackButtonTap;
  final Widget child;
  final double bottomPosition;
  final double horizontalPadding;
  final double? maxHeight;
  final bool showBlurBackground;
  final VoidCallback? onClose;
  final VoidCallback? onTapCloseButton;
  final bool addTitlePadding;
  final TextStyle? titleStyle;
  const DotsActionSheetBase({
    super.key,
    required this.title,
    this.subtitle,
    this.onBackButtonTap,
    required this.child,
    this.bottomPosition = 56,
    this.horizontalPadding = 16,
    this.maxHeight,
    this.showBlurBackground = true,
    this.onClose,
    this.onTapCloseButton,
    this.addTitlePadding = false,
    this.titleStyle,
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
                      color: Color(0xFF000000).dotsWithOpacity(0.3),
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
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight ?? context.screenHeight * 0.8,
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colors.bgBaseContrast,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Header(
                          title: title,
                          subtitle: subtitle,
                          onBackButtonTap: onBackButtonTap,
                          titleStyle: titleStyle,
                          addTitlePadding: addTitlePadding,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: child,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onTapCloseButton != null)
                    Positioned(
                      top: 16,
                      right: 16,
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
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Function()? onBackButtonTap;
  final bool addTitlePadding;
  final TextStyle? titleStyle;
  const _Header({
    required this.title,
    required this.subtitle,
    required this.onBackButtonTap,
    required this.addTitlePadding,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return SizedBox(
      height: subtitle != null ? 60 : 40,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                if (onBackButtonTap != null)
                  Positioned.fill(
                    child: Row(
                      children: [
                        DotsIconButton(
                          icon: DotsIconData.chevronLeft,
                          size: DotsIconButtonSize.medium,
                          variant: DotsIconButtonVariant.noBackground,
                          onTap: onBackButtonTap,
                        ),
                      ],
                    ),
                  ),
                Positioned.fill(
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Padding(
                      padding: addTitlePadding
                          ? const EdgeInsets.symmetric(horizontal: 42)
                          : EdgeInsets.zero,
                      child: Text(
                        title,
                        style:
                            titleStyle ??
                            theme.typo.secondary.title02H6.copyWith(
                              color: theme.colors.textPrimary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle ?? '',
              style: theme.typo.main.labelDefaultRegular.copyWith(
                color: theme.colors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}
