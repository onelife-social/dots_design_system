import 'dart:ui' show ImageFilter;

import 'package:dots_design_system/src/core/constants.dart';
import 'package:flutter/material.dart';

import 'color_rotation.dart';

/// Dotbook bubble: stacked background, optional photo, light GIF, frosted layer,
/// color ring animation, and highlight.
class Bubble extends StatelessWidget {
  static const String _backgroundAsset = 'assets/images/dotbook/bubble/bubble-background.webp';
  static const String _lightGifAsset = 'assets/images/dotbook/bubble/light35.gif';
  static const String _highlightAsset = 'assets/images/dotbook/bubble/bubble-bubble-highlight.webp';

  static const double _blurSigma = 3.19;
  static const double _layerPadding = 44;
  static const Duration _networkImageFadeDuration = Duration(milliseconds: 450);

  /// Diameter of the circular bubble.
  final double size;

  /// Optional user image URL; when null or empty, this layer is omitted.
  final String? imageUrl;

  /// Passed to [ColorRotation].
  final bool animateColorRotation;

  /// Passed to [ColorRotation].
  final Curve colorRotationCurve;

  const Bubble({
    super.key,
    required this.size,
    this.imageUrl,
    this.animateColorRotation = true,
    this.colorRotationCurve = Curves.linear,
  });

  @override
  Widget build(BuildContext context) {
    final String? url = imageUrl;
    final bool showNetworkImage = url != null && url.isNotEmpty;

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                _backgroundAsset,
                package: dotsDesignSystemPackage,
                fit: BoxFit.cover,
              ),
            ),
            if (showNetworkImage)
              _InsetLayer(
                padding: _layerPadding,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  frameBuilder: (
                    BuildContext context,
                    Widget child,
                    int? frame,
                    bool wasSynchronouslyLoaded,
                  ) {
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: _networkImageFadeDuration,
                      curve: Curves.easeOut,
                      child: child,
                    );
                  },
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
              ),
            _InsetLayer(
              padding: _layerPadding,
              child: Image.asset(
                _lightGifAsset,
                package: dotsDesignSystemPackage,
                fit: BoxFit.cover,
              ),
            ),
            _InsetLayer(
              padding: _layerPadding,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
                child: const ColoredBox(
                  color: Color.fromRGBO(255, 255, 255, 0.2),
                ),
              ),
            ),
            _InsetLayer(
              padding: _layerPadding,
              child: ColorRotation(
                animate: animateColorRotation,
                width: size - 2 * _layerPadding,
                fit: BoxFit.cover,
                curve: colorRotationCurve,
              ),
            ),
            _InsetLayer(
              padding: _layerPadding,
              child: Image.asset(
                _highlightAsset,
                package: dotsDesignSystemPackage,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InsetLayer extends StatelessWidget {
  const _InsetLayer({
    required this.padding,
    required this.child,
  });

  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: padding,
      top: padding,
      right: padding,
      bottom: padding,
      child: ClipOval(
        child: child,
      ),
    );
  }
}
