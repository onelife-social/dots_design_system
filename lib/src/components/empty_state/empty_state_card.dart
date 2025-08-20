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

  /// Icon to display in the empty state card.
  final DotsMainButton? button;

  /// Add extra space after the image.
  final double extraSpaceAfterImage;

  const DotsEmptyStateCard({
    super.key,
    required this.variant,
    this.imageProvider,
    this.icon,
    required this.title,
    required this.description,
    this.button,
    this.extraSpaceAfterImage = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Container(
      width: context.screenWidth * context.getByRatio(0.8205, 0.9),
      padding: EdgeInsets.symmetric(horizontal: context.getByRatio(20, 12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (variant == DotsEmptyStateCardVariant.image && imageProvider != null)
            Image(image: imageProvider!)
          else if (variant == DotsEmptyStateCardVariant.icon && icon != null)
            icon!,
          SizedBox(
              height: variant == DotsEmptyStateCardVariant.image ? 4 + extraSpaceAfterImage : 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.getByRatio(20, 12)),
            child: Text(
              title,
              style: theme.typo.secondary.title02H6.copyWith(
                color: theme.colors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.typo.main.labelDefaultRegular.copyWith(
              color: theme.colors.textQuarternary,
            ),
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
