import 'package:flutter/widgets.dart';

extension DotsColorExtensions on Color {
  /// [opacity] in 0.0–1.0. If [multiplyWithExisting] is true, multiplies the
  /// current alpha by [opacity]; otherwise replaces the alpha with [opacity].
  Color dotsWithOpacity(double opacity, {bool multiplyWithExisting = false}) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    final double alphaFactor = multiplyWithExisting ? a : 1.0;
    final double newAlpha = alphaFactor * opacity * 255;
    return withAlpha(newAlpha.round());
  }
}
