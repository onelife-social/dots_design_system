import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

const double _kThumbDiameter = 18;
const double _kThumbRadius = _kThumbDiameter / 2;
const double _kTickDiameter = 10;
const double _kTickRadius = _kTickDiameter / 2;
const double _kTickBorderWidth = 1.5;
const double _kTrackWidth = 4;
const double _kTrackInsetFromRight = 12;
const double _kLabelGap = 8;
const double _kDefaultWidth = 96;

/// One stop on a [DotsTripTimeline]: its position along the bar and date label.
class DotsTripTimelineStop {
  const DotsTripTimelineStop({required this.fraction, required this.label});

  /// Position down the bar, 0 (top/start) to 1 (bottom/end).
  final double fraction;

  /// Short date label shown next to the tick, e.g. "Jul 12".
  final String label;
}

/// A vertical progress scrubber: a top-to-bottom track filled to [progress],
/// with a labeled tick per stop and a draggable dot.
///
/// Presentational only — the consumer owns [progress] and updates it from
/// [onChanged]; this widget never mutates its own state.
class DotsTripTimeline extends StatelessWidget {
  const DotsTripTimeline({
    required this.progress,
    required this.stops,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.color,
    super.key,
  });

  /// Current dot position, 0..1 down the track.
  final double progress;

  /// Ticks rendered along the track.
  final List<DotsTripTimelineStop> stops;

  /// Fires with the new fraction (0..1) while dragging or tapping the track.
  final ValueChanged<double> onChanged;

  /// Fires once when a drag gesture begins.
  final VoidCallback? onChangeStart;

  /// Fires once when a drag gesture ends.
  final VoidCallback? onChangeEnd;

  /// Accent color for the fill, thumb, and passed ticks. Defaults to
  /// [DotsColorsModel.labelHighlight].
  final Color? color;

  double _fractionFromLocalY(double localY, double span) {
    if (span <= 0) return 0;
    return ((localY - _kThumbRadius) / span).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final accentColor = color ?? theme.colors.labelHighlight;
    final clampedProgress = progress.clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite ? constraints.maxWidth : _kDefaultWidth;
        final height = constraints.maxHeight.isFinite ? constraints.maxHeight : 0.0;
        final span = (height - _kThumbDiameter).clamp(0.0, double.infinity);
        final trackCenterX = width - _kTrackInsetFromRight;
        final maxLabelWidth = (trackCenterX - _kTickRadius - _kLabelGap).clamp(
          0.0,
          double.infinity,
        );

        void notify(Offset localPosition) {
          onChanged(_fractionFromLocalY(localPosition.dy, span));
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragStart: (details) {
            onChangeStart?.call();
            notify(details.localPosition);
          },
          onVerticalDragUpdate: (details) => notify(details.localPosition),
          onVerticalDragEnd: (_) => onChangeEnd?.call(),
          onTapDown: (details) {
            onChangeStart?.call();
            notify(details.localPosition);
            onChangeEnd?.call();
          },
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _Track(
                  centerX: trackCenterX,
                  top: _kThumbRadius,
                  bottom: height - _kThumbRadius,
                  color: theme.colors.fillSecondary,
                ),
                _TrackFill(
                  centerX: trackCenterX,
                  top: _kThumbRadius,
                  fillHeight: span * clampedProgress,
                  color: accentColor,
                ),
                for (final stop in stops) ...[
                  _TickDot(
                    centerX: trackCenterX,
                    centerY: _kThumbRadius + stop.fraction.clamp(0.0, 1.0) * span,
                    passed: stop.fraction <= clampedProgress,
                    accentColor: accentColor,
                  ),
                  _TickLabel(
                    centerY: _kThumbRadius + stop.fraction.clamp(0.0, 1.0) * span,
                    maxLabelWidth: maxLabelWidth,
                    label: stop.label,
                    passed: stop.fraction <= clampedProgress,
                  ),
                ],
                _Thumb(
                  centerX: trackCenterX,
                  centerY: _kThumbRadius + span * clampedProgress,
                  accentColor: accentColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Track extends StatelessWidget {
  const _Track({
    required this.centerX,
    required this.top,
    required this.bottom,
    required this.color,
  });

  final double centerX;
  final double top;
  final double bottom;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: centerX - _kTrackWidth / 2,
      top: top,
      width: _kTrackWidth,
      height: (bottom - top).clamp(0.0, double.infinity),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(_kTrackWidth / 2),
        ),
      ),
    );
  }
}

class _TrackFill extends StatelessWidget {
  const _TrackFill({
    required this.centerX,
    required this.top,
    required this.fillHeight,
    required this.color,
  });

  final double centerX;
  final double top;
  final double fillHeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: centerX - _kTrackWidth / 2,
      top: top,
      width: _kTrackWidth,
      height: fillHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(_kTrackWidth / 2),
        ),
      ),
    );
  }
}

/// The dot marking one stop's position on the track.
class _TickDot extends StatelessWidget {
  const _TickDot({
    required this.centerX,
    required this.centerY,
    required this.passed,
    required this.accentColor,
  });

  final double centerX;
  final double centerY;
  final bool passed;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Positioned(
      left: centerX - _kTickRadius,
      top: centerY - _kTickRadius,
      width: _kTickDiameter,
      height: _kTickDiameter,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: passed ? accentColor : theme.colors.bgContainerPrimary,
          border: Border.all(
            color: accentColor,
            width: passed ? 0 : _kTickBorderWidth,
          ),
        ),
      ),
    );
  }
}

/// A stop's date-label chip, right-aligned to the left of its tick and
/// vertically centered on it regardless of the label's rendered height.
class _TickLabel extends StatelessWidget {
  const _TickLabel({
    required this.centerY,
    required this.maxLabelWidth,
    required this.label,
    required this.passed,
  });

  final double centerY;
  final double maxLabelWidth;
  final String label;
  final bool passed;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Positioned(
      top: centerY,
      right: _kTrackInsetFromRight + _kTickRadius + _kLabelGap,
      child: FractionalTranslation(
        translation: const Offset(0, -0.5),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxLabelWidth),
          child: DotsDecoratedBox(
            styleType: theme.styles.defaultShadow,
            decoration: BoxDecoration(
              borderRadius: DotsBorderRadius.r8,
              color: theme.colors.bgContainerPrimary,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                label,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: passed
                    ? theme.typo.main.labelSmallBold.copyWith(color: theme.colors.textPrimary)
                    : theme.typo.main.labelSmallRegular.copyWith(color: theme.colors.textSecondary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({
    required this.centerX,
    required this.centerY,
    required this.accentColor,
  });

  final double centerX;
  final double centerY;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Positioned(
      left: centerX - _kThumbRadius,
      top: centerY - _kThumbRadius,
      width: _kThumbDiameter,
      height: _kThumbDiameter,
      child: DotsDecoratedBox(
        styleType: theme.styles.defaultShadow,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: accentColor,
          border: Border.all(color: theme.colors.labelAlwaysWhite, width: 2),
        ),
        child: const SizedBox.shrink(),
      ),
    );
  }
}
