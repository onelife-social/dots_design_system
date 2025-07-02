import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsListItem extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function()? onTap;

  const DotsListItem({super.key, required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        spacing: 12,
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colors.bgBaseContrast,
              borderRadius: DotsBorderRadius.r12,
            ),
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: DotsBorderRadius.r12,
              child: icon,
            ),
          ),
          Expanded(child: Text(text, style: theme.typo.main.bodyLargeBold)),
        ],
      ),
    );
  }
}
