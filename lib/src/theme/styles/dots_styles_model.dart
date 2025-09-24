import 'package:dots_design_system/src/theme/styles/styles_lib.dart';

class DotsStylesModel {
  final DotsStyleColorDodge bgAlert;
  final DotsStyleColorDodge bgToast;
  final DotsStyleColorGradient bgPremiumPlus;
  final DotsStyleColorGradient bgPremium;
  final DotsStyleColorGradient textPremiumPlus;
  final DotsStyleColorGradient textPremium;
  final DotsStyleColorGradient bgBasic;
  final DotsStyleColorGradient textBasic;
  final DotsStyleBlur bgBlur;
  final DotsStyleBlur blur50;
  final DotsStyleBlur blur12;
  final DotsStyleBlur blur10;
  final DotsStyleShadow floatingBtnShadow;
  final DotsStyleShadow toastShadow;
  final DotsStyleShadow defaultShadow;
  final DotsStyleSquircle defaultSquircle;
  final DotsStyleSquircle squircle24;
  final DotsStyleSquircle squircle8;
  final DotsStyleSquircle squircle12;

  DotsStylesModel({
    required this.bgAlert,
    required this.bgToast,
    required this.bgPremiumPlus,
    required this.bgPremium,
    required this.textPremiumPlus,
    required this.textPremium,
    required this.bgBasic,
    required this.textBasic,
    required this.bgBlur,
    required this.blur50,
    required this.blur12,
    required this.blur10,
    required this.floatingBtnShadow,
    required this.toastShadow,
    required this.defaultShadow,
    required this.defaultSquircle,
    required this.squircle24,
    required this.squircle8,
    required this.squircle12,
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
      textBasic: textBasic.lerp(other.textBasic, t) ?? textBasic,
      bgBlur: bgBlur.lerp(other.bgBlur, t) ?? bgBlur,
      blur50: blur50.lerp(other.blur50, t) ?? blur50,
      blur12: blur12.lerp(other.blur12, t) ?? blur12,
      blur10: blur10.lerp(other.blur10, t) ?? blur10,
      floatingBtnShadow: floatingBtnShadow.lerp(other.floatingBtnShadow, t) ?? floatingBtnShadow,
      toastShadow: toastShadow.lerp(other.toastShadow, t) ?? toastShadow,
      defaultShadow: defaultShadow.lerp(other.defaultShadow, t) ?? defaultShadow,
      defaultSquircle: defaultSquircle.lerp(other.defaultSquircle, t) ?? defaultSquircle,
      squircle24: squircle24.lerp(other.squircle24, t) ?? squircle24,
      squircle8: squircle8.lerp(other.squircle8, t) ?? squircle8,
      squircle12: squircle12.lerp(other.squircle12, t) ?? squircle12,
    );
  }
}
