import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';


class DotBookCover extends StatelessWidget {
  final DotBookCoverType variant;

  /// Main base cover image.
  final ImageProvider mainImage;

	/// Text color as hexadecimal Color.
	final Color textColor;

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
		required this.mainImage,
		this.textColor = const Color(0xFF3C3C3B),
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
						Image(
							image: mainImage,
							width: width,
							height: imageHeight,
							fit: BoxFit.cover,
						),
						DotBookCoverOverlay(
							variant: variant,
							textColor: textColor,
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
}
