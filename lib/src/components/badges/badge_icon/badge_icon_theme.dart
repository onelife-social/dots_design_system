import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class BadgeIconTheme {
  final Color backgroundColor;
  final Color foregroundColor;

  const BadgeIconTheme({
    required this.backgroundColor,
    required this.foregroundColor,
  });
}

BadgeIconTheme getBadgeIconThemeByStyle(DotsTheme theme, BadgeIconStyle style) {
  return BadgeIconTheme(
    backgroundColor: style.backgroundColor(theme),
    foregroundColor: style.foregroundColor(theme),
  );
}
