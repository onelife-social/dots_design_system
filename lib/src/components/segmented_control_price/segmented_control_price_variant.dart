enum SegmentedControlPriceVariant {
  single,
  dual;

  bool get isSingle => this == SegmentedControlPriceVariant.single;
  bool get isDual => this == SegmentedControlPriceVariant.dual;
}
