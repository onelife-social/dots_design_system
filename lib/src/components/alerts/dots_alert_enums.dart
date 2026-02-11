enum DotsAlertVariant {
  noButtons,
  oneButton,
  twoHorizontalButtons,
  twoHorizontalButtonsDestructive,
  twoVerticalButtons,
  twoVerticalButtonsNoActive,
  twoVerticalButtonsDestructive,
  input,
  selector;

  bool get isNoButtons => this == DotsAlertVariant.noButtons;
  bool get isOneButton => this == DotsAlertVariant.oneButton;
  bool get isTwoHorizontalButtons => this == DotsAlertVariant.twoHorizontalButtons;
  bool get isTwoHorizontalButtonsDestructive =>
      this == DotsAlertVariant.twoHorizontalButtonsDestructive;
  bool get isTwoVerticalButtonsNoActive =>
      this == DotsAlertVariant.twoVerticalButtonsNoActive;
  bool get isTwoVerticalButtons => this == DotsAlertVariant.twoVerticalButtons;
  bool get isTwoVerticalButtonsDestructive =>
      this == DotsAlertVariant.twoVerticalButtonsDestructive;
  bool get isInput => this == DotsAlertVariant.input;
  bool get isSelector => this == DotsAlertVariant.selector;
}
