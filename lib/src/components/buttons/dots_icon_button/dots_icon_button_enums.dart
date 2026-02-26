enum DotsIconButtonSize {
  enormous(size: 56, iconSize: 32, spacing: 2),
  extraLarge(size: 52, iconSize: 32, spacing: 2),
  large(size: 44, iconSize: 24, spacing: 2),
  medium(size: 36, iconSize: 20, spacing: 2),
  small(size: 28, iconSize: 14, spacing: 2),
  extraSmall(size: 22, iconSize: 14, spacing: 0);

  final double size;
  final double iconSize;
  final double spacing;
  bool get isXXLarge => this == DotsIconButtonSize.enormous;
  bool get isExtraLarge => this == DotsIconButtonSize.extraLarge;
  bool get isLarge => this == DotsIconButtonSize.large;
  bool get isMedium => this == DotsIconButtonSize.medium;
  bool get isSmall => this == DotsIconButtonSize.small;
  bool get isExtraSmall => this == DotsIconButtonSize.extraSmall;

  const DotsIconButtonSize({required this.size, required this.iconSize, required this.spacing});
}

@Deprecated('Use DotsIconButtonStyle and DotsIconButtonState instead')
enum DotsIconButtonVariant {
  solid,
  photo,
  active,
  noBackground,
  photoDisable;

  bool get isSolid => this == DotsIconButtonVariant.solid;
  bool get isPhoto => this == DotsIconButtonVariant.photo;
  bool get isActive => this == DotsIconButtonVariant.active;
  bool get isNoBackground => this == DotsIconButtonVariant.noBackground;
  bool get isPhotoDisable => this == DotsIconButtonVariant.photoDisable;
}

enum DotsIconButtonStyle {
  defaultStyle,
  onPhoto,
  floating,
  noBackground;

  bool get isSolid => this == DotsIconButtonStyle.defaultStyle;
  bool get isPhoto => this == DotsIconButtonStyle.onPhoto;
  bool get isActive => this == DotsIconButtonStyle.floating;
  bool get isNoBackground => this == DotsIconButtonStyle.noBackground;
}

enum DotsIconButtonState {
  defaultState,
  active,
  disabled,
  destructive;

  bool get isSolid => this == DotsIconButtonState.defaultState;
  bool get isPhoto => this == DotsIconButtonState.active;
  bool get isActive => this == DotsIconButtonState.disabled;
  bool get isDestructive => this == DotsIconButtonState.destructive;
}

enum DotsIconButtonDirection {
  column,
  row,
}

enum DotsSocialMediaVariant {
  instagram,
  tiktok,
  whatsapp;

  bool get isInstagram => this == DotsSocialMediaVariant.instagram;
  bool get isTikTok => this == DotsSocialMediaVariant.tiktok;
  bool get isWhatsApp => this == DotsSocialMediaVariant.whatsapp;
}
