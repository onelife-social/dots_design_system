import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  /// The title/label to display above the settings items.
  final String? title;

  /// The description to display below the settings items.
  final String? description;

  /// The list of settings items to display.
  final List<SettingsItem> items;

  /// Horizontal padding for title and description text.
  final double textPadding;

  const SettingsList({
    super.key,
    this.title,
    this.description,
    required this.items,
    this.textPadding = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: textPadding, right: textPadding),
            child: Text(
              title!.toUpperCase(),
              style: theme.typo.main.labelDefaultMedium.copyWith(
                color: theme.colors.textTertiary,
              ),
            ),
          ),

        if (items.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              color: theme.colors.bgContainerSecondaryOnBackground,
              borderRadius: BorderRadius.circular(24),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: items.length,
              separatorBuilder: (_, __) => Divider(
                color: theme.colors.labelSecondary,
                thickness: 0.5,
                height: 0,
                indent: 44,
                endIndent: 16,
              ),
              itemBuilder: (_, index) => items[index],
            ),
          ),

        if (description != null)
          Padding(
            padding: EdgeInsets.only(top: 8.0, left: textPadding, right: textPadding),
            child: Text(
              description!,
              style: theme.typo.main.labelDefaultRegular.copyWith(
                color: theme.colors.textTertiary,
              ),
            ),
          ),
      ],
    );
  }
}
