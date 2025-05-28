import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
              child: SvgPicture.asset(
                'assets/svg/selector.svg',
                width: 15,
                height: 15,
                colorFilter: ColorFilter.mode(
                  theme.colors.labelHighlight,
                  BlendMode.srcIn,
                ),
              ),
            )
          : null,
    );
  }
}
