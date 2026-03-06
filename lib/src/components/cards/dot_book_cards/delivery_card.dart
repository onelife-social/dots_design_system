import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotBookDeliveryCard extends StatelessWidget {
  /// The image to be displayed on the card.
  final ImageProvider? image;

  /// The width of the image.
  final double imageWidth;

  /// The title of the delivery card.
  final String? title;

  /// The standard delivery text.
  final String? standarText;

  /// The standard delivery date.
  final String? standarDate;

  /// The express delivery text.
  final String? expressText;

  /// The express delivery date.
  final String? expressDate;

  /// The title to be displayed on the onTap action. If null, the card will not be tappable.
  final String? onTapTitle;

  /// The onTap action to be executed when the card is tapped. If null, the card will not be tappable.
  final VoidCallback? onTap;

  const DotBookDeliveryCard({
    super.key,
    this.image,
    this.imageWidth = 53,
    this.title,
    this.standarText,
    this.standarDate,
    this.expressText,
    this.expressDate,
    this.onTapTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.colors.bgContainerSecondaryOnBackground,
        borderRadius: DotsBorderRadius.r32,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 24,
          children: [
            if (image != null) Image(image: image!, width: imageWidth, fit: BoxFit.cover),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: theme.typo.main.bodyLargeMedium.copyWith(
                        color: theme.colors.textPrimary,
                      ),
                    ),
                  const SizedBox(height: 4),
                  if (standarText != null && standarDate != null)
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: standarText,
                            style: theme.typo.main.bodyDefaultMedium.copyWith(
                              color: theme.colors.textTertiary,
                            ),
                          ),
                          TextSpan(
                            text: standarDate,
                            style: theme.typo.main.bodyDefaultRegular.copyWith(
                              color: theme.colors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (expressText != null && expressDate != null)
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: expressText,
                            style: theme.typo.main.bodyDefaultMedium.copyWith(
                              color: theme.colors.textTertiary,
                            ),
                          ),
                          TextSpan(
                            text: expressDate,
                            style: theme.typo.main.bodyDefaultRegular.copyWith(
                              color: theme.colors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (onTapTitle != null) ...[
                    GestureDetector(
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.5),
                        child: Text(
                          onTapTitle!,
                          style: theme.typo.main.labelDefaultBold.copyWith(
                            color: theme.colors.labelHighlight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
