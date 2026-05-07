import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsImageThumbnailVariant {
  image,
  icon;

  bool get isImage => this == DotsImageThumbnailVariant.image;
  bool get isIcon => this == DotsImageThumbnailVariant.icon;
}

class DotsImageThumbnail extends StatelessWidget {
  /// The variant of the image thumbnail.
  final DotsImageThumbnailVariant variant;

  /// The profile image to be displayed in the image thumbnail.
  final ImageProvider? image;

  /// Size of the container.
  final double size;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// The icon data to be displayed if the variant is icon.
  final DotsIconData iconData;

  /// Size of the icon if the variant is icon by default is 20.
  final double iconSize;

  /// Color of the icon if the variant is icon.
  final Color? iconColor;

  /// Whether to show the semi-transparent black container overlaying the image.
  final bool coverImage;

  const DotsImageThumbnail({
    super.key,
    required this.variant,
    this.image,
    this.size = 40,
    this.onError,
    this.iconData = DotsIconData.user,
    this.iconSize = 20,
    this.iconColor,
    this.coverImage = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: variant.isIcon
            ? theme.colors.bgContainerSecondaryOnBackground
            : theme.colors.transparent,
        borderRadius: DotsBorderRadius.r12,
        image: (image != null && !variant.isIcon)
            ? DecorationImage(
                image: image!,
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  onError?.call(exception, stackTrace);
                },
              )
            : null,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: coverImage ? Colors.black.dotsWithOpacity(0.3) : Colors.transparent,
          borderRadius: DotsBorderRadius.r12,
        ),
        child: Center(
          child: variant.isIcon
              ? DotsIcon(
                  iconData: iconData,
                  color: iconColor,
                  size: iconSize,
                )
              : null,
        ),
      ),
    );
  }
}
