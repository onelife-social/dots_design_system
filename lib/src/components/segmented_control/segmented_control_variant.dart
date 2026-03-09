enum SegmentedControlVariant {
  main,
  camera;

  bool get isCamera => this == SegmentedControlVariant.camera;
}
