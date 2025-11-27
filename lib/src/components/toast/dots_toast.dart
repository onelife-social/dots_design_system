import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsToast extends StatelessWidget {
  final bool isAction;
  final String title;
  final DotsToastVariant variant;
  final Color? customIconColor;

  const DotsToast({
    super.key,
    required this.title,
    required this.variant,
    required this.isAction,
    this.customIconColor,
  });

  Color iconColor(DotsTheme theme) {
    switch (variant) {
      case DotsToastVariant.success:
        return theme.colors.labelHighlight;
      case DotsToastVariant.error:
        return theme.colors.labelDestructive;
      case DotsToastVariant.info:
        return theme.colors.textTertiary;
      case DotsToastVariant.connectionResumed:
        return theme.colors.labelHighlight;
      case DotsToastVariant.connectionLost:
        return theme.colors.labelDestructive;
    }
  }

  DotsIconData iconData(DotsToastVariant variant, bool isAction) {
    switch (variant) {
      case DotsToastVariant.success:
        return DotsIconData.checkCircle;
      case DotsToastVariant.error:
        if (isAction) {
          return DotsIconData.trash;
        }
        return DotsIconData.crossCircle;
      case DotsToastVariant.info:
        return DotsIconData.alertCircle;
      case DotsToastVariant.connectionResumed:
        return DotsIconData.connectionOn;
      case DotsToastVariant.connectionLost:
        return DotsIconData.connectionOff;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    if (isAction) {
      return _ToastContainer(
        width: 160,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4,
          children: [
            DotsIcon(
              iconData: iconData(variant, isAction),
              color: customIconColor ?? iconColor(theme),
              size: 24,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.typo.main.bodyDefaultMedium.copyWith(color: theme.colors.textPrimary),
            ),
          ],
        ),
      );
    } else {
      return _ToastContainer(
        width: 358,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            DotsIcon(
              iconData: iconData(variant, isAction),
              color: customIconColor ?? iconColor(theme),
              size: 20,
            ),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: theme.typo.main.bodyDefaultMedium.copyWith(color: theme.colors.textPrimary),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class _ToastContainer extends StatelessWidget {
  const _ToastContainer({required this.child, this.width});

  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final decoration = BoxDecoration(
      color: context.dotsTheme.colors.bgContainerPrimary,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(
        width: 1.40,
        color: theme.colors.borderAlert,
      ),
    );

    return DotsDecoratedBox(
      styleType: context.dotsTheme.styles.toastShadow,
      decoration: decoration,
      child: SizedBox(
        width: width,
        child: DotsDecoratedBox(
          styleType: context.dotsTheme.styles.squircle24,
          decoration: decoration,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}
