enum BadgeMilestoneVariant {
  main,
  ghost;

  bool get isMain => this == BadgeMilestoneVariant.main;
  bool get isGhost => this == BadgeMilestoneVariant.ghost;
}
