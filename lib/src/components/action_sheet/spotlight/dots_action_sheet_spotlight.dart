import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsActionSheetSpotlightVariant { alert, user, album }

class DotsActionSheetSpotlight extends StatelessWidget {
  /// Main title text displayed prominently in the action sheet
  final String title;

  /// Optional label text displayed below the title
  final String? label;

  /// Optional body title for alert variant, displayed in a bordered container
  final String? bodyTitle;

  /// Optional description text displayed below the title/label
  final String? description;

  /// Image provider for the main image displayed at the top
  final ImageProvider image;

  /// Callback function called when the image fails to load
  final ImageErrorListener? onImageError;

  /// Callback function called when the close button is tapped
  final VoidCallback? onClose;

  /// Primary action button widget displayed at the bottom
  final Widget primaryButton;

  /// Visual variant that determines the layout and styling
  final DotsActionSheetSpotlightVariant variant;

  /// Icon data for the icon displayed on the image
  final DotsIconData iconData;

  /// Width of the image in pixels
  final double imageWidth;

  /// Height of the image in pixels
  final double imageHeight;

  /// Size of the icon in pixels
  final double iconSize;

  /// Offset for positioning the icon on the image
  final double iconOffset;

  const DotsActionSheetSpotlight({
    super.key,
    required this.variant,
    required this.title,
    this.label,
    this.bodyTitle,
    this.description,
    required this.image,
    this.onImageError,
    this.onClose,
    required this.primaryButton,
    this.imageWidth = 96,
    this.imageHeight = 96,
    this.iconData = DotsIconData.heart,
    this.iconSize = 20,
    this.iconOffset = 4,
  });

  @override
  Widget build(BuildContext context) {
    final double bottomPosition = 56;
    final bool showCloseButton = variant != DotsActionSheetSpotlightVariant.user && onClose != null;
    final description = variant == DotsActionSheetSpotlightVariant.alert ? null : this.description;

    final topWidget = ImageWithIcon(
      image: image,
      onError: onImageError,
      icon: DotsIcon(iconData: iconData),
      width: imageWidth,
      height: variant == DotsActionSheetSpotlightVariant.user ? imageWidth : imageHeight,
      iconSize: iconSize,
      iconOffset: iconOffset,
      circularImage: variant == DotsActionSheetSpotlightVariant.user,
    );
    final bottomWidget = variant == DotsActionSheetSpotlightVariant.alert
        ? Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: context.dotsTheme.colors.bgContainerSecondary),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (bodyTitle != null)
                  Text(
                    bodyTitle!,
                    textAlign: TextAlign.center,
                    style: context.dotsTheme.typo.main.bodyLargeBold,
                  ),
                SizedBox(height: bodyTitle != null && this.description != null ? 6 : 0),
                if (this.description != null)
                  Text(
                    this.description!,
                    textAlign: TextAlign.center,
                    style: context.dotsTheme.typo.main.bodyDefaultRegular,
                  ),
              ],
            ),
          )
        : null;

    return DotsActionSheetContainer(
      bottomPosition: bottomPosition,
      horizontalPadding: 16,
      showBlurBackground: true,
      onClose: onClose,
      child: DotsActionSheetSpotlightContent(
        title: title,
        label: label,
        description: description,
        topWidget: topWidget,
        bottomWidget: bottomWidget,
        primaryButton: primaryButton,
        showCloseButton: showCloseButton,
        onClose: onClose,
      ),
    );
  }
}
