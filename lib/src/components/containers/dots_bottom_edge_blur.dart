import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Progressive bottom-edge blur over [child], built from stacked
/// [BackdropFilter] bands.
///
/// Replaces `soft_edge_blur`'s `SoftEdgeBlur`: its per-frame
/// `Picture.toImageSync` capture misrenders on Impeller Android (blank first
/// paint, artifacts while scrolling), and since Flutter 3.44 Android cannot
/// fall back to Skia.
class DotsBottomEdgeBlur extends StatelessWidget {
  const DotsBottomEdgeBlur({
    super.key,
    required this.child,
    required this.edgeSize,
    this.sigma = 12,
  });

  /// Content the blur band is painted over.
  final Widget child;

  /// Height of the blurred bottom band.
  final double edgeSize;

  /// Blur strength at the very bottom of the band.
  final double sigma;

  /// Overlapping bands compose as sqrt of the sum of squared sigmas, so these
  /// factors ramp the effective blur from ~0.17×[sigma] at the top of the band
  /// to [sigma] at the bottom, approximating the soft edge they replace.
  static const List<({double height, double sigma})> _bands = [
    (height: 1.0, sigma: 0.17),
    (height: 0.83, sigma: 0.33),
    (height: 0.66, sigma: 0.5),
    (height: 0.5, sigma: 0.78),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        for (final band in _bands)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: edgeSize * band.height,
            child: IgnorePointer(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: sigma * band.sigma,
                    sigmaY: sigma * band.sigma,
                    tileMode: TileMode.clamp,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
