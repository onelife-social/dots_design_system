import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

enum DotsSystemButtonSize {
  medium(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    height: 44,
    spacing: 6,
    iconSize: 20,
  );

  final EdgeInsetsGeometry padding;
  final double height;
  final double spacing;
  final double iconSize;

  bool get isMedium => this == DotsSystemButtonSize.medium;

  const DotsSystemButtonSize({
    required this.padding,
    required this.height,
    required this.spacing,
    required this.iconSize,
  });

  TextStyle getTextStyle(DotsTheme theme) {
    return theme.typo.main.bodyDefaultMedium;
  }
}

enum DotsSystemButtonVariant {
  active,
  disabled,
  destructive;

  bool get isActive => this == DotsSystemButtonVariant.active;
  bool get isDisabled => this == DotsSystemButtonVariant.disabled;
  bool get isDestructive => this == DotsSystemButtonVariant.destructive;
}
