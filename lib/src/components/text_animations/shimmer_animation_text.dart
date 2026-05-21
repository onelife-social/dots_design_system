import 'package:flutter/material.dart';

class ShimmerAnimationText extends StatefulWidget {
  /// The text widget to animate (typically a [Text] or [RichText]).
  final Widget child;

  /// Base color of the text when the highlight is not passing over it.
  ///
  /// If null, uses [DefaultTextStyle] from the context.
  final Color? baseColor;

  /// Color of the moving highlight band at full intensity.
  final Color shimmerColor;

  /// How much the [shimmerColor] blends over [baseColor] at the peak of the band.
  ///
  /// Must be between `0` and `1` (inclusive).
  /// `0` keeps the base color only; `1` uses [shimmerColor] at full strength.
  /// Lower values produce a subtler glow (recommended around `0.25`–`0.5`).
  final double shimmerOpacity;

  /// How long to wait before and between each shimmer sweep.
  final Duration pauseDuration;

  /// How long each left-to-right or right-to-left sweep takes.
  final Duration shimmerDuration;

  /// Relative width of the highlight band over the text bounds.
  ///
  /// Must be greater than `0` and at most `1` (`1` spans the full text width).
  final double highlightWidth;

  const ShimmerAnimationText({
    super.key,
    required this.child,
    required this.shimmerColor,
    this.baseColor,
    this.shimmerOpacity = 0.7,
    this.pauseDuration = const Duration(milliseconds: 1200),
    this.shimmerDuration = const Duration(milliseconds: 1600),
    this.highlightWidth = 1,
  })  : assert(
          shimmerOpacity >= 0 && shimmerOpacity <= 1,
          'shimmerOpacity must be between 0 and 1',
        ),
        assert(
          highlightWidth > 0 && highlightWidth <= 1,
          'highlightWidth must be greater than 0 and at most 1',
        );

  @override
  State<ShimmerAnimationText> createState() => _ShimmerAnimationTextState();
}

class _ShimmerAnimationTextState extends State<ShimmerAnimationText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _offScreenPadding = 0.05;

  Duration get _cycleDuration => Duration(
        milliseconds:
            widget.pauseDuration.inMilliseconds * 2 + widget.shimmerDuration.inMilliseconds * 2,
      );

  double get _halfBand => widget.highlightWidth / 2;

  double get _offLeft => -_halfBand - _offScreenPadding;

  double get _offRight => 1 + _halfBand + _offScreenPadding;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _cycleDuration)..repeat();
  }

  @override
  void didUpdateWidget(ShimmerAnimationText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pauseDuration != widget.pauseDuration ||
        oldWidget.shimmerDuration != widget.shimmerDuration) {
      _controller
        ..duration = _cycleDuration
        ..repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Highlight position along the text, from `0` (left) to `1` (right).
  ///
  /// Cycle order: pause left → sweep left-to-right → pause right → sweep right-to-left.
  double _highlightCenter(double cycleValue) {
    final pauseMs = widget.pauseDuration.inMilliseconds;
    final shimmerMs = widget.shimmerDuration.inMilliseconds;
    final elapsedMs = cycleValue * _cycleDuration.inMilliseconds;
    final sweepSpan = _offRight - _offLeft;

    if (elapsedMs < pauseMs) {
      return _offLeft;
    }
    if (elapsedMs < pauseMs + shimmerMs) {
      final progress = (elapsedMs - pauseMs) / shimmerMs;
      return _offLeft + progress * sweepSpan;
    }
    if (elapsedMs < pauseMs + shimmerMs + pauseMs) {
      return _offRight;
    }

    final progress = (elapsedMs - pauseMs - shimmerMs - pauseMs) / shimmerMs;
    return _offRight - progress * sweepSpan;
  }

  Shader _createShimmerShader(Rect bounds, Color baseColor, Color highlightColor, double center) {
    const peak = 0.5;
    final halfBand = _halfBand;
    var leftStop = (peak - halfBand).clamp(0.0, 1.0);
    var rightStop = (peak + halfBand).clamp(0.0, 1.0);
    if (leftStop >= peak) leftStop = peak - 1e-4;
    if (rightStop <= peak) rightStop = peak + 1e-4;

    final gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [baseColor, highlightColor, baseColor],
      stops: [leftStop, peak, rightStop],
    );

    // Slide the gradient so the band peak aligns with [center] along the text width.
    // [center] increases left→right in the first sweep (see [_highlightCenter]).
    final shift = (center - peak) * bounds.width;
    final shaderRect = Rect.fromLTWH(
      bounds.left + shift,
      bounds.top,
      bounds.width,
      bounds.height,
    );

    return gradient.createShader(shaderRect);
  }

  @override
  Widget build(BuildContext context) {
    final baseColor =
        widget.baseColor ?? DefaultTextStyle.of(context).style.color ?? Colors.white;
    final highlightColor = Color.lerp(baseColor, widget.shimmerColor, widget.shimmerOpacity)!;

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final center = _highlightCenter(_controller.value);

        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) =>
              _createShimmerShader(bounds, baseColor, highlightColor, center),
          child: child!,
        );
      },
    );
  }
}
