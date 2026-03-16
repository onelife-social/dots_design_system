import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

import 'badge_icon_theme.dart';

class BadgeIcon extends StatelessWidget {
  const BadgeIcon({
    super.key,
    required this.icon,
    this.size = BadgeIconSize.large,
    this.style = BadgeIconStyle.white,
    this.iconColor,
    this.onTap,
  });

  /// The icon to display in the badge.
  final DotsIconData icon;

  /// The size of the badge (and default icon size).
  ///
  /// Defaults to [BadgeIconSize.large] (44px).
  final BadgeIconSize size;

  /// The visual style of the badge.
  ///
  /// Defaults to [BadgeIconStyle.white] (white background, dark icon).
  final BadgeIconStyle style;

  /// Optional color for the icon.
  final Color? iconColor;

  /// Optional callback when the icon is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final badgeTheme = getBadgeIconThemeByStyle(context.dotsTheme, style);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: size.size,
        width: size.size,
        child: DotsDecoratedBox(
          decoration: BoxDecoration(
            color: badgeTheme.backgroundColor,
            borderRadius: BorderRadius.circular(size.size),
            boxShadow: [
              BoxShadow(
              color: const Color(0x33000000),
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Center(
            child: DotsIcon(
              iconData: icon,
              size: size.iconSize,
              color: iconColor ?? badgeTheme.foregroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
