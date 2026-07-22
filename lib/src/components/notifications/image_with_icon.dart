import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class ImageWithIcon extends StatelessWidget {
  const ImageWithIcon({
    super.key,
    this.image,
    this.onError,
    this.icon,
    this.iconSize = 18,
    this.iconOffset,
    this.width = 53,
    this.height = 68,
    this.borderRadius = 12.0,
    this.elevation = 4.0,
    this.borderWidth = 2.0,
    this.circularImage = false,
    this.showIcon = true,
    this.aliasLabelImageText,
    this.aliasLabelImageTextStyle,
  });

  /// Image provider for the main image to display
  final ImageProvider? image;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final ImageErrorListener? onError;

  /// Icon widget to display in the top-right corner
  final Widget? icon;

  /// Size of the icon in pixels
  final double iconSize;

  /// Custom offset for the icon position. If null, uses default positioning
  final double? iconOffset;

  /// Width of the widget in pixels
  final double width;

  /// Height of the widget in pixels
  final double height;

  /// Border radius for the card corners in pixels
  final double borderRadius;

  /// Elevation of the card for shadow effect
  final double elevation;

  /// Width of the border around the image in pixels
  final double borderWidth;

  /// Whether to make the image circular instead of rounded rectangle
  final bool circularImage;

  /// Whether to show the icon in the top-right corner
  final bool showIcon;

  /// Text to display as an alias label when no image is provided
  final String? aliasLabelImageText;

  /// Style for the alias label image text
  final TextStyle? aliasLabelImageTextStyle;

  Image get defaultImage => Image.asset(
    ImagesPaths.defaultUserItem,
    width: width,
    height: height,
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final imageBorderRadius = BorderRadius.all(
      Radius.circular(circularImage ? width / 2 : borderRadius),
    );

    final iconBorderWidth = iconSize * 0.1;
    final iconContainerSize = (iconSize * 1.5);
    final iconRadius = (iconContainerSize + iconBorderWidth) / 2;
    final iconPosition = -(iconOffset ?? iconRadius) + iconBorderWidth;

    final hasImage = image != null;
    final hasAliasText = aliasLabelImageText != null && aliasLabelImageText!.isNotEmpty;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        if (hasImage)
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: imageBorderRadius,
            ),
            child: Stack(
              children: [
                Image(
                  image: image!,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return defaultImage;
                  },
                  errorBuilder: (context, error, stackTrace) {
                    if (onError != null) onError!(error, stackTrace);
                    return defaultImage;
                  },
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
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        else if (hasAliasText)
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: circularImage ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: circularImage ? null : imageBorderRadius,
              color: theme.colors.bgSecondaryBtn,
            ),
            child: Center(
              child: Text(
                aliasLabelImageText!,
                textAlign: TextAlign.center,
                style:
                    aliasLabelImageTextStyle ??
                    TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: theme.colors.textTertiary,
                    ),
              ),
            ),
          ),
        if (showIcon && icon != null)
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
