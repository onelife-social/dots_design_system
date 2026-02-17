import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';


class DotBookCover extends StatelessWidget {
  final DotBookCoverType variant;

	/// Color enum that determines which main cover asset path is used.
	final DotBookCoverColor color;

	/// Image rendered above the base cover.
	final ImageProvider? overlayImage;

	/// Tap callback for all overlay variants.
	final Function()? onOverlayTap;

  /// Default image to show when no overlay image is provided.
  final ImageProvider? defaultOverlayImage;

	/// If true, shows the editing dashed border above the text editor.
	final bool isEditingMode;

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
		this.color = DotBookCoverColor.white,
		this.overlayImage,
    this.defaultOverlayImage,
		this.onOverlayTap,
		this.isEditingMode = false,
		this.onEditingBorderTap,
		this.dotsTitle = 'DotBook',
		this.editorTitle = '',
		this.editorSubtitle,
	});

	@override
	Widget build(BuildContext context) {

		final double width = MediaQuery.sizeOf(context).width * 0.85;
		final double imageHeight = width * (5 / 4);

		return Center(
			child: SizedBox(
				width: width,
				height: imageHeight,
				child: Stack(
					fit: StackFit.expand,
					children: [
						Image.asset(
							_mainImagePath,
							width: width,
							height: imageHeight,
							fit: BoxFit.cover,
						),
						DotBookCoverOverlay(
							variant: variant,
							coverColor: color,
							imageWidth: width,
							imageHeight: imageHeight,
							overlayImage: overlayImage,
              defaultOverlayImage: defaultOverlayImage,
							onTap: onOverlayTap,
							isEditingMode: isEditingMode,
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

	String get _mainImagePath {
		switch (variant) {
			case DotBookCoverType.linen:
				switch (color) {
					case DotBookCoverColor.stone:
						return ImagesPaths.dotbookCoverLinenStone;
					case DotBookCoverColor.charcoal:
						return ImagesPaths.dotbookCoverLinenCharcoal;
					case DotBookCoverColor.white:
					case DotBookCoverColor.cloud:
					case DotBookCoverColor.olive:
					case DotBookCoverColor.peach:
					case DotBookCoverColor.sand:
					case DotBookCoverColor.beigeCraft:
						return ImagesPaths.dotbookCoverLinenWhite;
				}
			case DotBookCoverType.printedSquare:
			case DotBookCoverType.printedCircle:
				switch (color) {
					case DotBookCoverColor.cloud:
						return ImagesPaths.dotbookCoverPrintedCloud;
					case DotBookCoverColor.olive:
						return ImagesPaths.dotbookCoverPrintedOlive;
					case DotBookCoverColor.peach:
						return ImagesPaths.dotbookCoverPrintedPeach;
					case DotBookCoverColor.sand:
						return ImagesPaths.dotbookCoverPrintedSand;
					case DotBookCoverColor.beigeCraft:
						return ImagesPaths.dotbookCoverPrintedBeigeCraft;
					case DotBookCoverColor.white:
					case DotBookCoverColor.stone:
					case DotBookCoverColor.charcoal:
						return ImagesPaths.dotbookCoverPrintedWhite;
				}
		}
	}
}
