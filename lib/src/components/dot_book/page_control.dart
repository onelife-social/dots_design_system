import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class PageControl extends StatelessWidget {
  /// Total number of dots to render.
  final int count;

  /// Index of the dot that should use [activeColor].
  final int activeIndex;

  /// Color for the non-active dots. Defaults to a subdued color from theme.
  final Color? dotColor;

  /// Color for the active dot. Defaults to the theme's primary color.
  final Color? activeColor;

  const PageControl({
    super.key,
    required this.count,
    this.activeIndex = 0,
    this.dotColor,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final Color baseDotColor =
        dotColor ?? theme.colors.labelSecondary;
    final Color selectedDotColor = activeColor ?? theme.colors.labelPrimary;

    if (count <= 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: const SizedBox(width: double.infinity, height: 8),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildDots(baseDotColor, selectedDotColor),
        ),
      ),
    );
  }

  List<Widget> _buildDots(Color baseDotColor, Color selectedDotColor) {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < count; i++) {
      final Color color = i == activeIndex ? selectedDotColor : baseDotColor;
      children.add(_Dot(color: color));
      if (i < count - 1) {
        children.add(const SizedBox(width: 8));
      }
    }
    return children;
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
