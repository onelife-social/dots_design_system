import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsActionSheetVariant {
  /// Default variant used in the gallery tutorial
  standard,

  /// Variant used for search popups
  search;

  bool get isStandard => this == DotsActionSheetVariant.standard;
  bool get isSearch => this == DotsActionSheetVariant.search;
}

enum DotsActionSheetButtonPositioning {
  /// Show both buttons side by side.
  row,

  /// Show the primary button on top of the secondary button.
  column;

  bool get isRow => this == DotsActionSheetButtonPositioning.row;
  bool get isColumn => this == DotsActionSheetButtonPositioning.column;
}

class DotsActionSheet extends StatelessWidget {
  /// The title of the Action Sheet.
  final String title;

  /// The hint text for the search variant.
  ///
  /// Defaults to ''.
  final String hintText;

  /// A short description displayed below the title.
  final String description;

  /// A widget displayed at the top of the Action Sheet (e.g., an icon, image, or header).
  final Widget topWidget;

  /// The variant of the Action Sheet.
  ///
  /// Defaults to [DotsActionSheetVariant.standard].
  final DotsActionSheetVariant variant;

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

  /// Callback when the text changes for the search variant.
  final ValueChanged<String>? onChanged;

  const DotsActionSheet({
    super.key,
    required this.title,
    this.hintText = '',
    this.description = '',
    required this.topWidget,
    this.variant = DotsActionSheetVariant.standard,
    this.bottomWidget,
    this.onChanged,
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
  });

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case DotsActionSheetVariant.standard:
        return DotsActionSheetStandard(
          title: title,
          description: description,
          topWidget: topWidget,
          bottomWidget: bottomWidget,
          onClose: onClose,
          bottomPosition: bottomPosition,
          horizontalPadding: horizontalPadding,
          maxHeight: maxHeight,
          stepProgress: stepProgress,
          bigAspectRatio: bigAspectRatio,
          scrollController: scrollController,
          primaryButton: primaryButton,
          secondaryButton: secondaryButton,
          buttonPositioning: buttonPositioning ?? DotsActionSheetButtonPositioning.row,
          showBackdrop: showBackdrop,
          backButtonShaderMask: backButtonShaderMask,
        );
      case DotsActionSheetVariant.search:
        return DotsActionSheetSearch(
          title: title,
          description: description,
          hintText: hintText,
          topWidget: topWidget,
          bottomWidget: bottomWidget,
          onClose: onClose,
          bottomPosition: bottomPosition,
          horizontalPadding: horizontalPadding,
          maxHeight: maxHeight,
          stepProgress: stepProgress,
          bigAspectRatio: bigAspectRatio,
          scrollController: scrollController,
          onChanged: onChanged,
          primaryButton: primaryButton,
          secondaryButton: secondaryButton,
          buttonPositioning: buttonPositioning ?? DotsActionSheetButtonPositioning.row,
          showBackdrop: showBackdrop,
          backButtonShaderMask: backButtonShaderMask,
        );
    }
  }
}
