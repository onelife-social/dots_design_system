import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsEmptyStateCardVariant { image, icon }

class DotsEmptyStateCard extends StatelessWidget {
  /// The variant of the empty state card.
  final DotsEmptyStateCardVariant variant;

  /// The image provider to display (NetworkImage, AssetImage, etc).
  final ImageProvider? imageProvider;

  /// The icon data to display (if variant is [DotsEmptyStateCardVariant.icon]).
  final DotsIcon? icon;

  /// Title of the empty state card.
  final String title;

  /// Description of the empty state card.
  final String description;

  /// Title color of the empty state card.
  final Color? titleColor;

  /// Description color of the empty state card.
  final Color? descriptionColor;

  /// Icon to display in the empty state card.
  final DotsMainButton? button;

  /// Add extra space after the image.
  final double extraSpaceAfterImage;

  /// Width of the image.
  final double? imageWidth;

  /// Rich description rendered instead of [description] when set; [description]
  /// stays as the accessibility label.
  final List<InlineSpan>? descriptionSpans;

  const DotsEmptyStateCard({
    super.key,
    required this.variant,
    this.imageProvider,
    this.icon,
    required this.title,
    required this.description,
    this.titleColor,
    this.descriptionColor,
    this.button,
    this.extraSpaceAfterImage = 0,
    this.imageWidth,
    this.descriptionSpans,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final TextStyle descriptionStyle = theme.typo.main.bodyDefaultRegular.copyWith(
      color: descriptionColor ?? theme.colors.textQuarternary,
    );
    final List<InlineSpan>? spans = descriptionSpans;

    return Container(
      width: context.screenWidth * context.getByRatio(0.8205, 0.9),
      padding: EdgeInsets.symmetric(horizontal: context.getByRatio(20, 12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (variant == DotsEmptyStateCardVariant.image && imageProvider != null)
            SizedBox(
              width: imageWidth,
              child: Image(image: imageProvider!),
            )
          else if (variant == DotsEmptyStateCardVariant.icon && icon != null)
            icon!,
          SizedBox(
              height: variant == DotsEmptyStateCardVariant.image ? 4 + extraSpaceAfterImage : 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.getByRatio(20, 12)),
            child: Text(
              title,
              style: theme.typo.secondary.title02H5.copyWith(
                color: titleColor ?? theme.colors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          if (spans != null && spans.isNotEmpty)
            Text.rich(
              TextSpan(children: spans),
              style: descriptionStyle,
              textAlign: TextAlign.center,
              semanticsLabel: description,
            )
          else
            Text(
              description,
              style: descriptionStyle,
              textAlign: TextAlign.center,
            ),
          if (button != null) ...[
            SizedBox(height: context.getByRatio(16, 10)),
            button!,
          ],
        ],
      ),
    );
  }
}
