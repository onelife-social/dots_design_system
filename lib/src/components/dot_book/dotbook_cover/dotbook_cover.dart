import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/core/values/paths/paths_lib.dart';
import 'package:flutter/material.dart';

enum DotBookCoverType {
  linen,
  printedSquare,
  printedCircle,
}

class DotBookCover extends StatelessWidget {
  final DotBookCoverType variant;

	/// Image rendered above the base cover.
	final ImageProvider? overlayImage;

	/// Horizontal padding used for [DotBookCoverType.printedSquare] overlay.
	final double printedSquareHorizontalPadding;

	/// Bottom padding used for [DotBookCoverType.printedSquare] overlay.
	final double printedSquareBottomPadding;

	/// Text shown according to variant positioning rules.
	final String bottomText;

	/// Optional style for [bottomText].
	final TextStyle? bottomTextStyle;

	const DotBookCover({
		super.key,
    required this.variant,
		this.overlayImage,
		this.printedSquareHorizontalPadding = 16,
		this.printedSquareBottomPadding = 16,
		this.bottomText = '',
		this.bottomTextStyle,
	});

	@override
	Widget build(BuildContext context) {
		final double width = MediaQuery.sizeOf(context).width * 0.85;
		final double imageHeight = width * (5 / 4);
		final TextStyle resolvedTextStyle =
				bottomTextStyle ??
				context.dotsTheme.typo.main.bodyLargeMedium.copyWith(
						color: Colors.white,
					);

		return Center(
			child: SizedBox(
				width: width,
				height: imageHeight,
				child: Stack(
					fit: StackFit.expand,
					children: [
						Image.asset(
							ImagesPaths.dotbookCover,
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
									style: resolvedTextStyle,
								),
							),
						if (overlayImage != null) _buildOverlay(context, width, imageHeight),
					],
				),
			),
		);
	}

	Widget _buildOverlay(BuildContext context, double imageWidth, double imageHeight) {
		final Image overlay = Image(
			image: overlayImage!,
			fit: BoxFit.cover,
		);
		final TextStyle resolvedTextStyle =
				bottomTextStyle ??
				context.dotsTheme.typo.main.bodyLargeMedium.copyWith(
						color: Colors.white,
					);

		switch (variant) {
			case DotBookCoverType.linen:
				return Center(
					child: SizedBox(
						width: imageWidth,
						height: imageHeight / 3,
						child: Stack(
							fit: StackFit.expand,
							children: [
								overlay,
								Container(
									color: Colors.black.dotsWithOpacity(0.2),
								),
								if (bottomText.isNotEmpty)
									Positioned(
										left: 8,
										right: 8,
										bottom: 13,
										child: Text(
											bottomText,
											textAlign: TextAlign.center,
											maxLines: 1,
											overflow: TextOverflow.ellipsis,
											style: resolvedTextStyle,
										),
									),
							],
						),
					),
				);
			case DotBookCoverType.printedSquare:
				return Positioned(
					left: printedSquareHorizontalPadding,
					right: printedSquareHorizontalPadding,
					bottom: printedSquareBottomPadding,
					child: SizedBox(
						height: imageHeight * (2 / 3),
						child: Stack(
							fit: StackFit.expand,
							children: [
								overlay,
								if (bottomText.isNotEmpty)
									Positioned(
										left: 8,
										right: 8,
										bottom: 13,
										child: Text(
											bottomText,
											textAlign: TextAlign.center,
											maxLines: 1,
											overflow: TextOverflow.ellipsis,
											style: resolvedTextStyle,
										),
									),
							],
						),
					),
				);
			case DotBookCoverType.printedCircle:
				return Center(
					child: Padding(
						padding: EdgeInsets.symmetric(horizontal: imageWidth * 0.2),
						child: SizedBox(
							height: imageHeight * 0.4,
							child: AspectRatio(
								aspectRatio: 1,
								child: ClipOval(child: overlay),
							),
						),
					),
				);
		}
	}
}
