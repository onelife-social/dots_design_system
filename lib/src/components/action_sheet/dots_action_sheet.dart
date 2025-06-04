import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsActionSheetButtonPositioning {
  /// Show both buttons side by side.
  row,

  /// Show the primary button on top of the secondary button.
  column,
}

class DotsActionSheet extends StatelessWidget {
  /// The title of the Action Sheet.
  final String title;

  /// A short description displayed below the title.
  final String description;

  /// A widget displayed at the top of the Action Sheet (e.g., an icon, image, or header).
  final Widget topWidget;

  /// An optional widget displayed at the bottom of the Action Sheet (e.g., extra content or footer).
  final Widget? bottomWidget;

  /// Callback triggered when the Action Sheet is closed.
  final VoidCallback onClose;

  /// The vertical distance from the bottom of the screen to the Action Sheet.
  ///
  /// Defaults to 56.
  final double bottomPosition;

  /// Horizontal padding applied to the content inside the Action Sheet.
  ///
  /// Defaults to 16.
  final double horizontalPadding;

  /// Optional maximum height of the Action Sheet. If null, uses default sizing.
  final double? maxHeight;

  /// A value between 0 and 1 indicating the step progress (e.g., for onboarding).
  ///
  /// Defaults to 0.
  final double stepProgress;

  /// Whether to use a larger aspect ratio for the layout.
  ///
  /// Defaults to true.
  final bool bigAspectRatio;

  /// Optional scroll controller to manage scroll behavior inside the Action Sheet.
  final ScrollController? scrollController;

  /// The main action button displayed in the Action Sheet (e.g., "Continue", "Confirm").
  ///
  /// Required.
  final Widget? primaryButton;

  /// An optional secondary button (e.g., "Cancel", "Back").
  final Widget? secondaryButton;

  /// The position of the buttons in the Action Sheet.
  ///
  /// By deafault, it is set to [DotsActionSheetButtonPositioning.row]
  final DotsActionSheetButtonPositioning? buttonPositioning;

  /// Whether to show a semi-transparent backdrop behind the Action Sheet.
  ///
  /// Defaults to true.
  final bool showBackdrop;

  /// Whether to apply a shader mask to the back button.
  ///
  ///   Defaults to false.
  final bool backButtonShaderMask;

  const DotsActionSheet({
    super.key,
    required this.title,
    required this.description,
    this.primaryButton,
    this.secondaryButton,
    this.buttonPositioning = DotsActionSheetButtonPositioning.row,
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
    this.backButtonShaderMask = false,
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
                            child: Container(
                              width: 36,
                              height: 4,
                              decoration: ShapeDecoration(
                                color: theme.colors.bgSecondaryBtn,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.50),
                                ),
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
                            height: _calculateButtonAreaHeight(
                              buttonPositioning: buttonPositioning,
                              primaryButton: primaryButton,
                              secondaryButton: secondaryButton,
                            ),
                          ),
                        ],
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
              child: DotsActionSheetButtons(
                buttonPositioning: buttonPositioning!,
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
  required DotsActionSheetButtonPositioning? buttonPositioning,
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

class DotsActionSheetButtons extends StatelessWidget {
  final DotsActionSheetButtonPositioning buttonPositioning;
  final Widget primaryButton;
  final Widget? secondaryButton;

  const DotsActionSheetButtons({
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
