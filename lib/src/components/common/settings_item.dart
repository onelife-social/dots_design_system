import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.label,
    required this.startIcon,
    required this.endIcon,
    required this.onTap,
  });

  final String label;
  final DotsIconData startIcon;
  final DotsIconData endIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            DotsIcon(
              iconData: startIcon,
              size: 20,
              color: context.dotsTheme.colors.textTertiary,
            ),
            Expanded(
              child: Text(
                label,
                style: context.dotsTheme.typo.main.bodyDefaultMedium.copyWith(
                  color: context.dotsTheme.colors.textPrimary,
                ),
              ),
            ),
            DotsIcon(
              iconData: endIcon,
              size: 20,
              color: context.dotsTheme.colors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
