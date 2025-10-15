enum SegmentedControlOption {
  left,
  right;

  bool get isLeft => this == SegmentedControlOption.left;
  bool get isRight => this == SegmentedControlOption.right;
}
