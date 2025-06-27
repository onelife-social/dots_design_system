enum DotsCloseButtonSize {
  large(
    size: 44,
    iconSize: 20,
  ),
  medium(
    size: 30,
    iconSize: 16,
  ),
  small(
    size: 24,
    iconSize: 16,
  ),
  extraSmall(
    size: 16,
    iconSize: 10,
  );

  final double size;
  final double iconSize;

  bool get isLarge => this == DotsCloseButtonSize.large;
  bool get isMedium => this == DotsCloseButtonSize.medium;
  bool get isSmall => this == DotsCloseButtonSize.small;
  bool get isExtraSmall => this == DotsCloseButtonSize.extraSmall;

  const DotsCloseButtonSize({required this.size, required this.iconSize});
}

enum DotsCloseButtonVariant {
  softContrast,
  highContrast,
  inverted;

  bool get isSoftContrast => this == DotsCloseButtonVariant.softContrast;
  bool get isHighContrast => this == DotsCloseButtonVariant.highContrast;
  bool get isInverted => this == DotsCloseButtonVariant.inverted;

}
