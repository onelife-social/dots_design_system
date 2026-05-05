import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotbookDateFieldCard extends StatelessWidget {
  const DotbookDateFieldCard({
    super.key,
    required this.label,
    required this.value,
    required this.isActive,
    this.onTap,
  });

  final String label;
  final String value;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 13, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: theme.colors.bgContainerSecondary,
          borderRadius: DotsBorderRadius.r16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(
              label,
              style: theme.typo.main.labelDefaultRegular.copyWith(
                color: theme.colors.textQuarternary,
              ),
            ),
            Text(
              value,
              style: theme.typo.main.bodyLargeMedium.copyWith(
                color: isActive ? theme.colors.labelHighlight : theme.colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
