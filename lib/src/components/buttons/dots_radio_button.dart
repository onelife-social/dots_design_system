import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsRadioButton extends StatelessWidget {
  const DotsRadioButton({
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
        border: Border.all(
          color: isSelected ? theme.colors.labelHighlight : theme.colors.labelSecondary,
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: DotsIcon(
              iconData: DotsIconData.selector,
              size: 15,
              color: theme.colors.labelHighlight,
            ))
          : null,
    );
  }
}
