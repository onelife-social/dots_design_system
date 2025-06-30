import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsListItem extends StatelessWidget {
  final Widget icon;
  final String text;

  const DotsListItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      spacing: 12,
      children: [
        icon,
        Expanded(child: Text(text, style: theme.typo.main.bodyLargeBold)),
      ],
    );
  }
}
