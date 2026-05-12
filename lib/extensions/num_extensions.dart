import 'dart:math' show pi;

extension DoubleAngleExtension on double {
  double get toRadians => this * pi / 180;
}
