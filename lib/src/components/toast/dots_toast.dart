import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsToast extends StatelessWidget {
  final bool isAction;
  final String title;
  final DotsToastVariant variant;

  const DotsToast({
    super.key,
    required this.title,
    required this.variant,
    required this.isAction,
  });

  Color iconColor(DotsTheme theme) {
    switch (variant) {
      case DotsToastVariant.success:
        return theme.colors.labelHighlight;
      case DotsToastVariant.error:
        return theme.colors.labelDestructive;
      case DotsToastVariant.info:
        return theme.colors.textTertiary;
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
                color: iconColor(theme),
                size: 24,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.typo.main.bodyDefaultMedium,
              ),
            ],
          ));
    } else {
      return _ToastContainer(
          width: 358,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              DotsIcon(
                iconData: iconData(variant, isAction),
                color: iconColor(theme),
                size: 24,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.typo.main.bodyDefaultMedium,
              ),
            ],
          ));
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
          styleType: context.dotsTheme.styles.bgToast,
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
