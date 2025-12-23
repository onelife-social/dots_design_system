import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  /// The title/label to display above the settings items.
  final String? title;

  /// The description to display below the settings items.
  final String? description;

  /// The list of settings items to display.
  final List<SettingsItem> items;

  const SettingsList({
    super.key,
    this.title,
    this.description,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final textPadding = 15.0;

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

        Container(
          decoration: BoxDecoration(
            color: theme.colors.bgContainerSecondaryOnBackground,
            borderRadius: BorderRadius.circular(24),
          ),
          child: items.isEmpty
              ? const SizedBox.shrink()
              : ListView.separated(
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
