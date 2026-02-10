import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotBookTestimonialCard extends StatelessWidget {
	/// Image provider for the testimonial image.
	final ImageProvider? imageCard;

  /// Height for the testimonial image.
  final double imageHeight;

  /// Image provider for the profile image.
	final ImageProvider? imageProfile;

	/// Card title.
	final String? title;

	/// Card description.
	final String? description;

  /// Username for the testimonial.
  final String? username;

	/// Optional tap callback.
	final VoidCallback? onTap;

	/// Optional width for the card.
	final double width;

	/// Callback when an error occurs while loading the image card.
  final void Function(Object exception, StackTrace? stackTrace)? onErrorImageCard;

	/// Callback when an error occurs while loading the profile image.
  final void Function(Object exception, StackTrace? stackTrace)? onErrorProfileImage;


	const DotBookTestimonialCard({
		super.key,
		this.imageCard,
    this.imageHeight = 170,
    this.imageProfile,
		this.title,
		this.description,
    this.username,
		this.onTap,
		this.width = 300,
		this.onErrorImageCard,
    this.onErrorProfileImage,
	});


	@override
	Widget build(BuildContext context) {
		final theme = context.dotsTheme;

		return SizedBox(
			width: width,
			child: Container(
				padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 20),
				decoration: BoxDecoration(
					color: theme.colors.bgStrong,
					borderRadius: DotsBorderRadius.r32,
					boxShadow: [
						BoxShadow(
							color: theme.colors.shadowPrimary,
							blurRadius: 10,
							offset: const Offset(0, 5),
							spreadRadius: 0,
						),
					],
				),
				child: Column(
					spacing: 18,
					mainAxisSize: MainAxisSize.min,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
            imageCard != null
            ? ClipRRect(
                borderRadius: DotsBorderRadius.r24,
                child: Image(
                  image: imageCard!,
                  height: imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    if (onErrorImageCard != null) onErrorImageCard!(error, stackTrace);
                    return SizedBox();
                  },
                ),
              )
            : SizedBox(),
						Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null && title!.isNotEmpty)...[
                    Text(
                      title!,
                      style: theme.typo.main.titleH5.copyWith(
                        color: theme.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (description != null && description!.isNotEmpty)
                    Text(
                      description!,
                      style: theme.typo.main.bodyLargeRegular.copyWith(
                        color: theme.colors.textPrimary,
                      ),
                    ),
                ],
              ),
            ),
						Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  if (imageProfile != null)...[
                    DotsProfilePhoto(
                      imageProvider: imageProfile!,
                      width: 40,
                      height: 40,
                      onError: (error, stackTrace) {
                        if (onErrorProfileImage != null) onErrorProfileImage!(error, stackTrace);
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (username != null && username!.isNotEmpty)
                    Text(
                      username!,
                      style: theme.typo.main.bodyLargeMedium.copyWith(
                        color: theme.colors.textTertiary,
                      ),
                    ),
                ],
              ),
            ),
					],
				),
			),
		);
	}
}
