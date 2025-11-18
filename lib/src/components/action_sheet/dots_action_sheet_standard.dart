import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetStandard extends StatelessWidget {
  final String title;
  final String? description;
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
    this.description,
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
    return DotsActionSheetContainer(
      bottomPosition: bottomPosition,
      horizontalPadding: horizontalPadding,
      maxHeight: maxHeight,
      showBlurBackground: showBackdrop,
      onClose: onClose,
      showCloseButton: showCloseButton,
      onCloseButtonTap: onCloseButtonTap,
      child: DotsActionSheetStandardContent(
        title: title,
        description: description,
        topWidget: topWidget,
        bottomWidget: bottomWidget,
        stepProgress: stepProgress,
        bigAspectRatio: bigAspectRatio,
        scrollController: scrollController,
        primaryButton: primaryButton,
        secondaryButton: secondaryButton,
        buttonPositioning: buttonPositioning,
        backButtonShaderMask: backButtonShaderMask,
      ),
    );
  }
}
