import 'package:flutter/material.dart'; 
import '../../../dots_design_system.dart';


class DotsPlanningItemRow extends StatelessWidget {

  // Info item to be displayed in the row
  final DotsPlanningInfoItem item;
  final DotsTheme theme;

  const DotsPlanningItemRow({
    super.key,
    required this.item,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DotsIcon(
            iconData: item.icon,
            size: 16,
            color: theme.colors.labelPrimary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.text,
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