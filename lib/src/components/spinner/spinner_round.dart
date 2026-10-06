import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/// Color set of a [SpinnerRound].
enum SpinnerRoundTone {
  /// White arc and label over a translucent track. For photos and overlays.
  onPhoto,

  /// Blue arc over a grey track, label in `textSecondary`. For light backgrounds.
  accent,
}

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

  /// Color set. Defaults to [SpinnerRoundTone.onPhoto].
  final SpinnerRoundTone tone;

  const SpinnerRound({
    super.key,
    required this.progress,
    this.size = 43,
    this.strokeWidth = 4,
    this.showPercentage = true,
    this.tone = SpinnerRoundTone.onPhoto,
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
          tone: tone,
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

  /// Color set.
  final SpinnerRoundTone tone;

  CircularProgressPainter({
    required this.theme,
    required this.progress,
    required this.strokeWidth,
    this.startAngle = 270.0,
    this.showPercentageProgress = false,
    this.tone = SpinnerRoundTone.onPhoto,
  });

  // Converts progress (0..1) to radians.
  double _progressToRad(double p) => p * 2 * math.pi;

  // Converts degrees to radians.
  double _degToRad(double d) => d * math.pi / 180.0;

  Color get _trackColor => switch (tone) {
    SpinnerRoundTone.onPhoto => theme.colors.bgBtnImage,
    SpinnerRoundTone.accent => theme.colors.bgContainerSecondaryOnBackground,
  };

  Color get _arcColor => switch (tone) {
    SpinnerRoundTone.onPhoto => theme.colors.labelAlwaysWhite,
    SpinnerRoundTone.accent => theme.colors.labelHighlight,
  };

  Color get _labelColor => switch (tone) {
    SpinnerRoundTone.onPhoto => theme.colors.labelAlwaysWhite,
    SpinnerRoundTone.accent => theme.colors.textSecondary,
  };

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
      ..color = _trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, 2 * math.pi, false, trackPaint);

    // Progress arc
    final Paint progressPaint = Paint()
      ..color = _arcColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double sweep = _progressToRad(progress.clamp(0, 1));
    // A zero sweep with a round cap still paints a dot, so skip the arc at 0%.
    if (sweep > 0) {
      canvas.drawArc(rect, _degToRad(startAngle), sweep, false, progressPaint);
    }

    // Text
    if (!showPercentageProgress) return;

    final center = size.center(Offset.zero);
    final tp = TextPainter(
      text: TextSpan(
        text: '${(progress * 100).clamp(0, 100).toInt()}%',
        style: theme.typo.main.labelSmallMedium.copyWith(
          color: _labelColor,
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
      oldDelegate.startAngle != startAngle ||
      oldDelegate.tone != tone ||
      oldDelegate.theme != theme;
}
