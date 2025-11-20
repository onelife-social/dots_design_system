import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetSearch extends StatelessWidget {
  final String title;
  final String hintText;
  final Widget topWidget;
  final Widget? bottomWidget;
  final VoidCallback onClose;
  final double bottomPosition;
  final double horizontalPadding;
  final ValueChanged<String>? onChanged;
  final double? maxHeight;
  final double stepProgress;
  final bool bigAspectRatio;
  final ScrollController? scrollController;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final DotsActionSheetButtonPositioning buttonPositioning;
  final bool backButtonShaderMask;
  final VoidCallback? onPrimaryButtonTap;
  final TextEditingController? textFieldController;
  final FocusNode? focus;
  final VoidCallback? onTapTextFieldBtn;
  final bool showCloseButton;
  final VoidCallback? onCloseButtonTap;

  const DotsActionSheetSearch({
    super.key,
    required this.title,
    required this.hintText,
    required this.topWidget,
    this.bottomWidget,
    required this.onClose,
    this.bottomPosition = 56,
    this.horizontalPadding = 16,
    this.maxHeight,
    this.stepProgress = 0,
    this.bigAspectRatio = true,
    this.scrollController,
    this.onChanged,
    this.primaryButton,
    this.secondaryButton,
    this.buttonPositioning = DotsActionSheetButtonPositioning.row,
    this.backButtonShaderMask = false,
    this.onPrimaryButtonTap,
    this.textFieldController,
    this.focus,
    this.onTapTextFieldBtn,
    this.showCloseButton = false,
    this.onCloseButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return DotsActionSheetContainer(
      bottomPosition: bottomPosition,
      horizontalPadding: horizontalPadding,
      maxHeight: maxHeight,
      onClose: onClose,
      showCloseButton: showCloseButton,
      onCloseButtonTap: onCloseButtonTap,
      child: DotsActionSheetSearchContent(
        title: title,
        hintText: hintText,
        topWidget: topWidget,
        onChanged: onChanged,
        primaryButton: primaryButton,
        onPrimaryButtonTap: onPrimaryButtonTap,
        textFieldController: textFieldController,
        focus: focus,
        onTapTextFieldBtn: onTapTextFieldBtn,
      ),
    );
  }
}
