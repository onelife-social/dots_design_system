import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

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
        child: Stack(
          children: [
            ClipPath(
              clipper: _BiteCircleClipper(
                biteSize: biteSize,
                biteOffset: biteOffset,
              ),
              child: Image(
                image: imageProvider,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  onError?.call(error, stackTrace);
                  return Container(color: Colors.grey, width: width, height: height);
                },
              ),
            ),
            Positioned(
              left: width * biteOffset.dx - width * biteSize,
              top: height * biteOffset.dy - height * biteSize,
              width: width * biteSize * 2,
              height: height * biteSize * 2,
              child: Center(
                child: Text(
                  reaction ?? '',
                  style: emojiStyle ?? theme.typo.main.labelDefaultBold,
                ),
              ),
            ),
          ],
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
  });

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addOval(Rect.fromLTWH(0, 0, size.width, size.height));

    final biteRadius = size.width * biteSize;
    final biteCenter = Offset(
      size.width * biteOffset.dx,
      size.height * biteOffset.dy,
    );
    path.addOval(Rect.fromCircle(center: biteCenter, radius: biteRadius));

    return Path.combine(PathOperation.difference,
        Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addOval(Rect.fromCircle(center: biteCenter, radius: biteRadius)));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}