import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// A group of up to three [BadgeIcon]s laid out.
class BadgeIconGroup extends StatelessWidget {
  const BadgeIconGroup({
    super.key,
    required this.icons,
    this.iconColors,
    this.onTap,
  }) : assert(
          icons.length >= 1 && icons.length <= 3,
          'BadgeIconGroup supports from 1 to 3 icons.',
        );

  /// Icons to render in the group.
  final List<DotsIconData> icons;

  /// Optional colors, one per icon (up to 3). If null or shorter, missing icons use theme default.
  final List<Color?>? iconColors;

  /// Optional callback when an icon is tapped.
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    if (icons.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: 63,
      height: 70,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: BadgeIcon(
              icon: icons[0],
              size: BadgeIconSize.medium,
              iconColor: iconColors?.elementAtOrNull(0),
              onTap: onTap?.call(0),
            ),
          ),
          if (icons.length >= 2)
            Positioned(
              left: icons.length == 3 ? 4 : 31,
              bottom: icons.length == 3 ? 42 : 31,
              child: BadgeIcon(
                icon: icons[1],
                size: BadgeIconSize.small,
                iconColor: iconColors?.elementAtOrNull(1),
                onTap: onTap?.call(1),
              ),
            ),
          if (icons.length == 3)
            Positioned(
              left: 35,
              bottom: 26,
              child: BadgeIcon(
                icon: icons[2],
                size: BadgeIconSize.small,
                iconColor: iconColors?.elementAtOrNull(2),
                onTap: onTap?.call(2),
              ),
            ),
        ],
      ),
    );
  }
}

