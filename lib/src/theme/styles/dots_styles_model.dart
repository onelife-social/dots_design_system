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
  final DotsStyleBlur blur20;
  final DotsStyleBlur blur30;
  final DotsStyleBlur blur40;
  final DotsStyleBlur blur12;
  final DotsStyleBlur blur10;
  final DotsStyleShadow floatingBtnShadow;
  final DotsStyleShadow toastShadow;
  final DotsStyleShadow defaultShadow;
  final DotsStyleSquircle defaultSquircle;
  final DotsStyleSquircle squircle8;
  final DotsStyleSquircle squircle12;
  final DotsStyleSquircle squircle15;
  final DotsStyleSquircle squircle16;
  final DotsStyleSquircle squircle20;
  final DotsStyleSquircle squircle24;
  final DotsStyleSquircle squircle28;
  final DotsStyleSquircle squircle32;
  final DotsStyleSquircle squircle52;

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
    required this.blur30,
    required this.blur20,
    required this.blur40,
    required this.blur12,
    required this.blur10,
    required this.floatingBtnShadow,
    required this.toastShadow,
    required this.defaultShadow,
    required this.defaultSquircle,
    required this.squircle8,
    required this.squircle12,
    required this.squircle15,
    required this.squircle16,
    required this.squircle20,
    required this.squircle24,
    required this.squircle28,
    required this.squircle32,
    required this.squircle52,
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
      blur40: blur40.lerp(other.blur40, t) ?? blur40,
      blur30: blur30.lerp(other.blur30, t) ?? blur30,
      blur20: blur20.lerp(other.blur20, t) ?? blur20,
      blur12: blur12.lerp(other.blur12, t) ?? blur12,
      blur10: blur10.lerp(other.blur10, t) ?? blur10,
      floatingBtnShadow: floatingBtnShadow.lerp(other.floatingBtnShadow, t) ?? floatingBtnShadow,
      toastShadow: toastShadow.lerp(other.toastShadow, t) ?? toastShadow,
      defaultShadow: defaultShadow.lerp(other.defaultShadow, t) ?? defaultShadow,
      defaultSquircle: defaultSquircle.lerp(other.defaultSquircle, t) ?? defaultSquircle,
      squircle8: squircle8.lerp(other.squircle8, t) ?? squircle8,
      squircle12: squircle12.lerp(other.squircle12, t) ?? squircle12,
      squircle15: squircle15.lerp(other.squircle15, t) ?? squircle15,
      squircle16: squircle16.lerp(other.squircle16, t) ?? squircle16,
      squircle20: squircle20.lerp(other.squircle20, t) ?? squircle20,
      squircle24: squircle24.lerp(other.squircle24, t) ?? squircle24,
      squircle28: squircle28.lerp(other.squircle28, t) ?? squircle28,
      squircle32: squircle32.lerp(other.squircle32, t) ?? squircle32,
      squircle52: squircle52.lerp(other.squircle52, t) ?? squircle52,
    );
  }
}
