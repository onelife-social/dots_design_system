import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheet extends StatelessWidget {
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
  final Widget primaryButton;
  final Widget? secondaryButton;
  final bool showBackdrop;

  const DotsActionSheet({
    super.key,
    required this.title,
    required this.description,
    required this.primaryButton,
    this.secondaryButton,
    required this.topWidget,
    this.bottomWidget,
    required this.onClose,
    this.bottomPosition = 56,
    this.horizontalPadding = 16,
    this.maxHeight,
    this.stepProgress = 0,
    this.bigAspectRatio = true,
    this.scrollController,
    this.showBackdrop = true,
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
                padding: const EdgeInsets.all(16),
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
                          Container(
                            width: 36,
                            height: 4,
                            decoration: ShapeDecoration(
                              color: theme.colors.bgSecondaryBtn,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.50),
                              ),
                            ),
                          ),
                          topWidget,
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: bigAspectRatio ? 22 : 16,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(title,
                                      textAlign: TextAlign.center,
                                      style: bigAspectRatio
                                          ? theme.typo.main.titleH6
                                          : theme.typo.main.bodyLargeBold),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(description,
                                      textAlign: TextAlign.center,
                                      style: theme.typo.main.labelDefaultRegular),
                                ),
                              ],
                            ),
                          ),
                          if (bottomWidget != null) bottomWidget!,
                          if (stepProgress > 0) DotsProgressBar(percentage: stepProgress),
                          SizedBox(
                            height: DotsMainButtonSize.mainAction.height,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: DotsActionSheetButtons(
                        primaryButton: primaryButton,
                        secondaryButton: secondaryButton,
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

class DotsActionSheetButtons extends StatelessWidget {
  final Widget primaryButton;
  final Widget? secondaryButton;

  const DotsActionSheetButtons({super.key, required this.primaryButton, this.secondaryButton});

  @override
  Widget build(BuildContext context) {
    return secondaryButton != null
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
