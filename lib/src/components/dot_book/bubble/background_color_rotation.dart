import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'color_rotation.dart';

/// [ColorRotation] for `bg-motion.webp`, scaled to cover the layout region.
///
/// The bitmap is larger than the painted disk; design constants [intrinsicCircleDiameter]
/// and [intrinsicHeight] relate viewport height to the reference circle size. Scale is
/// `viewportDiagonal / (height × intrinsicCircleDiameter / intrinsicHeight)`.
///
/// Layout uses a square side `max(width, height) × scale` so rotation stays covered.
///
/// The child is wrapped in an [OverflowBox] so [Center] does not clamp its size.
///
/// When [clipToViewport] is true (default), a [ClipRect] limits painting to this
/// widget’s layout bounds so the oversized asset does not draw on top of siblings.
///
/// Pass [width] (and usually [height]) for explicit dimensions; otherwise a
/// [LayoutBuilder] resolves size from constraints.
class BackgroundColorRotation extends StatelessWidget {
  static const String assetPath = 'assets/images/dotbook/bubble/bg-motion.webp';

  /// Design asset height in px (paired with [intrinsicCircleDiameter] for scale).
  static const double intrinsicHeight = 1032;

  /// Diameter in asset px of the centered circular art.
  static const double intrinsicCircleDiameter = 930;

  /// When false, the widget stays at the current angle and the sequence stops.
  final bool animate;

  /// Curve for each 800ms transition between target angles.
  final Curve curve;

  /// Logical width of the region to cover. When non-null, skips the internal [LayoutBuilder].
  ///
  /// Pass [height] as well when this layer is not full-screen; otherwise height defaults to
  /// [MediaQuery.sizeOf] and the scale ratio can be wrong inside padded layouts.
  final double? width;

  /// Logical height for scaling; ignored when [width] is null.
  final double? height;

  /// When true, clips overflow so painting stays within this layer’s bounds.
  final bool clipToViewport;

  const BackgroundColorRotation({
    super.key,
    this.animate = true,
    this.curve = Curves.linear,
    this.width,
    this.height,
    this.clipToViewport = true,
  });

  @override
  Widget build(BuildContext context) {
    if (width != null && width! > 0 && height != null && height! > 0) {
      return SizedBox.expand(child: _buildScaled(Size(width!, height!)));
    }

    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return _buildScaled(_viewportSize(context, constraints));
        },
      ),
    );
  }

  Widget _buildScaled(Size viewport) {
    if (viewport.shortestSide <= 0) {
      return const SizedBox.shrink();
    }

    final double scale = _scaleForViewport(viewport);
    final double side = math.max(viewport.width, viewport.height) * scale;

    final Widget centered = Center(
      child: OverflowBox(
        alignment: Alignment.center,
        minWidth: side,
        maxWidth: side,
        minHeight: side,
        maxHeight: side,
        child: ColorRotation(
          assetPath: assetPath,
          animate: animate,
          width: side,
          fit: BoxFit.cover,
          curve: curve,
        ),
      ),
    );

    if (clipToViewport) {
      return ClipRect(child: centered);
    }
    return centered;
  }

  Size _viewportSize(BuildContext context, BoxConstraints constraints) {
    double w = constraints.maxWidth;
    double h = constraints.maxHeight;
    if (!w.isFinite || !h.isFinite || w <= 0 || h <= 0) {
      final Size mq = MediaQuery.sizeOf(context);
      w = mq.width;
      h = mq.height;
    }
    return Size(w, h);
  }

  static double _scaleForViewport(Size viewport) {
    final double w = viewport.width;
    final double h = viewport.height;
    if (w <= 0 || h <= 0) {
      return 1;
    }
    final double diagonal = math.sqrt(w * w + h * h);

    final double impliedDiameter = math.max(w, h) * intrinsicCircleDiameter / intrinsicHeight;
    return diagonal / impliedDiameter;
  }
}
