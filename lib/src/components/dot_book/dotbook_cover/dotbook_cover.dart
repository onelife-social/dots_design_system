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

	/// Text shown according to variant positioning rules.
	final String bottomText;


	const DotBookCover({
		super.key,
    required this.variant,
		this.color = DotBookCoverColor.white,
		this.overlayImage,
		this.onOverlayTap,
		this.bottomText = '',
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
						if (variant == DotBookCoverType.printedCircle && bottomText.isNotEmpty)
							Positioned(
								left: 8,
								right: 8,
								bottom: 13,
								child: Text(
									bottomText,
									textAlign: TextAlign.center,
									maxLines: 1,
									overflow: TextOverflow.ellipsis,
									style: context.dotsTheme.typo.main.bodyLargeMedium.copyWith(
										color: color.textColor(context, variant),
                  ),
								),
							),
						DotBookCoverOverlay(
							variant: variant,
							coverColor: color,
							imageWidth: width,
							imageHeight: imageHeight,
							overlayImage: overlayImage,
							onTap: onOverlayTap,
							bottomText: bottomText,
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
