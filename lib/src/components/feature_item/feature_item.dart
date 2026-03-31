import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  final String feature;
  final String? value;
  final DotsIconData icon;

  const FeatureItem({super.key, required this.feature, this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      spacing: 8,
      children: [
        DotsIcon(iconData: icon, size: 16, color: theme.colors.textQuarternary),
        Expanded(
          flex: 6,
          child: Text(
            feature,
            style: theme.typo.main.bodyDefaultRegular.copyWith(
              color: theme.colors.textTertiary,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        if (value != null)
          Expanded(
            flex: 4,
            child: Text(
              value!,
              style: theme.typo.main.bodyDefaultMedium.copyWith(
                color: theme.colors.textSecondary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
      ],
    );
  }
}
