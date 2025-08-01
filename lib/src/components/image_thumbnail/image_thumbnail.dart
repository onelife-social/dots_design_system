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

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// The icon data to be displayed if the variant is icon.
  final DotsIconData iconData;

  /// Size of the icon if the variant is icon by default is 20.
  final double iconSize;

  /// Color of the icon if the variant is icon.
  final Color? iconColor;

  const DotsImageThumbnail({
    super.key,
    required this.variant,
    this.image,
    this.onError,
    this.iconData = DotsIconData.user,
    this.iconSize = 20,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: variant.isIcon
          ? theme.colors.bgContainerSecondaryOnBackground
          : theme.colors.transparent,
        borderRadius: BorderRadius.circular(12),
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
      child: Center(
        child: variant.isIcon
          ? DotsIcon(
              iconData: iconData,
              color: iconColor,
              size: iconSize,
            )
          : null,
      ),
    );
  }
}