import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotBookFeatureCard extends StatelessWidget {
	/// Image provider for the feature image.
	final ImageProvider? imageCard;

  /// Height for the feature image.
  final double imageHeight;

	/// Card title.
	final String? title;

	/// Card description.
	final String? description;

	/// Optional tap callback.
	final Function()? onTap;

	/// Optional width for the card.
	final double width;

	/// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

	const DotBookFeatureCard({
		super.key,
		this.imageCard,
    this.imageHeight = 80,
		this.title,
		this.description,
		this.onTap,
		this.width = 185,
		this.onError,
	});


	@override
	Widget build(BuildContext context) {
		final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colors.bgContainerSecondary,
            borderRadius: DotsBorderRadius.r32,
          ),
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
            children: [
                  if (imageCard != null)
                    ClipRRect(
                        borderRadius: DotsBorderRadius.r24,
                        child: Image(
                            image: imageCard!,
                            height: imageHeight,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                                if (onError != null) onError!(error, stackTrace);
                                return const SizedBox();
                            },
                        ),
                    ),
                  if (title != null && title!.isNotEmpty)
                    Text(
                      title!,
                      style: theme.typo.main.titleH6.copyWith(
                        color: theme.colors.textPrimary,
                      ),
                    ),
              if (description != null && description!.isNotEmpty)
                Text(
                  description!,
                  style: theme.typo.main.bodyDefaultRegular.copyWith(
                    color: theme.colors.textTertiary,
                  ),
                ),
                ],
          ),
        ),
      ),
    );
	}
}
