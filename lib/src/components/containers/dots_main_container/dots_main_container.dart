import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsMainContainer extends StatelessWidget {
  /// The visual variant of the container.
  ///
  /// Defaults to [DotsMainContainerVariant.main].
  final DotsMainContainerVariant? variant;

  /// The width of the container.
  ///
  /// Defaults to the full width of the screen if not specified.
  final double? width;

  /// The height of the container.
  ///
  /// Defaults to the full height of the screen if not specified.
  final double? height;

  /// The padding (in logical pixels) applied to the child widget.
  ///
  /// Defaults to `16.0`.
  final double? padding;

  /// The radius (in logical pixels) applied to the child widget.
  ///
  /// If the `height` is smaller than `100.0` defaults to `32.0`, otherwise `24.0`.
  final double? radius;

  /// The background color of the container.
  ///
  /// Defaults to a color based on [variant] if not specified.
  final Color? backgroundColor;

  /// The background image of the container.
  final DecorationImage? backgroundImage;

  /// Callback when the container is tapped.
  final VoidCallback? onTap;

  /// Widget inside the container.
  final Widget? child;

  /// Whether to force the height of the container.
  final bool forceHeight;

  const DotsMainContainer({
    super.key,
    this.variant = DotsMainContainerVariant.main,
    this.width,
    this.height,
    this.padding = 16.0,
    this.radius,
    this.backgroundColor,
    this.backgroundImage,
    this.onTap,
    this.child,
    this.forceHeight = true,
  });

  @override
  Widget build(BuildContext context) {
    final double containerWidth = width ?? MediaQuery.sizeOf(context).width;
    final double containerHeight = height ?? MediaQuery.sizeOf(context).height;
    final double containerRadius = radius ?? (containerHeight > 100 ? 32 : 24);
    final Color containerBackgroundColor = backgroundColor ?? _getContainerBackgroundColor(context);

    Widget container = Container(
      width: containerWidth,
      height: forceHeight ? containerHeight : null,
      decoration: BoxDecoration(
        color: containerBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(containerRadius)),
        image: backgroundImage,
      ),
      child: child != null
          ? Padding(
              padding: EdgeInsets.all(padding!),
              child: child,
            )
          : null,
    );

    if (onTap != null) {
      container = GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }

  Color _getContainerBackgroundColor(BuildContext context) {
    final colors = context.dotsTheme.colors;

    return switch (variant) {
      DotsMainContainerVariant.main => colors.bgContainerTertiary,
      DotsMainContainerVariant.secondary => colors.bgContainerSecondary,
      DotsMainContainerVariant.onBackground => colors.bgContainerSecondary,
      DotsMainContainerVariant.tertiary => colors.bgContainerPrimary,
      _ => colors.bgContainerTertiary,
    };
  }
}
