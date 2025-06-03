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

  const DotsIconButtonSize({required this.size, required this.iconSize});
}

enum DotsIconButtonVariant {
  solid,
  photo,
  active,
  noBackground,
}
