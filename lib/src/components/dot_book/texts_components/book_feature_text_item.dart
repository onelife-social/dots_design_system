import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BookFeatureTextItem extends StatelessWidget {
  /// Icon to display on the left side of the item.
  final DotsIconData icon;

  /// Title of book feature.
  final String title;

  /// Description of book feature.
  final String description;

  const BookFeatureTextItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DotsIcon(
            iconData: icon,
            size: 24,
            color: theme.colors.textTertiary,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        title ,
                        style: theme.typo.main.bodyDefaultMedium.copyWith(
                          color: theme.colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        style: theme.typo.main.bodyDefaultRegular.copyWith(
                          color: theme.colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
