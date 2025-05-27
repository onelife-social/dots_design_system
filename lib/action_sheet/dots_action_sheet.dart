import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheet extends StatelessWidget {
  final String title;
  final String description;
  final String primaryButtonText;
  final Function()? onPrimaryTapButtonPress;
  final String? secondaryButtonText;
  final Function()? onSecondaryTapButtonPress;
  final bool enableButton;
  final Widget topWidget;
  final Widget? bottomWidget;
  final VoidCallback onClose;
  final double bottomPosition;
  final double horizontalPadding;
  final double? maxHeight;
  final double stepProgress;
  final bool bigAspectRatio;
  final ScrollController? scrollController;

  const DotsActionSheet({
    super.key,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    this.onPrimaryTapButtonPress,
    this.secondaryButtonText,
    this.onSecondaryTapButtonPress,
    this.enableButton = true,
    required this.topWidget,
    this.bottomWidget,
    required this.onClose,
    this.bottomPosition = 56,
    this.horizontalPadding = 16,
    this.maxHeight,
    this.stepProgress = 0,
    this.bigAspectRatio = true,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: onClose,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Color(0xFF000000).dotsWithOpacity(0.3),
              ),
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: bigAspectRatio ? 20 : 12,
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
                          Flexible(
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: bigAspectRatio ? 20 : 12,
                                children: [
                                  topWidget,
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      spacing: 22,
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
                          ),
                        ],
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: DotsActionSheetButtons(
                          primaryButtonText: primaryButtonText,
                          onPrimaryTapButtonPress: onPrimaryTapButtonPress,
                          secondaryButtonText: secondaryButtonText,
                          onSecondaryTapButtonPress: onSecondaryTapButtonPress,
                          enableButton: enableButton,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DotsActionSheetButtons extends StatelessWidget {
  final String primaryButtonText;
  final Function()? onPrimaryTapButtonPress;
  final String? secondaryButtonText;
  final Function()? onSecondaryTapButtonPress;
  final bool enableButton;

  const DotsActionSheetButtons(
      {super.key,
      required this.primaryButtonText,
      this.onPrimaryTapButtonPress,
      this.secondaryButtonText,
      this.onSecondaryTapButtonPress,
      required this.enableButton});

  @override
  Widget build(BuildContext context) {
    return secondaryButtonText != null
        ? Row(
            children: [
              Expanded(
                child: DotsMainButton(
                  content: secondaryButtonText ?? '',
                  variant: DotsMainButtonVariant.secondary,
                  size: DotsMainButtonSize.mainAction,
                  enabled: enableButton,
                  onTap: onSecondaryTapButtonPress,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: DotsMainButton(
                  content: primaryButtonText,
                  variant: DotsMainButtonVariant.main,
                  size: DotsMainButtonSize.mainAction,
                  enabled: enableButton,
                  onTap: onPrimaryTapButtonPress,
                ),
              ),
            ],
          )
        : DotsMainButton(
            content: primaryButtonText,
            variant: DotsMainButtonVariant.main,
            size: DotsMainButtonSize.mainAction,
            enabled: enableButton,
            onTap: onPrimaryTapButtonPress,
          );
  }
}
