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

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.antiAlias,
          constraints: BoxConstraints(
            maxHeight: variant.isSmall ? 160 : 340,
            maxWidth: variant.isSmall ? 160 : 340,
          ),
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              onError: onError,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(variant.isLarge ? 52 : 32),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: variant.isLarge ? 94 : 43,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0x803c3c3c),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(variant.isSmall ? 16 : 24),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: (variant.isSmall
                                  ? theme.typo.main.labelDefaultMedium
                                  : theme.typo.main.bodyLargeMedium)
                              .copyWith(color: theme.colors.labelAlwaysWhite),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
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
