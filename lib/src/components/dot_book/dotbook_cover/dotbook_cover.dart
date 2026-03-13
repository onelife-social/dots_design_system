import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotBookCover extends StatelessWidget {
  /// Variant of the cover to determine layout and content arrangement.
  final DotBookCoverType variant;

  /// Width of the entire cover container, used to scale content size.
  final double containerWidth;

  /// Factor to scale the width of the cover image relative to the container width.
  final double widthFactor;

  /// Main base cover image.
  final ImageProvider mainImage;

  /// Title text color as hexadecimal Color.
  final Color titleTextColor;

  /// Subtitle text color as hexadecimal Color.
  final Color subtitleTextColor;

  /// Image rendered above the base cover.
  final ImageProvider? overlayImage;

  /// Tap callback for all overlay variants.
  final Function()? onOverlayTap;

  /// Default image to show when no overlay image is provided.
  final ImageProvider? defaultOverlayImage;

  /// If true, shows the editing dashed border above the text editor.
  final bool isEditingMode;

  /// If true, shows % over imageOverlay.
  final bool isCreateMode;

  /// Progress value to show when in create mode (0-100).
  final String createprogress;

  /// Optional color for the editing dashed border.
  final Color? editingBorderColor;

  /// Tap callback for the editing dashed border.
  final VoidCallback? onEditingBorderTap;

  /// Text shown at the bottom of the cover.
  final String dotsTitle;

  /// Main text for DotBookTextEditor.
  final String editorTitle;

  /// Secondary text for DotBookTextEditor.
  final String? editorSubtitle;

  const DotBookCover({
    super.key,
    required this.variant,
    required this.containerWidth,
    this.widthFactor = 0.85,
    required this.mainImage,
    this.titleTextColor = const Color(0xFF3C3C3B),
    this.subtitleTextColor = const Color(0xFF3C3C3B),
    this.overlayImage,
    this.defaultOverlayImage,
    this.onOverlayTap,
    this.isEditingMode = false,
    this.isCreateMode = false,
    this.createprogress = '',
    this.editingBorderColor,
    this.onEditingBorderTap,
    this.dotsTitle = 'Dots. Memories',
    this.editorTitle = '',
    this.editorSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    final double width = containerWidth * widthFactor;
    final double imageHeight = width * (5 / 4);

    return Center(
      child: SizedBox(
        width: width,
        height: imageHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: mainImage,
              width: width,
              height: imageHeight,
              fit: BoxFit.cover,
            ),
            DotBookCoverOverlay(
              variant: variant,
              titleTextColor: titleTextColor,
              subtitleTextColor: subtitleTextColor,
              coverImageWidth: width,
              coverImageHeight: imageHeight,
              overlayImage: overlayImage,
              defaultOverlayImage: defaultOverlayImage,
              onTap: onOverlayTap,
              isEditingMode: isEditingMode,
              isCreateMode: isCreateMode,
              createprogress: createprogress,
              editingBorderColor: editingBorderColor,
              onEditingBorderTap: onEditingBorderTap,
              dotsTitle: dotsTitle,
              editorTitle: editorTitle,
              editorSubtitle: editorSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
