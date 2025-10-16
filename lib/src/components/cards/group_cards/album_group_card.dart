import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum AlbumGroupCardVariant {
  small,
  large;

  bool get isSmall => this == AlbumGroupCardVariant.small;
  bool get isLarge => this == AlbumGroupCardVariant.large;
}

class AlbumGroupCard extends StatelessWidget {
  /// The variant of the group card.
  final AlbumGroupCardVariant variant;

  /// The image provider for the background image
  final ImageProvider imageProvider;

  /// Title that will be displayed at the bottom of the card.
  final String title;

  /// The icon data for the Card tag.
  final DotsIconData? tagIconData;

  /// Callback when the profile image is tapped.
  final Function()? onTap;

  /// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  const AlbumGroupCard({
    super.key,
    required this.imageProvider,
    required this.title,
    this.variant = AlbumGroupCardVariant.small,
    this.tagIconData,
    this.onTap,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          clipBehavior: Clip.antiAlias,
          constraints: BoxConstraints(
            minWidth: variant.isSmall ? 135 : 288,
            minHeight: variant.isSmall ? 135 : 288,
            maxHeight: variant.isSmall ? 160 : 340,
            maxWidth: variant.isSmall ? 160 : 340,
          ),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(variant.isLarge ? 52 : 32),
            ),
          ),
          child: Stack(
            children: [
              DotsLinearGradientBlur(
                sigma: 25,
                linearGradientBlur: const LinearGradientBlur(
                  values: [0, 1],
                  stops: [0.7, 0.9],
                  start: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(variant.isLarge ? 52 : 32),
                  child: Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      if (onError != null) onError!(error, stackTrace);
                      return SizedBox();
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(variant.isSmall ? 16 : 24),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: (variant.isSmall
                                ? theme.typo.main.bodyDefaultMedium
                                : theme.typo.main.bodyLargeMedium)
                            .copyWith(color: theme.colors.labelAlwaysWhite),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    if (tagIconData != null)
                      Positioned(
                        left: 0,
                        top: 0,
                        child: CardTag(
                          iconData: tagIconData!,
                          size: variant.isSmall ? 24 : 28,
                          iconSize: variant.isSmall ? 16 : 20,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
