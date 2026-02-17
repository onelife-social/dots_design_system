
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotBookCoverOverlay extends StatelessWidget {

  /// Variant of the cover to determine the overlay's position and size.
  final DotBookCoverType variant;

  /// Cover color used to derive text color from theme context.
  final DotBookCoverColor coverColor;

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
    required this.coverColor,
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
        _buildOverlayByVariant(context, overlay),
        if (_hasEditorContent) _buildTextEditorByVariant(context),
        if (dotsTitle.isNotEmpty) _buildBottomTextByVariant(context),
      ],
    );
  }

  bool get _hasEditorContent {
    switch (variant) {
      case DotBookCoverType.printedSquare:
        return editorTitle.isNotEmpty ||
            (editorSubtitle?.isNotEmpty ?? false) ||
            dotsTitle.isNotEmpty;
      case DotBookCoverType.linen:
      case DotBookCoverType.printedCircle:
        return editorTitle.isNotEmpty || (editorSubtitle?.isNotEmpty ?? false);
    }
  }

  Widget _buildOverlayByVariant(BuildContext context, Widget overlay) {
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

  Widget _buildTextEditorByVariant(BuildContext context) {
    switch (variant) {
      case DotBookCoverType.printedCircle:
        final double editorWidth = imageWidth * 0.67;
        return Positioned(
          top: imageHeight * 0.075,
          left: (imageWidth - editorWidth) / 2,
          width: editorWidth,
          child: _editorWithEditingBorder(
            context: context,
            child: DotBookTextEditor(
              variant: variant,
              coverVariant: variant,
              color: coverColor,
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
          child: _editorWithEditingBorder(
            context: context,
            child: DotBookTextEditor(
              variant: variant,
              height: editorHeight,
              coverVariant: variant,
              color: coverColor,
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
          child: _editorWithEditingBorder(
            context: context,
            child: DotBookTextEditor(
              width: editorWidth,
              variant: variant,
              coverVariant: variant,
              color: coverColor,
              title: editorTitle,
              subtitle: editorSubtitle,
            ),
          ),
        );
    }
  }

  Widget _editorWithEditingBorder({
    required BuildContext context,
    required Widget child,
  }) {
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
            color: context.dotsTheme.colors.labelSecondary,
            onTap: onEditingBorderTap ?? onTap,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomTextByVariant(BuildContext context) {
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
                color: coverColor.textColor(context, variant),
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
