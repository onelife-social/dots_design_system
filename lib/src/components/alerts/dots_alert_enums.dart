enum DotsAlertVariant {
  noButtons,
  oneButton,
  twoHorizontalButtons,
  twoVerticalButtons,
  input,
  selector;

  bool get isNoButtons => this == DotsAlertVariant.noButtons;
  bool get isOneButton => this == DotsAlertVariant.oneButton;
  bool get isTwoHorizontalButtons => this == DotsAlertVariant.twoHorizontalButtons;
  bool get isTwoVerticalButtons => this == DotsAlertVariant.twoVerticalButtons;
  bool get isInput => this == DotsAlertVariant.input;
  bool get isSelector => this == DotsAlertVariant.selector;
}
