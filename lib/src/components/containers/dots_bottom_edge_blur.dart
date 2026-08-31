import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Progressive bottom-edge blur over [child]: a blurred copy of the content
/// is painted on top, faded in with a vertical gradient over the bottom
/// [edgeSize].
///
/// Replaces the previous stacked-[BackdropFilter] approach: backdrop filters
/// sample the backdrop in screen space, which shimmers while scrolling on
/// Impeller, escapes ancestor smooth-corner clips, and the discrete bands
/// produced visible steps in the blur ramp. Blurring a copy of the child with
/// [ImageFiltered] keeps everything in the widget's own layer, so it clips
/// and scrolls like any other content.
class DotsBottomEdgeBlur extends StatelessWidget {
  const DotsBottomEdgeBlur({
    super.key,
    required this.child,
    required this.edgeSize,
    this.sigma = 12,
    this.blurChild,
  })  : assert(edgeSize >= 0, 'edgeSize must be >= 0'),
        assert(sigma >= 0, 'sigma must be >= 0');

  /// Content the blur band is painted over.
  ///
  /// It is instantiated twice (once sharp, once blurred), so it must render
  /// the same pixels in both places: images, gradients and other visually
  /// stateless widgets are fine, but interactive content (e.g. a carousel)
  /// would desynchronise from its blurred copy — pass [blurChild] instead.
  final Widget child;

  /// Widget to blur instead of [child] when [child] cannot be safely
  /// duplicated (holds state, uses GlobalKeys, responds to input).
  final Widget? blurChild;

  /// Height of the blurred bottom band.
  final double edgeSize;

  /// Blur strength at the very bottom of the band.
  final double sigma;

  /// Smoothstep-shaped fade of the blurred copy, top → bottom of the band.
  static const List<double> _fadeOpacities = [0.0, 0.11, 0.35, 0.65, 0.89, 1.0];

  @override
  Widget build(BuildContext context) {
    if (edgeSize <= 0 || sigma <= 0) return child;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            // The mask leaves everything above the band fully transparent, so
            // clipping to the band lets the engine restrict the blur filter's
            // coverage instead of filtering the whole child offscreen.
            child: ClipRect(
              clipper: _BottomBandClipper(edgeSize),
              child: ShaderMask(
                shaderCallback: (bounds) {
                  final bandStart = bounds.height <= edgeSize
                      ? 0.0
                      : 1 - edgeSize / bounds.height;
                  final step = (1 - bandStart) / (_fadeOpacities.length - 1);
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      for (final opacity in _fadeOpacities)
                        Colors.white.withValues(alpha: opacity),
                    ],
                    stops: [
                      for (var i = 0; i < _fadeOpacities.length; i++)
                        bandStart + step * i,
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(
                    sigmaX: sigma,
                    sigmaY: sigma,
                    tileMode: ui.TileMode.clamp,
                  ),
                  child: blurChild ?? child,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomBandClipper extends CustomClipper<Rect> {
  const _BottomBandClipper(this.bandHeight);

  final double bandHeight;

  @override
  Rect getClip(Size size) => Rect.fromLTRB(
        0,
        math.max(0, size.height - bandHeight),
        size.width,
        size.height,
      );

  @override
  bool shouldReclip(_BottomBandClipper oldClipper) =>
      oldClipper.bandHeight != bandHeight;
}
