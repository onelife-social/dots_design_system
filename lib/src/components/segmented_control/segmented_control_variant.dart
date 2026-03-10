enum SegmentedControlVariant {
  main,
  camera;

  bool get isMain => this == SegmentedControlVariant.main;
  bool get isCamera => this == SegmentedControlVariant.camera;
}
