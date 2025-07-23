enum SelectorRadioButtonLabelVariant {
  free,
  acquired,
  premiumPlus,
  premium;

  bool get isFree => this == SelectorRadioButtonLabelVariant.free;
  bool get isAcquired => this == SelectorRadioButtonLabelVariant.acquired;
  bool get isPremium => this == SelectorRadioButtonLabelVariant.premium;
  bool get isPremiumPlus => this == SelectorRadioButtonLabelVariant.premiumPlus;
}
