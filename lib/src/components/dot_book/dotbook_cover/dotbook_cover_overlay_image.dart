
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class DotBookCoverOverlay extends StatelessWidget {

  /// Variant of the cover to determine the overlay's position and size.
  final DotBookCoverType variant;

  /// Text color used for overlay elements.
  final Color textColor;

  /// Width of the cover image, used to calculate overlay dimensions.
  final double coverImageWidth;

  /// Height of the cover image, used to calculate overlay dimensions.
  final double coverImageHeight;

  /// Image rendered above the base cover.
  final ImageProvider? overlayImage;

  /// Default image to show when no overlay image is provided.
  final ImageProvider? defaultOverlayImage;

  /// Tap callback for the overlay.
  final Function()? onTap;

  /// Shows editing border above the text editor when true.
  final bool isEditingMode;

  /// Optional color for the editing dashed border.
  final Color? editingBorderColor;

  /// Tap callback for the editing border.
  final Function()? onEditingBorderTap;

  /// Text shown with the company branding.
  final String dotsTitle;

  /// Main text for DotBookTextEditor.
  final String editorTitle;

  /// Secondary text for DotBookTextEditor.
  final String? editorSubtitle;

  const DotBookCoverOverlay({
    super.key,
    required this.variant,
    required this.textColor,
    required this.coverImageWidth,
    required this.coverImageHeight,
    this.overlayImage,
    this.defaultOverlayImage,
    this.onTap,
    this.isEditingMode = false,
    this.onEditingBorderTap,
    this.editingBorderColor,
    required this.dotsTitle,
    required this.editorTitle,
    this.editorSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    final _DotBookCoverOverlayImage overlay = _DotBookCoverOverlayImage(
      image: overlayImage,
      defaultImage: defaultOverlayImage ?? AssetImage(ImagesPaths.defaultSectionPlanning),
      overlayOnTap: onTap,
      isEditingMode: isEditingMode,
      icon: DotsIconData.add,
    );

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        _DotBookCoverOverlayImageLayer(
          variant: variant,
          imageWidth: coverImageWidth,
          imageHeight: coverImageHeight,
          overlay: overlay,
        ),
        _DotBookCoverTextEditorLayer(
          variant: variant,
          textColor: textColor,
          coverImageWidth: coverImageWidth,
          coverImageHeight: coverImageHeight,
          isEditingMode: isEditingMode,
          editingBorderColor: editingBorderColor,
          onTap: onTap,
          onEditingBorderTap: onEditingBorderTap,
          editorTitle: editorTitle,
          editorSubtitle: editorSubtitle,
          dotsTitle: dotsTitle,
        ),
        if (dotsTitle.isNotEmpty)
          _DotBookCoverBottomTitleLayer(
            variant: variant,
            textColor: textColor,
            coverImageWidth: coverImageWidth,
            coverImageHeight: coverImageHeight,
            dotsTitle: dotsTitle,
          ),
      ],
    );
  }
}

class _DotBookCoverOverlayImageLayer extends StatelessWidget {

  /// Variant of the cover to determine the overlay's position and size.
  final DotBookCoverType variant;

  /// Width & height of the cover image, used to calculate overlay dimensions.
  final double imageWidth;
  final double imageHeight;

  /// Widget to display as the overlay image.
  final Widget overlay;

  const _DotBookCoverOverlayImageLayer({
    required this.variant,
    required this.imageWidth,
    required this.imageHeight,
    required this.overlay,
  });

  @override
  Widget build(BuildContext context) {
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
              ],
            ),
          ),
        );
      case DotBookCoverType.printedSquare:
        return Positioned(
          left: imageWidth * 0.0373,
          right: imageWidth * 0.0373,
          bottom: imageHeight * 0.0347,
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

class _DotBookCoverTextEditorLayer extends StatelessWidget {

  /// Variant of the cover to determine the editor's position and size.
  final DotBookCoverType variant;

  /// Text color used for the editor text.
  final Color textColor;

  /// Optional color for the editing border.
  final Color? editingBorderColor;

  /// Width & height of the cover image.
  final double coverImageWidth;
  final double coverImageHeight;

  /// Shows editing border above the text editor when true.
  final bool isEditingMode;

  /// Callback when the editor is tapped.
  final Function()? onTap;

  /// Callback when the editing border is tapped.
  final Function()? onEditingBorderTap;

  final String editorTitle;
  final String? editorSubtitle;
  final String dotsTitle;


  const _DotBookCoverTextEditorLayer({
    required this.variant,
    required this.textColor,
    this.editingBorderColor,
    required this.coverImageWidth,
    required this.coverImageHeight,
    required this.isEditingMode,
    required this.onTap,
    required this.onEditingBorderTap,
    required this.editorTitle,
    required this.editorSubtitle,
    required this.dotsTitle,
  });

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case DotBookCoverType.printedCircle:
        final double editorWidth = coverImageWidth * 0.4806;
        return Positioned(
          top: coverImageHeight * 0.0867,
          left: (coverImageWidth - editorWidth) / 2,
          width: editorWidth,
          child: _DotBookEditorWithEditingBorder(
            isEditingMode: isEditingMode,
            borderColor: editingBorderColor ?? const Color(0x33000000),
            onBorderTap: onEditingBorderTap,
            child: DotBookTextEditor(
              coverImageWidth: coverImageWidth,
              coverImageHeight: coverImageHeight,
              variant: variant,
              coverVariant: variant,
              textColor: textColor,
              title: editorTitle,
              subtitle: editorSubtitle,
            ),
          ),
        );

      case DotBookCoverType.printedSquare:
        final double horizontalInset = coverImageWidth * 0.0373;
        final double overlayWidth = coverImageWidth - (horizontalInset * 2);
        final double overlayHeight = overlayWidth * (36 / 37);
        final double overlayTop = coverImageHeight - (coverImageHeight * 0.0347) - overlayHeight;
        final double editorTop = coverImageHeight * 0.0347;
        final double editorBottomPadding = coverImageHeight * 0.0145;
        final double editorHeight = (overlayTop - editorTop - editorBottomPadding).clamp(0.0, coverImageHeight);

        return Positioned(
          top: editorTop,
          left: horizontalInset,
          right: horizontalInset,
          height: editorHeight,
          child: _DotBookEditorWithEditingBorder(
            isEditingMode: isEditingMode,
            borderColor: editingBorderColor ?? const Color(0x33000000),
            onBorderTap: onEditingBorderTap,
            child: DotBookTextEditor(
              coverImageWidth: coverImageWidth,
              coverImageHeight: coverImageHeight,
              variant: variant,
              height: editorHeight,
              coverVariant: variant,
              textColor: textColor,
              title: editorTitle,
              subtitle: editorSubtitle,
              xtraInfo: dotsTitle,
            ),
          ),
        );

      case DotBookCoverType.linen:
        final double overlayHeight = coverImageHeight * 0.395;
        final double overlayTop = (coverImageHeight - overlayHeight) / 2;
        final double editorWidth = coverImageWidth * 0.4806;
        return Positioned(
          top: overlayTop + (coverImageHeight * 0.0353),
          left: (coverImageWidth - editorWidth) / 2,
          width: editorWidth,
          child: _DotBookEditorWithEditingBorder(
            isEditingMode: isEditingMode,
            borderColor: editingBorderColor ?? const Color(0x33000000),
            onBorderTap: onEditingBorderTap,
            child: DotBookTextEditor(
              coverImageWidth: coverImageWidth,
              coverImageHeight: coverImageHeight,
              width: editorWidth,
              variant: variant,
              coverVariant: variant,
              textColor: textColor,
              title: editorTitle,
              subtitle: editorSubtitle,
            ),
          ),
        );
    }
  }
}

