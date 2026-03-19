import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum PageControlVariant {
  main,
  background;

  bool get isMain => this == PageControlVariant.main;
  bool get isBackground => this == PageControlVariant.background;
}

class PageControl extends StatelessWidget {
  /// Total number of dots to render.
  final int count;

  /// Index of the dot that should use [activeColor].
  final int activeIndex;

  /// Color for the non-active dots. Defaults to a subdued color from theme.
  final Color? dotColor;

  /// Color for the active dot. Defaults to the theme's primary color.
  final Color? activeColor;

  /// Variant of the page control.
  final PageControlVariant variant;

  const PageControl({
    super.key,
    required this.count,
    int activeIndex = 0,
    this.dotColor,
    this.activeColor,
    this.variant = PageControlVariant.main,
  }) : activeIndex = count <= 0 || activeIndex < 0
           ? 0
           : (activeIndex > count - 1 ? count - 1 : activeIndex);

  @override
  Widget build(BuildContext context) {
    final dotsTheme = context.dotsTheme;
    final theme = getPageControlTheme(dotsTheme, variant, dotColor, activeColor);

    return Padding(
      padding: theme.contentPadding,
      child: SizedBox(
        width: double.infinity,
        height: count <= 0 ? theme.dotSize + theme.dotSpacing : null,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildDots(theme),
        ),
      ),
    );
  }

  List<Widget> _buildDots(
    PageControlThemeData theme,
  ) {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < count; i++) {
      final Color color = i == activeIndex ? theme.activeColor : theme.dotColor;

      Widget dot = Padding(
        padding: variant.isBackground
            ? EdgeInsets.all(theme.dotSpacing / 2)
            : EdgeInsets.symmetric(horizontal: theme.dotSpacing / 2),
        child: _Dot(size: theme.dotSize, color: color),
      );
      if (variant.isBackground) {
        dot = i <= activeIndex
            ? DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.activeBackgroundColor,
                  borderRadius: _getBorderRadius(
                    index: i,
                    activeIndex: activeIndex,
                    radius: (theme.dotSize + theme.dotSpacing) / 2,
                  ),
                ),
                child: dot,
              )
            : dot;
      }
      children.add(dot);
    }
    return children;
  }

  BorderRadius _getBorderRadius({
    required int index,
    required int activeIndex,
    required double radius,
  }) {
    if (index == 0) {
      if (index == activeIndex) return BorderRadius.circular(radius);
      return BorderRadius.only(
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      );
    }

    if (index == activeIndex) {
      return BorderRadius.only(
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      );
    }
    return BorderRadius.zero;
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
