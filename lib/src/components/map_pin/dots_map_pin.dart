import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// Dots map marker (Figma Chronicle `MapPin`, node 11714:3302): a `bgStrong` drop with a `friends008` →
/// `labelDestructive` gradient circle and the pin glyph, over a soft ground shadow. Fixed [size]; the tip of
/// the drop is the point on the map, at [anchor].
class DotsMapPin extends StatelessWidget {
  /// Box of the marker, as the Figma component.
  static const Size size = Size(46, 55);

  /// Where the marker points, from the top-left of its box: centred, 3.46 px above the bottom edge (the
  /// ground shadow is below it). A map that anchors the box's bottom centre has to move it that much down.
  static const Offset anchor = Offset(23, 51.5421);

  /// Read by screen readers (e.g. the venue's name). Without it, or with an empty one, the marker is decorative.
  final String? semanticsLabel;

  const DotsMapPin({
    super.key,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.dotsTheme.colors;

    final marker = SizedBox.fromSize(
      size: size,
      child: CustomPaint(
        painter: _MapPinPainter(
          surface: colors.bgStrong,
          groundShadow: colors.shadowPrimary,
          gradientStart: colors.friends008,
          gradientEnd: colors.labelDestructive,
        ),
      ),
    );

    final label = semanticsLabel;
    if (label == null || label.isEmpty) return ExcludeSemantics(child: marker);
    return Semantics(label: label, image: true, child: marker);
  }
}

class _MapPinPainter extends CustomPainter {
  final Color surface;
  final Color groundShadow;
  final Color gradientStart;
  final Color gradientEnd;

  const _MapPinPainter({
    required this.surface,
    required this.groundShadow,
    required this.gradientStart,
    required this.gradientEnd,
  });

  /// Figma drop shadow of the drop: y 1, blur 5, black 10% (no colour token).
  static const _dropShadow = Color(0x1A000000);

  static const _circleCenter = Offset(26.0002, 25);
  static const _circleRadius = 18.4446;

  static final Path _drop = Path()
    ..fillType = PathFillType.evenOdd
    ..moveTo(26, 4)
    ..cubicTo(37.598, 4, 47, 13.402, 47, 25)
    ..cubicTo(47, 32.4447, 43.1261, 38.9846, 37.284, 42.7139)
    ..cubicTo(35.0454, 44.1429, 32.8337, 45.6948, 31.2655, 47.8383)
    ..lineTo(27.1961, 53.4007)
    ..cubicTo(27.0612, 53.5858, 26.8821, 53.7369, 26.6739, 53.8412)
    ..cubicTo(26.4657, 53.9455, 26.2346, 54, 26, 54)
    ..cubicTo(25.7654, 54, 25.5343, 53.9455, 25.3261, 53.8412)
    ..cubicTo(25.1179, 53.7369, 24.9388, 53.5858, 24.8039, 53.4007)
    ..lineTo(20.7345, 47.8383)
    ..cubicTo(19.1663, 45.6948, 16.9546, 44.1429, 14.7159, 42.7139)
    ..cubicTo(8.87394, 38.9846, 5, 32.4447, 5, 25)
    ..cubicTo(5, 13.402, 14.402, 4, 26, 4)
    ..close();

  static final Path _glyph = Path()
    ..moveTo(29.8849, 19.4339)
    ..cubicTo(29.8849, 21.251, 28.6417, 22.7842, 26.9497, 23.2103)
    ..lineTo(26.9497, 29.752)
    ..cubicTo(26.9497, 32.8183, 26.414, 34.4653, 25.9988, 34.4653)
    ..cubicTo(25.575, 34.4653, 25.0392, 32.8051, 25.0392, 29.752)
    ..lineTo(25.0392, 23.2103)
    ..cubicTo(23.345, 22.7732, 22.115, 21.251, 22.115, 19.4339)
    ..cubicTo(22.115, 17.2852, 23.8392, 15.5347, 25.9988, 15.5347)
    ..cubicTo(28.1607, 15.5347, 29.8849, 17.2852, 29.8849, 19.4339)
    ..close()
    ..moveTo(23.5573, 18.3053)
    ..cubicTo(23.5573, 19.0267, 24.1775, 19.6446, 24.8857, 19.6446)
    ..cubicTo(25.6158, 19.6446, 26.214, 19.0267, 26.214, 18.3053)
    ..cubicTo(26.214, 17.5862, 25.6158, 16.977, 24.8857, 16.977)
    ..cubicTo(24.1775, 16.977, 23.5573, 17.5862, 23.5573, 18.3053)
    ..close();

  @override
  void paint(Canvas canvas, Size size) {
    // The Figma component clips its content to the 46 × 55 box.
    canvas.clipRect(Offset.zero & size);
    // The paths keep the coordinates of Figma's export (52 × 60, with room for the shadows).
    canvas.translate(-3, -2.45789);

    // Ground shadow: ellipse 16.2 × 2.9, layer blur 3
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(26, 53.9945), width: 16.22314, height: 2.85242),
      Paint()
        ..color = groundShadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
    );
    canvas.drawPath(
      _drop.shift(const Offset(0, 1)),
      Paint()
        ..color = _dropShadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5),
    );
    canvas.drawPath(_drop, Paint()..color = surface);

    final circle = Rect.fromCircle(center: _circleCenter, radius: _circleRadius);
    canvas.drawOval(
      circle,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [gradientStart, gradientEnd],
        ).createShader(circle),
    );
    canvas.drawPath(_glyph, Paint()..color = surface);
  }

  @override
  bool shouldRepaint(covariant _MapPinPainter oldDelegate) {
    return oldDelegate.surface != surface ||
        oldDelegate.groundShadow != groundShadow ||
        oldDelegate.gradientStart != gradientStart ||
        oldDelegate.gradientEnd != gradientEnd;
  }
}
