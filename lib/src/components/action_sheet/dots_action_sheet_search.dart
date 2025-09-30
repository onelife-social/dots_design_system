import 'dart:ui';

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
  final bool showBackdrop;
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
    this.showBackdrop = true,
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
    final theme = context.dotsTheme;

    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: Container(
            child: showBackdrop
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
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _DotsActionSheetSearchHeader(
                          title: title,
                          onChanged: onChanged,
                          hintText: hintText,
                          textFieldController: textFieldController,
                          focus: focus,
                          onTapTextFieldBtn: onTapTextFieldBtn,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: topWidget,
                          ),
                        ),
                      ],
                    ),
                    if (primaryButton != null)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        height: 90,
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.0, 0.5, 1.0],
                                colors: [
                                  theme.colors.bgBaseContrast,
                                  theme.colors.bgBaseContrast,
                                  theme.colors.bgBaseContrast.dotsWithOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (primaryButton != null)
                      Positioned.fill(
                        top: null,
                        bottom: 16,
                        child: GestureDetector(
                          onTap: onPrimaryButtonTap,
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                primaryButton!,
                              ],
                            ),
                          ),
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
      ],
    );
  }
}

class _DotsActionSheetSearchHeader extends StatelessWidget {
  final String title;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textFieldController;
  final FocusNode? focus;
  final VoidCallback? onTapTextFieldBtn;

  const _DotsActionSheetSearchHeader({
    required this.title,
    required this.hintText,
    this.onChanged,
    this.textFieldController,
    this.focus,
    this.onTapTextFieldBtn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: IntrinsicHeight(
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: 190,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.dotsTheme.typo.secondary.title02H6,
                ),
              ),
            ),
            DotsTextField(
              controller: textFieldController,
              focusNode: focus,
              iconData: DotsIconData.search,
              iconDataButton: DotsIconData.cross,
              buttonVariant: DotsCloseButtonVariant.inverted,
              buttonSize: DotsCloseButtonSize.extraSmall,
              onChanged: onChanged,
              hintText: hintText,
              onTapBtn: onTapTextFieldBtn,
            ),
          ],
        ),
      ),
    );
  }
}
