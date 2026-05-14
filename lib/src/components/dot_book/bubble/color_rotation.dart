import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../extensions/num_extensions.dart';
import '../../../core/constants.dart';

class ColorRotation extends StatefulWidget {
  static const String defaultAssetPath = 'assets/images/dotbook/bubble/bubble-color-rotate.webp';

  /// Raster asset path bundled under `assets/images/dotbook/`. When null, [defaultAssetPath] is used.
  final String? assetPath;

  /// When false, the widget stays at the current angle and the sequence stops.
  final bool animate;

  /// Width of the image box. Height follows the asset aspect ratio when set.
  final double? width;

  /// How the image is inscribed in the layout box.
  final BoxFit fit;

  /// Curve for each 800ms transition between target angles.
  final Curve curve;

  const ColorRotation({
    super.key,
    this.assetPath,
    this.animate = true,
    this.width,
    this.fit = BoxFit.contain,
    this.curve = Curves.linear,
  });

  @override
  State<ColorRotation> createState() => _ColorRotationState();
}

class _ColorRotationState extends State<ColorRotation> with SingleTickerProviderStateMixin {
  static const int _kTransitionMilliseconds = 800;
  static const int _kDelayMilliseconds = 200;

  static final List<double> _targetsDeg = <double>[0, -163, -2];

  late final AnimationController _controller;
  Animation<double>? _rotation;

  double _restAngle = 0;

  bool _loopRunning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _kTransitionMilliseconds),
    );
    if (widget.animate) {
      unawaited(_ensureLoop());
    }
  }

  @override
  void didUpdateWidget(covariant ColorRotation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.animate && oldWidget.animate) {
       _restAngle = _rotation?.value ?? _restAngle;
      _controller.stop();
    } else if (widget.animate && !oldWidget.animate) {
      unawaited(_ensureLoop());
    }
  }

  Future<void> _ensureLoop() async {
    if (_loopRunning) return;
    _loopRunning = true;
    try {
      await _runLoop();
    } finally {
      _loopRunning = false;
    }
  }

  Future<void> _runLoop() async {
    while (mounted && widget.animate) {
      for (final double degrees in _targetsDeg) {
        if (!mounted || !widget.animate) return;
        await _animateTo(degrees.toRadians);
        if (!mounted || !widget.animate) return;
        await Future<void>.delayed(Duration(milliseconds: _kDelayMilliseconds));
      }
    }
  }

  Future<void> _animateTo(double targetRadians) async {
    final double begin = _restAngle;
    _rotation = Tween<double>(begin: begin, end: targetRadians).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    try {
      await _controller.forward(from: 0).orCancel;
    } on TickerCanceled {
      return;
    }
    if (!mounted) return;
    _restAngle = targetRadians;
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = Image.asset(
      widget.assetPath ?? ColorRotation.defaultAssetPath,
      package: dotsDesignSystemPackage,
      width: widget.width,
      fit: widget.fit,
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _rotation?.value ?? _restAngle,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: image,
    );
  }
}
