import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetStandardContent extends StatelessWidget {
  final String title;
  final String? description;
  final Widget topWidget;
  final Widget? bottomWidget;
  final double stepProgress;
  final bool bigAspectRatio;
  final ScrollController? scrollController;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final DotsActionSheetButtonPositioning buttonPositioning;
  final bool backButtonShaderMask;

  const DotsActionSheetStandardContent({
    super.key,
    required this.title,
    this.description,
    required this.topWidget,
    this.bottomWidget,
    this.stepProgress = 0,
    this.bigAspectRatio = true,
    this.scrollController,
    this.primaryButton,
    this.secondaryButton,
    this.buttonPositioning = DotsActionSheetButtonPositioning.row,
    this.backButtonShaderMask = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final double spacing = bigAspectRatio ? 20 : 16;
    final bool hasTopWidgetHeight = _hasExplicitPositiveHeight(topWidget);

    return Stack(
      children: [
        SingleChildScrollView(
          controller: scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Grabber(),
              ),
              if (hasTopWidgetHeight) SizedBox(height: spacing),
              topWidget,
              SizedBox(height: spacing),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (hasTopWidgetHeight) const SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: theme.typo.secondary.title02H5,
                      ),
                    ),
                    if (description != null && description!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          description!,
                          textAlign: TextAlign.center,
                          style: theme.typo.main.bodyDefaultRegular.copyWith(
                            color: theme.colors.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
              if (bottomWidget != null) ...[
                SizedBox(height: spacing),
                bottomWidget!,
              ],
              if (stepProgress > 0) ...[
                SizedBox(height: spacing),
                DotsProgressBar(percentage: stepProgress),
              ],
              SizedBox(height: spacing),
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
        if (backButtonShaderMask) _BackdropFilterMask(),
        if (backButtonShaderMask) _LinearBlurMask(),
        if (primaryButton != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: DotsActionSheetStandardButtons(
              buttonPositioning: buttonPositioning,
              primaryButton: primaryButton!,
              secondaryButton: secondaryButton,
            ),
          ),
      ],
    );
  }
}

bool _hasExplicitPositiveHeight(Widget widget) {
  if (widget is SizedBox) {
    return (widget.height ?? 0) > 0;
  }

  if (widget is Container) {
    final constraints = widget.constraints;
    if (constraints == null) return false;
    if (constraints.maxHeight.isFinite) {
      return constraints.maxHeight > 0;
    }
    return constraints.minHeight > 0;
  }

  if (widget is ConstrainedBox) {
    if (widget.constraints.maxHeight.isFinite) {
      return widget.constraints.maxHeight > 0;
    }
    return widget.constraints.minHeight > 0;
  }

  return false;
}

double _calculateButtonAreaHeight({
  required DotsActionSheetButtonPositioning buttonPositioning,
  required Widget? primaryButton,
  required Widget? secondaryButton,
}) {
  final double noButtons = 0;
  final double oneButton = _calculateButtonHeight(primaryButton) + 16;
  final double twoButtons =
      _calculateButtonHeight(primaryButton) + _calculateButtonHeight(secondaryButton) + 16;

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

double _calculateButtonHeight(Widget? button) {
  if (button == null) return 0;
  if (button is DotsMainButton) return button.size.height;
  return DotsMainButtonSize.mainAction.height;
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
        ? Column(children: [primaryButton, if (secondaryButton != null) secondaryButton!])
        : secondaryButton != null
        ? Row(
            children: [
              Expanded(child: secondaryButton!),
              const SizedBox(width: 15),
              Expanded(child: primaryButton),
            ],
          )
        : primaryButton;
  }
}

class _LinearBlurMask extends StatelessWidget {
  const _LinearBlurMask();

  @override
  Widget build(BuildContext context) {
    final totalHeight = DotsMainButtonSize.mainAction.height + 26;
    final theme = context.dotsTheme;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
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
  const _BackdropFilterMask();

  @override
  Widget build(BuildContext context) {
    final totalHeight = DotsMainButtonSize.mainAction.height + 26;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: ClipRRect(
        borderRadius: DotsBorderRadius.bottom32,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 12),
          child: Container(height: totalHeight / 2, color: context.dotsTheme.colors.transparent),
        ),
      ),
    );
  }
}
