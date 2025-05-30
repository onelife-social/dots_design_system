import 'package:flutter/widgets.dart';

enum DotsMainButtonSize {
  mainAction(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
    height: 52,
    spacing: 6,
  ),
  large(
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    height: 44,
    spacing: 4,
  ),
  medium(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    height: 36,
    spacing: 4,
  ),
  small(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
    height: 28,
    spacing: 4,
  );

  final EdgeInsetsGeometry padding;
  final double height;
  final double spacing;

  const DotsMainButtonSize({required this.padding, required this.height, required this.spacing});
}

enum DotsMainButtonVariant {
  main,
  secondary,
  secondaryLight,
  secondaryDark,
  destructive,
  disabled,
  ghost,
  premium,
}
