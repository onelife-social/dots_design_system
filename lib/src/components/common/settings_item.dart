import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum SettingsItemVariant {
  icon,
  toggle;

  bool get isIcon => this == SettingsItemVariant.icon;
  bool get isToggle => this == SettingsItemVariant.toggle;
}

class SettingsItem extends StatelessWidget {
  final SettingsItemVariant variant;
  final String label;
  final DotsIconData? startIcon;
  final DotsIconData? endIcon;
  final VoidCallback? onTap;
  final bool? toggleValue;
  final Function()? onToggleTap;

  const SettingsItem({
    super.key,
    required this.variant,
    required this.label,
    this.startIcon,
    this.endIcon,
    this.onTap,
    this.toggleValue,
    this.onToggleTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap ?? onToggleTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            if (startIcon != null)
              DotsIcon(
                iconData: startIcon!,
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
            _buildTrailing(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    switch (variant) {
      case SettingsItemVariant.icon:
        return DotsIcon(
          iconData: endIcon!,
          size: 20,
          color: context.dotsTheme.colors.textTertiary,
        );

      case SettingsItemVariant.toggle:
        return DotsToggle(isSelected: toggleValue!, onChanged: onToggleTap!());
    }
  }
}
