import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActivityGroupHeader extends StatelessWidget {
  /// The text to display in the separator.
  final String text;

  /// An optional number to display alongside the text.
  final String? number;

  /// Whether to show a top line separator.
  /// Defaults to false.
  final bool topLineSeparator;

  const DotsActivityGroupHeader({
    super.key,
    required this.text,
    this.number,
    this.topLineSeparator = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final baseStyle = number != null ? theme.typo.main.bodyLargeBold : theme.typo.main.titleH5;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (topLineSeparator) DotsDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: baseStyle.copyWith(color: theme.colors.textPrimary),
              ),
              if (number != null) ...[
                const SizedBox(width: 6),
                Text(
                  number.toString(),
                  style: theme.typo.main.bodyLargeBold.copyWith(
                    color: theme.colors.textQuarternary,
                    height: 1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
