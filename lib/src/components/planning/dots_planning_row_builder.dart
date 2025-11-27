import 'package:flutter/material.dart'; 
import '../../../dots_design_system.dart';


class DotsPlanningItemRow extends StatelessWidget {

  // Info item to be displayed in the row
  final DotsPlanningInfoItem item;

  const DotsPlanningItemRow({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    if (item.text == null || item.text!.trim().isEmpty || item.icon == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DotsIcon(
            iconData: item.icon!,
            size: 16,
            color: theme.colors.labelPrimary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.text!,
              style: theme.typo.main.bodyDefaultRegular.copyWith(
                color: theme.colors.textTertiary,
                decoration: item.underline
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}