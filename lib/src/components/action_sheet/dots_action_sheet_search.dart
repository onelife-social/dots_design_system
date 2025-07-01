import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetSearch extends StatelessWidget {
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

  const DotsActionSheetSearch({
    super.key,
    required this.title,
    required this.description,
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
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Stack(
      children: [
        Container(
          child: showBackdrop
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _DotsActionSheetSearchHeader(title: title),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: topWidget,
                      ),
                    ),
                    if (primaryButton != null) primaryButton!,
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

  const _DotsActionSheetSearchHeader({
    required this.title,
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
              iconData: DotsIconData.search,
              iconDataButton: DotsIconData.cross,
              buttonVariant: DotsCloseButtonVariant.inverted,
              buttonSize: DotsCloseButtonSize.extraSmall,
              hintText: 'Subir en',
            ),
          ],
        ),
      ),
    );
  }
}
