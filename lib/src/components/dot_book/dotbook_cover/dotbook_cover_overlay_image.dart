
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotBookCoverOverlay extends StatelessWidget {

  /// Variant of the cover to determine the overlay's position and size.
  final DotBookCoverType variant;

  /// Text color used for overlay elements.
  final Color textColor;

  /// Width of the cover image, used to calculate overlay dimensions.
  final double imageWidth;

  /// Height of the cover image, used to calculate overlay dimensions.
  final double imageHeight;

  /// Image rendered above the base cover.
  final ImageProvider? overlayImage;

  /// Default image to show when no overlay image is provided.
  final ImageProvider? defaultOverlayImage;

  /// Tap callback for the overlay.
  final VoidCallback? onTap;

  /// Shows editing border above the text editor when true.
  final bool isEditingMode;

  /// Tap callback for the editing border.
  final VoidCallback? onEditingBorderTap;

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
    required this.imageWidth,
    required this.imageHeight,
    this.overlayImage,
    this.defaultOverlayImage,
    this.onTap,
    this.isEditingMode = false,
    this.onEditingBorderTap,
    required this.dotsTitle,
    required this.editorTitle,
    this.editorSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    final _DotBookCoverOverlayImage overlay = _DotBookCoverOverlayImage(
      image: overlayImage,
      defaultOverlayImage: defaultOverlayImage ?? AssetImage(ImagesPaths.defaultSectionPlanning),
      onTap: onTap,
      icon: DotsIconData.add,
    );

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        _DotBookCoverOverlayLayer(
          variant: variant,
          imageWidth: imageWidth,
          imageHeight: imageHeight,
          overlay: overlay,
        ),
        _DotBookCoverEditorLayer(
          variant: variant,
          textColor: textColor,
          imageWidth: imageWidth,
          imageHeight: imageHeight,
          isEditingMode: isEditingMode,
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
            imageHeight: imageHeight,
            dotsTitle: dotsTitle,
          ),
      ],
    );
  }
}

class _DotBookCoverOverlayLayer extends StatelessWidget {
  final DotBookCoverType variant;
  final double imageWidth;
  final double imageHeight;
  final Widget overlay;

  const _DotBookCoverOverlayLayer({
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

class _DotBookCoverEditorLayer extends StatelessWidget {
  final DotBookCoverType variant;
  final Color textColor;
  final double imageWidth;
  final double imageHeight;
  final bool isEditingMode;
  final VoidCallback? onTap;
  final VoidCallback? onEditingBorderTap;
  final String editorTitle;
  final String? editorSubtitle;
  final String dotsTitle;


  const _DotBookCoverEditorLayer({
    required this.variant,
    required this.textColor,
    required this.imageWidth,
    required this.imageHeight,
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
        final double editorWidth = imageWidth * 0.67;
        return Positioned(
          top: imageHeight * 0.075,
          left: (imageWidth - editorWidth) / 2,
          width: editorWidth,
          child: _DotBookEditorWithEditingBorder(
            isEditingMode: isEditingMode,
            borderColor: context.dotsTheme.colors.labelSecondary,
            onBorderTap: onEditingBorderTap ?? onTap,
            child: DotBookTextEditor(
              variant: variant,
              coverVariant: variant,
              textColor: textColor,
              title: editorTitle,
              subtitle: editorSubtitle,
            ),
          ),
        );

      case DotBookCoverType.printedSquare:
        final double horizontalInset = imageWidth * 0.04;
        final double overlayWidth = imageWidth - (horizontalInset * 2);
        final double overlayHeight = overlayWidth * (36 / 37);
        final double overlayTop = imageHeight - (imageHeight * 0.04) - overlayHeight;
        final double editorTop = imageHeight * 0.04;
        final double editorHeight = (overlayTop - editorTop).clamp(0.0, imageHeight);

        return Positioned(
          top: editorTop,
          left: horizontalInset,
          right: horizontalInset,
          height: editorHeight,
          child: _DotBookEditorWithEditingBorder(
            isEditingMode: isEditingMode,
            borderColor: context.dotsTheme.colors.labelSecondary,
            onBorderTap: onEditingBorderTap ?? onTap,
            child: DotBookTextEditor(
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
        final double overlayHeight = imageHeight * 0.395;
        final double overlayTop = (imageHeight - overlayHeight) / 2;
        final double editorWidth = imageWidth * 0.6;

        return Positioned(
          top: overlayTop + (overlayHeight * 0.05),
          left: (imageWidth - editorWidth) / 2,
          width: editorWidth,
          child: _DotBookEditorWithEditingBorder(
            isEditingMode: isEditingMode,
            borderColor: context.dotsTheme.colors.labelSecondary,
            onBorderTap: onEditingBorderTap ?? onTap,
            child: DotBookTextEditor(
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
  final Widget child;
  final bool isEditingMode;
  final Color borderColor;
  final VoidCallback? onBorderTap;

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
  final DotBookCoverType variant;
  final Color textColor;
  final double imageHeight;
  final String dotsTitle;

  const _DotBookCoverBottomTitleLayer({
    required this.variant,
    required this.textColor,
    required this.imageHeight,
    required this.dotsTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    switch (variant) {
      case DotBookCoverType.linen:
        final double overlayHeight = imageHeight * 0.395;
        return Positioned(
          left: 8,
          right: 8,
          bottom: overlayHeight * 0.04,
          child: IgnorePointer(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: overlayHeight * 0.04),
                child: Text(
                  dotsTitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: context.dotsTheme.typo.main.bodyLargeMedium.copyWith(
                    color: theme.colors.labelAlwaysWhite,
                  ),
                ),
              ),
            ),
          ),
        );

      case DotBookCoverType.printedCircle:
        return Positioned(
          left: 8,
          right: 8,
          bottom: imageHeight * 0.04,
          child: IgnorePointer(
            child: Text(
              dotsTitle,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: context.dotsTheme.typo.main.bodyLargeMedium.copyWith(
                color: theme.colors.labelAlwaysWhite,
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
  final ImageProvider? image;
  final ImageProvider defaultOverlayImage;
  final VoidCallback? onTap;
  final DotsIconData icon;

  const _DotBookCoverOverlayImage({
    this.image,
    required this.defaultOverlayImage,
    this.onTap,
    this.icon = DotsIconData.add,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final bool showDefault = image == null;
    final ImageProvider effectiveImage = image ?? defaultOverlayImage;
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