class _DotBookEditorWithEditingBorder extends StatelessWidget {

  /// Child widget to be wrapped with the editing border.
  final Widget child;

  /// Indicates whether the editor is in editing mode.
  final bool isEditingMode;

  /// Color of the editing border.
  final Color borderColor;

  /// Callback triggered when the border container is tapped.
  final Function()? onBorderTap;

  const _DotBookEditorWithEditingBorder({
    required this.child,
    required this.isEditingMode,
    required this.borderColor,
    required this.onBorderTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!isEditingMode) {
      return child;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -4,
          left: -4,
          right: -4,
          bottom: -4,
          child: DotBookTextEditorBorder(
            color: borderColor,
            onTap: onBorderTap,
          ),
        ),
      ],
    );
  }
}

class _DotBookCoverBottomTitleLayer extends StatelessWidget {

  /// Variant of the cover to determine the title's position and size.
  final DotBookCoverType variant;

  /// Text color used for the title text.
  final Color textColor;

  /// Width & height of the cover image.
  final double coverImageWidth;
  final double coverImageHeight;

  /// Text shown with the company branding.
  final String dotsTitle;

  const _DotBookCoverBottomTitleLayer({
    required this.variant,
    required this.textColor,
    required this.coverImageWidth,
    required this.coverImageHeight,
    required this.dotsTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    switch (variant) {
      case DotBookCoverType.linen:
        final double overlayHeight = coverImageHeight * 0.395;
        final double overlayTop = (coverImageHeight - overlayHeight) / 2;
        final double bottomInset = coverImageHeight * 0.0345;
        return Positioned(
          left: 8,
          right: 8,
          bottom: overlayTop + bottomInset,
          child: IgnorePointer(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                dotsTitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: context.dotsTheme.typo.secondary.title02H2.copyWith(
                  color: theme.colors.labelAlwaysWhite,
                  fontSize: DotsTextUtils.scaledFontSize(
                    referenceFontSize: 6.84,
                    imageWidth: coverImageWidth,
                    referenceWidth: kCoverImageWidth,
                  ),
                  height: null,
                ),
              ),
            ),
          ),
        );

      case DotBookCoverType.printedCircle:
        return Positioned(
          left: 8,
          right: 8,
          bottom: coverImageHeight * 0.0345,
          child: IgnorePointer(
            child: Text(
              dotsTitle,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: context.dotsTheme.typo.secondary.title02H2.copyWith(
                color: textColor,
                fontSize: DotsTextUtils.scaledFontSize(
                  referenceFontSize: 5.8,
                  imageWidth: coverImageWidth,
                  referenceWidth: kCoverImageWidth,
                ),
                height: null,
              ),
            ),
          ),
        );

      case DotBookCoverType.printedSquare:
        return const SizedBox.shrink();
    }
  }
}

class _DotBookCoverOverlayImage extends StatelessWidget {

  /// Image rendered above the base cover.
  final ImageProvider? image;

  /// Default image to show when no overlay image is provided.
  final ImageProvider defaultImage;

  /// Tap callback for the overlay image.
  final Function()? overlayOnTap;

  /// indicates if the cover is in editing mode to determine whether to show the default image with an icon or not.
  final bool isEditingMode;

  /// Icon to display when no overlay image is provided and is not in editing mode.
  final DotsIconData icon;

  const _DotBookCoverOverlayImage({
    this.image,
    required this.defaultImage,
    this.overlayOnTap,
    this.isEditingMode = false,
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
        onTap: overlayOnTap,
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
              if (isEditingMode)
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
