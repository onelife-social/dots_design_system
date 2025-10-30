import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetStandard extends StatelessWidget {
  final String title;
  final String description;
  final Widget topWidget;
  final Widget? bottomWidget;
  final VoidCallback onClose;
  final double bottomPosition;
  final double horizontalPadding;
  final double? maxHeight;
  final double stepProgress;
  final bool bigAspectRatio;
  final ScrollController? scrollController;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final DotsActionSheetButtonPositioning buttonPositioning;
  final bool showBackdrop;
  final bool backButtonShaderMask;
  final bool showCloseButton;
  final VoidCallback? onCloseButtonTap;

  const DotsActionSheetStandard({
    super.key,
    required this.title,
    this.description = '',
    required this.topWidget,
    this.bottomWidget,
    required this.onClose,
    this.bottomPosition = 56,
    this.horizontalPadding = 16,
    this.maxHeight,
    this.stepProgress = 0,
    this.bigAspectRatio = true,
    this.scrollController,
    this.primaryButton,
    this.secondaryButton,
    this.buttonPositioning = DotsActionSheetButtonPositioning.row,
    this.showBackdrop = true,
    this.backButtonShaderMask = false,
    this.showCloseButton = false,
    this.onCloseButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final double spacing = bigAspectRatio ? 20 : 16;

    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: (showBackdrop)
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Color(0xFF000000).dotsWithOpacity(0.3),
                  ),
                )
              : null,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: bottomPosition,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.8,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: theme.colors.bgBaseContrast,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: spacing,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Grabber(),
                          ),
                          topWidget,
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 8,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(title,
                                      textAlign: TextAlign.center,
                                      style: theme.typo.secondary.title02H6),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(description,
                                      textAlign: TextAlign.center,
                                      style: theme.typo.main.labelDefaultRegular.copyWith(
                                        color: theme.colors.textSecondary,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          if (bottomWidget != null) bottomWidget!,
                          if (stepProgress > 0) DotsProgressBar(percentage: stepProgress),
                          SizedBox(
                            height: _calculateButtonAreaHeight(
                              buttonPositioning: buttonPositioning,
                              primaryButton: primaryButton,
                              secondaryButton: secondaryButton,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showCloseButton)
                      Positioned(
                        top: 16,
                        right: 0,
                        child: DotsCloseButton(
                          icon: DotsIconData.cross,
                          size: DotsCloseButtonSize.medium,
                          variant: DotsCloseButtonVariant.softContrast,
                          onTap: onCloseButtonTap ?? onClose,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (backButtonShaderMask) _BackdropFilterMask(bottomPosition: bottomPosition),
        if (backButtonShaderMask) _LinearBlurMask(bottomPosition: bottomPosition),
        if (primaryButton != null)
          Positioned(
            left: 16,
            right: 16,
            bottom: bottomPosition + 16,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DotsActionSheetStandardButtons(
                buttonPositioning: buttonPositioning,
                primaryButton: primaryButton!,
                secondaryButton: secondaryButton,
              ),
            ),
          ),
      ],
    );
  }
}

double _calculateButtonAreaHeight({
  required DotsActionSheetButtonPositioning buttonPositioning,
  required Widget? primaryButton,
  required Widget? secondaryButton,
}) {
  final double noButtons = 16;
  final double oneButton = DotsMainButtonSize.mainAction.height + 16;
  final double twoButtons = DotsMainButtonSize.mainAction.height * 2 + 32;

  if (buttonPositioning == DotsActionSheetButtonPositioning.column) {
    if (primaryButton != null && secondaryButton != null) {
      return twoButtons;
    } else if (primaryButton == null && secondaryButton == null) {
      return noButtons;
    } else {
      return oneButton;
    }
  } else {
    if (primaryButton != null) {
      return oneButton;
    } else {
      return noButtons;
    }
  }
}

class DotsActionSheetStandardButtons extends StatelessWidget {
  final DotsActionSheetButtonPositioning buttonPositioning;
  final Widget primaryButton;
  final Widget? secondaryButton;

  const DotsActionSheetStandardButtons({
    super.key,
    required this.buttonPositioning,
    required this.primaryButton,
    this.secondaryButton,
  });

  @override
  Widget build(BuildContext context) {
    return buttonPositioning == DotsActionSheetButtonPositioning.column
        ? Column(
            children: [
              primaryButton,
              if (secondaryButton != null) const SizedBox(height: 15),
              if (secondaryButton != null) secondaryButton!,
            ],
          )
        : secondaryButton != null
            ? Row(
                children: [
                  Expanded(
                    child: secondaryButton!,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(child: primaryButton),
                ],
              )
            : primaryButton;
  }
}

class _LinearBlurMask extends StatelessWidget {
  final double bottomPosition;

  const _LinearBlurMask({required this.bottomPosition});

  @override
  Widget build(BuildContext context) {
    final totalHeight = DotsMainButtonSize.mainAction.height + 26;
    final theme = context.dotsTheme;

    return Positioned(
      left: 16,
      right: 16,
      bottom: bottomPosition,
      child: ClipRRect(
        borderRadius: DotsBorderRadius.bottom32,
        child: SizedBox(
          height: totalHeight,
          child: CustomPaint(
            size: Size(double.infinity, totalHeight),
            painter: LinearBlurPainter(
              topColor: theme.colors.gradientInitialLineal,
              bottomColor: theme.colors.gradientFinalLineal,
            ),
          ),
        ),
      ),
    );
  }
}

class _BackdropFilterMask extends StatelessWidget {
  final double bottomPosition;

  const _BackdropFilterMask({required this.bottomPosition});

  @override
  Widget build(BuildContext context) {
    final totalHeight = DotsMainButtonSize.mainAction.height + 26;
    return Positioned(
      left: 16,
      right: 16,
      bottom: bottomPosition,
      child: ClipRRect(
        borderRadius: DotsBorderRadius.bottom32,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 12),
          child: Container(
            height: totalHeight / 2,
            color: context.dotsTheme.colors.transparent,
          ),
        ),
      ),
    );
  }
}
