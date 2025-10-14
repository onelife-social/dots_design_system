
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../utils/utils.dart';

class DotsProfilePhotoBited extends StatelessWidget {
  /// [imageProvider] is the image to display.
  final ImageProvider imageProvider;

  /// [onTap] is the callback when the profile photo is tapped.
  final Function()? onTap;

  /// [width] and [height] are the dimensions of the profile photo.
  final double width;
  final double height;

  /// [onError] is the callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// [reaction] is the emoji or text to display as a reaction.
  /// If null, no reaction will be displayed.
  final String? reaction;

  /// Size of the bite as a fraction of the width/height.
  final double biteSize;

  /// Offset of the bite from the bottom right corner.
  final Offset biteOffset;

  /// [emojiStyle] is the style for the reaction text.
  /// If null, it will use the default style from the theme.
  final TextStyle? emojiStyle;

  const DotsProfilePhotoBited({
    super.key,
    required this.imageProvider,
    this.onTap,
    this.width = 44,
    this.height = 44,
    this.onError,
    this.biteSize = 0.25,
    this.biteOffset = const Offset(0.85, 0.85),
    this.reaction,
    this.emojiStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double w = constraints.maxWidth.isFinite ? constraints.maxWidth : width;
            final double h = constraints.maxHeight.isFinite ? constraints.maxHeight : height;

            final double diameter = math.min(w, h);
            final double circleLeft = (w - diameter) / 2;
            final double circleTop = (h - diameter) / 2;

            return Stack(
              children: [
                ClipPath(
                  clipper: _BiteCircleClipper(
                    biteSize: biteSize,
                    biteOffset: biteOffset,
                  ),
                  child: SizedBox(
                    width: w,
                    height: h,
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        onError?.call(error, stackTrace);
                        return Container(color: Colors.grey, width: w, height: h);
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: circleLeft + diameter * biteOffset.dx - diameter * biteSize + (DotsPlatform.isIOS ? 1.5 : -0.5),
                  top: circleTop + diameter * biteOffset.dy - diameter * biteSize - (DotsPlatform.isIOS ? 1.5 : 0.5),
                  width: diameter * biteSize * 2,
                  height: diameter * biteSize * 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      reaction ?? '',
                      style: emojiStyle ?? theme.typo.main.labelDefaultBold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BiteCircleClipper extends CustomClipper<Path> {
  final double biteSize;
  final Offset biteOffset;

  _BiteCircleClipper({
    required this.biteSize,
    required this.biteOffset,
  }) : assert(biteSize > 0 && biteSize < 0.5);

  @override
  Path getClip(Size size) {
    final double diameter = math.min(size.width, size.height);
    final double circleLeft = (size.width - diameter) / 2;
    final double circleTop = (size.height - diameter) / 2;

    final Rect circleRect = Rect.fromLTWH(circleLeft, circleTop, diameter, diameter);
    final Path base = Path()..addOval(circleRect);

    final double biteRadius = diameter * biteSize;
    final Offset biteCenter = Offset(
      circleLeft + diameter * biteOffset.dx,
      circleTop + diameter * biteOffset.dy,
    );
    final Path bitePath = Path()..addOval(Rect.fromCircle(center: biteCenter, radius: biteRadius));

    return Path.combine(PathOperation.difference, base, bitePath);
  }

  @override
  bool shouldReclip(covariant _BiteCircleClipper oldClipper) =>
      oldClipper.biteSize != biteSize || oldClipper.biteOffset != biteOffset;
}
