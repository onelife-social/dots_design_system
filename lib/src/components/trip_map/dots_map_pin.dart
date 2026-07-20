import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// A themed teardrop map pin used to mark a location on a map.
class DotsMapPin extends StatelessWidget {
  const DotsMapPin({
    this.color,
    this.count,
    this.size = 40,
    this.child,
    super.key,
  });

  /// Fill color of the pin. Defaults to [DotsColorsModel.labelHighlight].
  final Color? color;

  /// When non-null, renders this number as a white bold cluster badge inside
  /// the pin head, taking priority over [child].
  final int? count;

  /// Overall pin height in logical pixels. Width scales proportionally.
  final double size;

  /// Optional content clipped to a circle and shown inside the pin head.
  ///
  /// Ignored when [count] is non-null.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final width = size * 0.72;

    return SizedBox(
      width: width,
      height: size,
      child: CustomPaint(
        painter: _DotsMapPinPainter(
          fillColor: color ?? theme.colors.labelHighlight,
          ringColor: theme.colors.labelAlwaysWhite,
          shadow: theme.styles.defaultShadow,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: size - width),
          child: Center(
            child: SizedBox(
              width: width * 0.6,
              height: width * 0.6,
              child: _DotsMapPinContent(
                count: count,
                textStyle: theme.typo.main.labelDefaultBold,
                textColor: theme.colors.labelAlwaysWhite,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DotsMapPinContent extends StatelessWidget {
  const _DotsMapPinContent({
    required this.count,
    required this.textStyle,
    required this.textColor,
    required this.child,
  });

  final int? count;
  final TextStyle textStyle;
  final Color textColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final count = this.count;
    if (count != null) {
      return Center(
        child: Text(
          '$count',
          style: textStyle.copyWith(color: textColor, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    final child = this.child;
    if (child != null) {
      return ClipOval(child: child);
    }

    return const SizedBox.shrink();
  }
}

class _DotsMapPinPainter extends CustomPainter {
  const _DotsMapPinPainter({
    required this.fillColor,
    required this.ringColor,
    required this.shadow,
  });

  final Color fillColor;
  final Color ringColor;
  final DotsStyleShadow shadow;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _teardropPath(size);

    final shadowPaint = Paint()
      ..color = shadow.color
      ..maskFilter = MaskFilter.blur(shadow.blurStyle, _sigmaFromRadius(shadow.blurRadius));
    canvas.drawPath(path.shift(shadow.offset), shadowPaint);

    canvas.drawPath(path, Paint()..color = fillColor);

    final ringPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06;
    canvas.drawPath(path, ringPaint);
  }

  Path _teardropPath(Size size) {
    final width = size.width;
    final height = size.height;
    final headRadius = width / 2;

    return Path()
      ..moveTo(width / 2, height)
      ..quadraticBezierTo(0, height * 0.6, 0, headRadius)
      ..arcToPoint(
        Offset(width, headRadius),
        radius: Radius.circular(headRadius),
        clockwise: true,
      )
      ..quadraticBezierTo(width, height * 0.6, width / 2, height)
      ..close();
  }

  double _sigmaFromRadius(double radius) => radius * 0.57735 + 0.5;

  @override
  bool shouldRepaint(covariant _DotsMapPinPainter oldDelegate) =>
      oldDelegate.fillColor != fillColor ||
      oldDelegate.ringColor != ringColor ||
      oldDelegate.shadow != shadow;
}
