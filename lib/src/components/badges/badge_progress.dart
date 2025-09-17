import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BadgeProgress extends StatelessWidget {
  /// Number to display on the left of tag.
  final int current;

  /// Number to display on the right of tag.
  final int max;

  const BadgeProgress({
    super.key,
    required this.current,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: ShapeDecoration(
        color: theme.colors.bgContainerSecondaryOnBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 2,
        children: [
          DotsIcon(
            iconData: DotsIconData.checkCircle,
            color: theme.colors.labelHighlight,
            size: 20,
          ),
          Text(
            '$current/$max',
            textAlign: TextAlign.center,
            style: theme.typo.main.labelDefaultMedium.copyWith(
              color: theme.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
