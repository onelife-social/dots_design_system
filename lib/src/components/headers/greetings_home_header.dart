import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class GreetingsHomeHeader extends StatelessWidget {
  final String titleText;
  final String subtitleText;

  const GreetingsHomeHeader({
    super.key,
    required this.titleText,
    required this.subtitleText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Column(
      children: [
        Text(
          titleText,
          style: theme.typo.secondary.title02H6.copyWith(
            color: theme.colors.textPrimary,
          ),
        ),
        Text(
          subtitleText,
          style: theme.typo.main.labelDefaultRegular.copyWith(
            color: theme.colors.textQuarternary,
          ),
        ),
        const SizedBox(height: 27),
      ],
    );
  }
}
