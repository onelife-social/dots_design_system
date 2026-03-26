import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DropdownItemDemoPage extends StatelessWidget {
  final String text;
  final DotsIconData? icon;
  final String subtitle;
  final DotsIconData? leadingIcon;
  final VoidCallback onTap;
  final Color? itemColor;

  const DropdownItemDemoPage({
    super.key,
    required this.text,
    this.icon,
    required this.subtitle,
    this.leadingIcon,
    required this.onTap,
    this.itemColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownItem(
          onTap: onTap,
          text: text,
          icon: icon,
          subtitle: subtitle,
          leading: leadingIcon == null
              ? null
              : DotsIcon(
                  iconData: leadingIcon!,
                  size: 16,
                  color: itemColor ?? context.dotsTheme.colors.textPrimary,
                ),
          itemColor: itemColor,
        ),
      ],
    );
  }
}
