import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DotsStyles {
  static final light = DotsStylesModel(
    bgAlert: DotsStyleColorDodge(
      colorToDodge: Color(0xFF383838),
      mainColor: Color(0xD1B2B2B2),
      blur: 50,
    ),
    bgToast: DotsStyleColorDodge(
      colorToDodge: Color(0xA6383838),
      mainColor: Color(0xD1BABABA),
      blur: 50,
    ),
    bgPremiumPlus: DotsStyleColorGradient(
      startColor: Color(0xFFE9C058),
      endColor: Color(0xFFB48D2D),
    ),
    bgPremium: DotsStyleColorGradient(
      startColor: Color(0xFFC88EFF),
      endColor: Color(0xFF8B84F7),
    ),
    textPremiumPlus: DotsStyleColorGradient(
      startColor: Color(0xFFDDA61C),
      endColor: Color(0xFFA37F28),
    ),
    textPremium: DotsStyleColorGradient(
      startColor: Color(0xFFC17FFA),
      endColor: Color(0xFF8C84F7),
      beginAlignment: Alignment(0.00, 0.50),
      endAlignment: Alignment(0.60, 0.50),
    ),
    bgBasic: DotsStyleColorGradient(
      startColor: Color(0xFFA6C9E0),
      endColor: Color(0xFF7AA8CE),
      beginAlignment: Alignment(0.01, 0.51),
      endAlignment: Alignment(0.69, 0.51),
    ),
    textBasic: DotsStyleColorGradient(
      startColor: Color(0xFFA6C9E0),
      endColor: Color(0xFF7AA8CE),
      beginAlignment: Alignment(0.01, 0.51),
      endAlignment: Alignment(0.69, 0.51),
    ),
    bgBlur: DotsStyleBlur(
      blur: 50,
    ),
    blur50: DotsStyleBlur(
      blur: 50,
    ),
    blur12: DotsStyleBlur(
      blur: 12,
    ),
    blur10: DotsStyleBlur(
      blur: 10,
    ),
    floatingBtnShadow: DotsStyleShadow(
      color: Color(0x26000000),
      blurRadius: 15,
      offset: Offset(0, 4),
    ),
    toastShadow: DotsStyleShadow(
      color: Color(0x33000000),
      blurRadius: 20,
      blurStyle: BlurStyle.outer,
    ),
    defaultShadow: DotsStyleShadow(
      color: Color(0x1A000000),
      blurRadius: 20,
      offset: Offset(0, 6),
    ),
    defaultSquircle: DotsStyleSquircle(
      radius: 16,
      cornerSmoothing: 0.5,
    ),
    squircle24: DotsStyleSquircle(
      radius: 24,
      cornerSmoothing: 0.5,
    ),
  );

  static final dark = DotsStylesModel(
    bgAlert: DotsStyleColorDodge(
      colorToDodge: Color(0xE68C8C8C),
      mainColor: Color(0xD1252525),
      blur: 50,
    ),
    bgToast: DotsStyleColorDodge(
      colorToDodge: Color(0xA68C8C8C),
      mainColor: Color(0xD12E2E2E),
      blur: 50,
    ),
    bgPremiumPlus: DotsStyleColorGradient(
      startColor: Color(0xFFE9C058),
      endColor: Color(0xFFB48D2D),
    ),
    bgPremium: DotsStyleColorGradient(
      startColor: Color(0xFFC88EFF),
      endColor: Color(0xFF8B84F7),
    ),
    textPremiumPlus: DotsStyleColorGradient(
      startColor: Color(0xFFE9C058),
      endColor: Color(0xFFB48D2D),
    ),
    textPremium: DotsStyleColorGradient(
      startColor: Color(0xFFC17FFA),
      endColor: Color(0xFF8C84F7),
      beginAlignment: Alignment(0.00, 0.50),
      endAlignment: Alignment(0.60, 0.50),
    ),
    bgBasic: DotsStyleColorGradient(
      startColor: Color(0xFF8CB4CF),
      endColor: Color(0xFF508DBE),
      beginAlignment: Alignment(0.01, 0.51),
      endAlignment: Alignment(0.69, 0.51),
    ),
    textBasic: DotsStyleColorGradient(
      startColor: Color(0xFF8CB4CF),
      endColor: Color(0xFF508DBE),
      beginAlignment: Alignment(0.01, 0.51),
      endAlignment: Alignment(0.69, 0.51),
    ),
    bgBlur: DotsStyleBlur(
      blur: 50,
    ),
    blur50: DotsStyleBlur(
      blur: 50,
    ),
    blur12: DotsStyleBlur(
      blur: 12,
    ),
    blur10: DotsStyleBlur(
      blur: 10,
    ),
    floatingBtnShadow: DotsStyleShadow(
      color: Color(0x26000000),
      blurRadius: 15,
      offset: Offset(0, 4),
    ),
    toastShadow: DotsStyleShadow(
      color: Color(0x33000000),
      blurRadius: 20,
      blurStyle: BlurStyle.outer,
    ),
    defaultShadow: DotsStyleShadow(
      color: Color(0x1A000000),
      blurRadius: 20,
      offset: Offset(0, 6),
    ),
    defaultSquircle: DotsStyleSquircle(
      radius: 16,
      cornerSmoothing: 0.5,
    ),
    squircle24: DotsStyleSquircle(
      radius: 24,
      cornerSmoothing: 0.5,
    ),
  );
}
