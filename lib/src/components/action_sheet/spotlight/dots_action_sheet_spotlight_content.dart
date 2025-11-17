import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetSpotlightContent extends StatelessWidget {
  final String title;
  final String? label;
  final String? description;
  final Widget topWidget;
  final Widget? bottomWidget;
  final Widget primaryButton;
  final bool showCloseButton;
  final VoidCallback? onClose;

  const DotsActionSheetSpotlightContent({
    super.key,
    required this.title,
    this.label,
    this.description,
    required this.topWidget,
    this.bottomWidget,
    required this.primaryButton,
    this.showCloseButton = false,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(height: 16),
              topWidget,
              SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.typo.secondary.title02H6,
                    ),
                  ),
                  if (label != null) ...[
                    SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        label!,
                        textAlign: TextAlign.center,
                        style: theme.typo.main.labelDefaultMedium.copyWith(
                          color: theme.colors.textTertiary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                  if (description != null) ...[
                    SizedBox(height: 12),
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
                  ],
                ],
              ),
              if (bottomWidget != null) ...[
                SizedBox(height: 16),
                bottomWidget!,
              ],
              SizedBox(height: bottomWidget != null ? 20 : 28),
              primaryButton,
              SizedBox(height: 15),
            ],
          ),
        ),
        if (showCloseButton)
          Positioned(
            top: 12,
            right: 0,
            child: DotsCloseButton(
              onTap: onClose,
              size: DotsCloseButtonSize.medium,
              variant: DotsCloseButtonVariant.softContrast,
              addBlur: false,
            ),
          ),
      ],
    );
  }
}
