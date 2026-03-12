import 'package:dots_design_system/src/theme/dots_theme.dart';
import 'package:flutter/material.dart';

enum BadgeIconSize {
  large(size: 44, iconSize: 24),
  medium(size: 36, iconSize: 20),
  small(size: 28, iconSize: 16);

  final double size;
  final double iconSize;

  bool get isLarge => this == BadgeIconSize.large;
  bool get isMedium => this == BadgeIconSize.medium;
  bool get isSmall => this == BadgeIconSize.small;

  const BadgeIconSize({required this.size, required this.iconSize});
}

enum BadgeIconStyle {
  white;

  bool get isWhite => this == BadgeIconStyle.white;

  /// Background color used as the badge icon container background.
  Color backgroundColor(DotsTheme theme) {
    return switch (this) {
      BadgeIconStyle.white => theme.colors.labelAlwaysWhite,
    };
  }

  /// Foreground color used for the icon.
  Color foregroundColor(DotsTheme theme) {
    return switch (this) {
      BadgeIconStyle.white => const Color(0xD9000000),
    };
  }
}
