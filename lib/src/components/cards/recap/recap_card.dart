import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum RecapCardVariant {
  newRecap,
  oldRecap;

  bool get isNewRecap => this == RecapCardVariant.newRecap;
  bool get isOldRecap => this == RecapCardVariant.oldRecap;
}

class RecapCard extends StatelessWidget {
  /// The width of the card.
  final double width;

  /// The variant of the group card.
  final RecapCardVariant variant;

  /// The image provider for the background image
  final ImageProvider imageProvider;

  /// The default image provider for the background image.
  final ImageProvider defaultImage;

  /// Button text that will be displayed at the bottom of the card.
  final String buttonText;

  /// The text to display on the badge label.
  final String? badgeText;

  /// Callback when the profile image is tapped.
  final Function()? onTap;

  /// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  const RecapCard({
    super.key,
    required this.width,
    required this.imageProvider,
    required this.defaultImage,
    required this.buttonText,
    required this.badgeText,
    this.variant = RecapCardVariant.newRecap,
    this.onTap,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: AspectRatio(
          aspectRatio: 4 / 5,
          child: DotsDecoratedBox(
            styleType: theme.styles.defaultShadow,
            child: DotsDecoratedBox(
              styleType: theme.styles.squircle52,
              child: Stack(
                children: [
                  Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      if (onError != null) onError!(error, stackTrace);
                      return Image(image: defaultImage);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        if (badgeText != null)
                          Positioned(
                            top: 7,
                            left: 7,
                            child: BadgeLabel(
                              content: badgeText!,
                              variant: BadgeLabelVariant.premium,
                              size: BadgeLabelSize.large,
                            ),
                          ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: variant.isNewRecap
                              ? DotsMainButton(
                                  content: buttonText,
                                  variant: DotsMainButtonVariant.surface,
                                  expand: false,
                                  onTap: onTap,
                                  shouldApplyBlur: true,
                                )
                              : Text(
                                  buttonText,
                                  textAlign: TextAlign.center,
                                  style: theme.typo.main.bodyDefaultMedium.copyWith(
                                    color: theme.colors.labelAlwaysWhite,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
