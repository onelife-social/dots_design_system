import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActivityGroupHeader extends StatelessWidget {

  /// The text to display in the separator.
  final String text;

  /// Whether to show a top line separator.
  /// Defaults to false.
  final bool topLineSeparator;

  const DotsActivityGroupHeader({
    super.key,
    required this.text,
    this.topLineSeparator = false,
  });


  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (topLineSeparator)
          Divider(
            color: theme.colors.labelSecondary,
            height: 0.5,
            thickness: 1,
            endIndent: 0,
            indent: 0,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              text,
              style: theme.typo.main.bodyLargeBold.copyWith(
                color: theme.colors.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}