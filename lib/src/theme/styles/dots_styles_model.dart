import 'package:dots_design_system/src/theme/styles/styles_lib.dart';

class DotsStylesModel {
  final DotsStyleColorDodge bgAlert;
  final DotsStyleColorDodge bgToast;
  final DotsStyleColorGradient bgPremiumPlus;
  final DotsStyleColorGradient bgPremium;
  final DotsStyleColorGradient textPremiumPlus;
  final DotsStyleColorGradient textPremium;
  final DotsStyleColorGradient bgBasic;
  final DotsStyleBlur bgBlur;

  DotsStylesModel({
    required this.bgAlert,
    required this.bgToast,
    required this.bgPremiumPlus,
    required this.bgPremium,
    required this.textPremiumPlus,
    required this.textPremium,
    required this.bgBasic,
    required this.bgBlur,
  });

  DotsStylesModel lerp(DotsStylesModel? other, double t) {
    if (other == null) return this;

    return DotsStylesModel(
      bgAlert: bgAlert.lerp(other.bgAlert, t) ?? bgAlert,
      bgToast: bgToast.lerp(other.bgToast, t) ?? bgToast,
      bgPremiumPlus: bgPremiumPlus.lerp(other.bgPremiumPlus, t) ?? bgPremiumPlus,
      bgPremium: bgPremium.lerp(other.bgPremium, t) ?? bgPremium,
      textPremiumPlus: textPremiumPlus.lerp(other.textPremiumPlus, t) ?? textPremiumPlus,
      textPremium: textPremium.lerp(other.textPremium, t) ?? textPremium,
      bgBasic: bgBasic.lerp(other.bgBasic, t) ?? bgBasic,
      bgBlur: bgBlur.lerp(other.bgBlur, t) ?? bgBlur,
    );
  }
}
