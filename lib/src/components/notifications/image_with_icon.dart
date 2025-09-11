import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class ImageWithIcon extends StatelessWidget {
  const ImageWithIcon({
    super.key,
    this.image,
    this.onError,
    required this.icon,
    this.iconSize = 18,
    this.iconOffset,
    this.width = 53,
    this.height = 68,
    this.borderRadius = 12.0,
    this.elevation = 4.0,
    this.borderWidth = 2.0,
    this.circularImage = false,
  });

  /// Image provider for the main image to display
  final ImageProvider? image;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// Icon widget to display in the top-right corner
  final Widget icon;

  /// Size of the icon
  final double iconSize;

  /// Icon offset
  final double? iconOffset;

  /// Width of the widget
  final double width;

  /// Height of the widget
  final double height;

  /// Border radius for the card
  final double borderRadius;

  /// Elevation of the card
  final double elevation;

  /// Border width
  final double borderWidth;

  /// Whether to make the image circular
  final bool circularImage;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final imageBorderRadius =
        BorderRadius.all(Radius.circular(circularImage ? width / 2 : borderRadius));

    final iconBorderWidth = iconSize * 0.1;
    final iconContainerSize = (iconSize * 1.5);
    final iconRadius = (iconContainerSize + iconBorderWidth) / 2;
    final iconPosition = -(iconOffset ?? iconRadius) + iconBorderWidth;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: imageBorderRadius,
          ),
          child: Stack(
            children: [
              Container(
                width: width,
                height: height,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: imageBorderRadius,
                  image: (image != null)
                      ? DecorationImage(
                          image: image!,
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {
                            onError?.call(exception, stackTrace);
                          },
                        )
                      : null,
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: imageBorderRadius,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.5],
                      colors: [
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: width,
                height: height,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: imageBorderRadius,
                    side: BorderSide(
                        color: Colors.white60,
                        width: borderWidth,
                        strokeAlign: BorderSide.strokeAlignInside),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: iconPosition,
          right: iconPosition,
          child: CircleAvatar(
            radius: iconRadius,
            backgroundColor: theme.colors.bgBase,
            child: Container(
              margin: EdgeInsets.all(iconBorderWidth),
              width: iconContainerSize,
              height: iconContainerSize,
              decoration: BoxDecoration(
                color: theme.colors.bgSecondaryBtn,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: icon,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
