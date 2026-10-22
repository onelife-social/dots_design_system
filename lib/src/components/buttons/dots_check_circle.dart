import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// Multi-select check for solid backgrounds; the single-select sibling is
/// [DotsRadioButton]. Over photos use [DotsSelector] instead.
class DotsCheckCircle extends StatelessWidget {
  const DotsCheckCircle({
    super.key,
    required this.isSelected,
    this.size = 24.0,
  });

  final bool isSelected;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? theme.colors.labelHighlight : Colors.transparent,
        border: isSelected ? null : Border.all(color: theme.colors.labelSecondary, width: 2),
      ),
      child: isSelected
          ? Center(
              child: DotsIcon(
                iconData: DotsIconData.check,
                size: 14,
                color: theme.colors.labelAlwaysWhite,
              ),
            )
          : null,
    );
  }
}
