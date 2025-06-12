enum DotsIconButtonSize {
  extraLarge(
    size: 56,
    iconSize: 24,
  ),
  large(
    size: 48,
    iconSize: 24,
  ),
  medium(
    size: 36,
    iconSize: 20,
  ),
  small(
    size: 28,
    iconSize: 20,
  ),
  extraSmall(
    size: 22,
    iconSize: 20,
  );

  final double size;
  final double iconSize;

  bool get isExtraLarge => this == DotsIconButtonSize.extraLarge;
  bool get isLarge => this == DotsIconButtonSize.large;
  bool get isMedium => this == DotsIconButtonSize.medium;
  bool get isSmall => this == DotsIconButtonSize.small;
  bool get isExtraSmall => this == DotsIconButtonSize.extraSmall;

  const DotsIconButtonSize({required this.size, required this.iconSize});
}

enum DotsIconButtonVariant {
  solid,
  photo,
  active,
  noBackground;

  bool get isSolid => this == DotsIconButtonVariant.solid;
  bool get isPhoto => this == DotsIconButtonVariant.photo;
  bool get isActive => this == DotsIconButtonVariant.active;
  bool get isNoBackground => this == DotsIconButtonVariant.noBackground;
}
