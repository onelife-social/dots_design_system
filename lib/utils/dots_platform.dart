import 'package:flutter/foundation.dart';

class DotsPlatform {
  static bool get isWeb => kIsWeb;

  static bool get isNotWeb => !kIsWeb;
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isAndroidMobile => defaultTargetPlatform == TargetPlatform.android && !isWeb;
  static bool get isComputerBrowser => isWeb && !isMobileWeb;
  static bool get isMobileWeb =>
      kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);
  static bool get isMobileIosWeb => kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isMobileAndroidWeb => kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  static bool get isMacos => defaultTargetPlatform == TargetPlatform.macOS;
  static String get platformName => defaultTargetPlatform.name;
}
