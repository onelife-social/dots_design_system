
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotBookCoverOverlay extends StatelessWidget {

  /// Variant of the cover to determine the overlay's position and size.
  final DotBookCoverType variant;

  /// Width of the cover image, used to calculate overlay dimensions.
  final double imageWidth;

  /// Height of the cover image, used to calculate overlay dimensions.
  final double imageHeight;

  /// Image rendered above the base cover.
  final ImageProvider? overlayImage;

  /// Default image to show when no overlay image is provided.
  final ImageProvider? defaultImage;

  /// Tap callback for the overlay.
  final VoidCallback? onTap;

  /// Text shown according to variant positioning rules.
  final String bottomText;

  const DotBookCoverOverlay({
    super.key,
    required this.variant,
    required this.imageWidth,
    required this.imageHeight,
    this.overlayImage,
    this.defaultImage,
    this.onTap,
    this.bottomText = '',
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final _DotBookCoverOverlayImage overlay = _DotBookCoverOverlayImage(
      image: overlayImage,
      defaultImage: defaultImage ?? AssetImage(ImagesPaths.defaultSectionPlanning),
      onTap: onTap,
      icon: DotsIconData.add,
    );

    switch (variant) {
      case DotBookCoverType.linen:
        return Center(
          child: SizedBox(
            width: imageWidth,
            height: imageHeight * 0.395,
            child: Stack(
              fit: StackFit.expand,
              children: [
                overlay,
                IgnorePointer(
                  child: Container(
                    color: Colors.black.dotsWithOpacity(0.2),
                  ),
                ),
                if (bottomText.isNotEmpty)
                  Positioned(
                    left: 8,
                    right: 8,
                    bottom: 13,
                    child: IgnorePointer(
                      child: Text(
                        bottomText,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.dotsTheme.typo.main.bodyLargeMedium.copyWith(
                          color: theme.colors.labelAlwaysWhite,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      case DotBookCoverType.printedSquare:
        return Positioned(
          left: imageWidth * 0.04,
          right: imageWidth * 0.04,
          bottom: imageHeight * 0.04,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double overlayWidth = constraints.maxWidth;
              final double overlayHeight = overlayWidth * (36 / 37);
              return SizedBox(
                height: overlayHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    overlay,
                    IgnorePointer(
                      child: Container(
                        color: Colors.black.dotsWithOpacity(0.2),
                      ),
                    ),
                    if (bottomText.isNotEmpty)
                      Positioned(
                        left: 8,
                        right: 8,
                        bottom: overlayHeight * 0.04,
                        child: IgnorePointer(
                          child: Text(
                            bottomText,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.dotsTheme.typo.main.bodyLargeMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      case DotBookCoverType.printedCircle:
        return Center(
          child: SizedBox.square(
            dimension: imageWidth * 0.517,
            child: ClipOval(child: overlay),
          ),
        );
    }
  }
}

class _DotBookCoverOverlayImage extends StatelessWidget {
  final ImageProvider? image;
  final ImageProvider defaultImage;
  final VoidCallback? onTap;
  final DotsIconData icon;

  const _DotBookCoverOverlayImage({
    this.image,
    required this.defaultImage,
    this.onTap,
    this.icon = DotsIconData.add,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final bool showDefault = image == null;
    final ImageProvider effectiveImage = image ?? defaultImage;
    final Widget currentImage = Image(
      image: effectiveImage,
      fit: BoxFit.cover,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (!showDefault)
              currentImage
            else ...[
              currentImage,
              Container(
                color: Colors.black.dotsWithOpacity(0.05),
              ),
              Center(
                child: DotsIcon(
                  iconData: icon,
                  color: theme.colors.labelAlwaysWhite,
                  size: 32,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
