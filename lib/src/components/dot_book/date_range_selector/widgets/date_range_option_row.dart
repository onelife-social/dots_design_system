import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotbookDateRangeOptionRow extends StatelessWidget {
  const DotbookDateRangeOptionRow({
    super.key,
    required this.title,
    this.description,
    required this.isSelected,
    this.onTap,
  });

  final String title;
  final String? description;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          children: [
            DotsRadioButton(isSelected: isSelected),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.typo.main.bodyLargeMedium.copyWith(
                      color: theme.colors.textPrimary,
                    ),
                  ),
                  if (description != null && description!.isNotEmpty)
                    Text(
                      description!,
                      style: theme.typo.main.bodyDefaultRegular.copyWith(
                        color: theme.colors.textTertiary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
