import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsToast extends StatelessWidget {
  // Indicates if the toast is an action type
  final bool isAction;

  // Title of the toast
  final String title;

  // Variant of the toast
  final DotsToastVariant variant;

  // Custom color for the icon
  final Color? customIconColor;

  // Callback for tap events
  final Function()? onTap;

  // Button title for info toasts
  final String? btnTitle;

  // Custom icon data
  final DotsIconData? customIconData;

  const DotsToast({
    super.key,
    required this.title,
    required this.variant,
    required this.isAction,
    this.customIconColor,
    this.onTap,
    this.btnTitle,
    this.customIconData,
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
      case DotsToastVariant.progress:
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
      case DotsToastVariant.connectionResumed:
        return DotsIconData.connectionOn;
      case DotsToastVariant.connectionLost:
        return DotsIconData.connectionOff;
      case DotsToastVariant.progress:
        return DotsIconData.progressSpinner;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    if (isAction) {
      return _ToastContainer(
        width: 160,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4,
          children: [
            DotsIcon(
              iconData: customIconData ?? iconData(variant, isAction),
              color: customIconColor ?? iconColor(theme),
              size: variant == DotsToastVariant.progress ? 20 : 24,
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
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          spacing: 12,
          children: [
            if (variant == DotsToastVariant.progress)
              _RotatingIcon(
                child: DotsIcon(iconData: customIconData ?? iconData(variant, isAction), size: 24),
              )
            else
              DotsIcon(
                iconData: customIconData ?? iconData(variant, isAction),
                color: customIconColor ?? iconColor(theme),
                size: 20,
              ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: theme.typo.main.bodyDefaultMedium.copyWith(color: theme.colors.textPrimary),
              ),
            ),
            if (btnTitle != null && variant == DotsToastVariant.progress)
              DotsMainButton(
                content: btnTitle!,
                variant: DotsMainButtonVariant.ghost,
                size: DotsMainButtonSize.medium,
                adaptPaddingForText: true,
              ),
          ],
        ),
      );
    }
  }
}

class _ToastContainer extends StatelessWidget {
  const _ToastContainer({required this.child, this.width, this.onTap});

  final double? width;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final decoration = BoxDecoration(
      color: context.dotsTheme.colors.bgContainerPrimary,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(width: 1.40, color: theme.colors.borderAlert),
    );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: DotsDecoratedBox(
        styleType: context.dotsTheme.styles.toastShadow,
        decoration: decoration,
        child: SizedBox(
          width: width,
          child: DotsDecoratedBox(
            styleType: context.dotsTheme.styles.squircle24,
            decoration: decoration,
            child: Padding(padding: const EdgeInsets.all(16), child: child),
          ),
        ),
      ),
    );
  }
}

class _RotatingIcon extends StatefulWidget {
  final Widget child;
  const _RotatingIcon({required this.child});

  @override
  State<_RotatingIcon> createState() => _RotatingIconState();
}

class _RotatingIconState extends State<_RotatingIcon> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _controller, child: widget.child);
  }
}
