import 'package:flutter/material.dart';

import '../../../../dots_design_system.dart';

class DotBookTextEditorBorder extends StatelessWidget {

  /// Color of the dashed border.
  final Color color;

  /// Radius of the rounded corners of the border.
  final double radius;

  /// Stroke width of the dashed border.
  final double strokeWidth;

  /// Length of each dash in the border.
  final double dashLength;

  /// Gap between each dash in the border.
  final double dashGap;

  /// Tap callback for the border layer.
  final Function()? onTap;

  /// Icon shown at the top-right corner.
  final DotsIconData cornerIcon;

  const DotBookTextEditorBorder({
    super.key,
    required this.color,
    this.radius = 8,
    this.strokeWidth = 2,
    this.dashLength = 10,
    this.dashGap = 2,
    this.onTap,
    this.cornerIcon = DotsIconData.edit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: _DashedRRectPainter(
                color: color,
                radius: radius,
                strokeWidth: strokeWidth,
                dashLength: dashLength,
                dashGap: dashGap,
              ),
              child: const SizedBox.expand(),
            ),
            Positioned(
              top: -10,
              right: -10,
              child: DotsIconButton(
                icon: cornerIcon,
                size: DotsIconButtonSize.small,
                style: DotsIconButtonStyle.floating,
                state: DotsIconButtonState.defaultState,
                color: theme.colors.textPrimary,
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;

  const _DashedRRectPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final RRect rRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final Path path = Path()..addRRect(rRect);

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double next = distance + dashLength;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance += dashLength + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) {
    return color != oldDelegate.color ||
        radius != oldDelegate.radius ||
        strokeWidth != oldDelegate.strokeWidth ||
        dashLength != oldDelegate.dashLength ||
        dashGap != oldDelegate.dashGap;
  }
}
