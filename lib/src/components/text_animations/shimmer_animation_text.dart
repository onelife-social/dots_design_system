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
  /// `0` keeps the base color only; `1` uses [shimmerColor] at full strength.
  /// Lower values produce a subtler glow (recommended around `0.25`–`0.5`).
  final double shimmerOpacity;

  /// How long to wait before and between each shimmer sweep.
  final Duration pauseDuration;

  /// How long each left-to-right or right-to-left sweep takes.
  final Duration shimmerDuration;

  /// Relative width of the highlight band (0 to 1 over the text bounds).
  final double highlightWidth;

  const ShimmerAnimationText({
    super.key,
    required this.child,
    required this.shimmerColor,
    this.baseColor,
    this.shimmerOpacity = 0.7,
    this.pauseDuration = const Duration(seconds: 2),
    this.shimmerDuration = const Duration(milliseconds: 1600),
    this.highlightWidth = 1,
  });

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
        final halfBand = _halfBand;

        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [center - halfBand, center, center + halfBand],
            ).createShader(bounds);
          },
          child: child!,
        );
      },
    );
  }
}
