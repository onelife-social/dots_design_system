enum DotsMainContainerVariant {
  main,
  secondary,
  onBackground,
  tertiary;

  bool get isMain => this == DotsMainContainerVariant.main;
  bool get isSecondary => this == DotsMainContainerVariant.secondary;
  bool get isOnBackground => this == DotsMainContainerVariant.onBackground;
  bool get isTertiary => this == DotsMainContainerVariant.tertiary;
}
