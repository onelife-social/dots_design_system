import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/// A circular spinner widget that displays progress as an arc and optionally as a percentage.
class SpinnerRound extends StatelessWidget {
  /// Progress value between 0 and 1.
  final double progress;

  /// Size of the spinner in logical pixels.
  final double size;

  /// Width of the spinner's stroke.
  final double strokeWidth;

  /// Whether to show the percentage text in the center.
  final bool showPercentage;

  const SpinnerRound({
    super.key,
    required this.progress,
    this.size = 43,
    this.strokeWidth = 4,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: CircularProgressPainter(
          theme: context.dotsTheme,
          progress: progress,
          strokeWidth: strokeWidth,
          showPercentageProgress: showPercentage,
        ),
      ),
    );
  }
}

/// Circular progress indicator that paints a track + progress arc
class CircularProgressPainter extends CustomPainter {
  /// Theme for colors and typography.
  final DotsTheme theme;

  /// Progress value between 0 and 1.
  final double progress;

  /// Width of the arc stroke.
  final double strokeWidth;

  /// Starting angle in degrees for the progress arc.
  final double startAngle;

  /// Whether to show the percentage text in the center.
  final bool showPercentageProgress;

  CircularProgressPainter({
    required this.theme,
    required this.progress,
    required this.strokeWidth,
    this.startAngle = 270.0,
    this.showPercentageProgress = false,
  });

  // Converts progress (0..1) to radians.
  double _progressToRad(double p) => p * 2 * math.pi;

  // Converts degrees to radians.
  double _degToRad(double d) => d * math.pi / 180.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    // Base circle
    final Paint trackPaint = Paint()
      ..color = theme.colors.bgBtnImage
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, 2 * math.pi, false, trackPaint);

    // Progress arc
    final Paint progressPaint = Paint()
      ..color = theme.colors.labelAlwaysWhite
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double sweep = _progressToRad(progress.clamp(0, 1));
    canvas.drawArc(rect, _degToRad(startAngle), sweep, false, progressPaint);

    // Text
    if (!showPercentageProgress) return;

    final center = size.center(Offset.zero);
    final tp = TextPainter(
      text: TextSpan(
        text: '${(progress * 100).clamp(0, 100).toInt()}%',
        style: theme.typo.main.labelSmallMedium.copyWith(
          color: theme.colors.labelAlwaysWhite,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CircularProgressPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.showPercentageProgress != showPercentageProgress ||
      oldDelegate.startAngle != startAngle;
}
