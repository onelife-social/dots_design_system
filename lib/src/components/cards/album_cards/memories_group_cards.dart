import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum MemoriesAlbumCardsVariant {
  small,
  large;

  bool get isSmall => this == MemoriesAlbumCardsVariant.small;
  bool get isLarge => this == MemoriesAlbumCardsVariant.large;
}

class MemoriesAlbumCards extends StatelessWidget {
  /// The variant of the album card.
  final MemoriesAlbumCardsVariant variant;

  /// The image provider to display (NetworkImage, AssetImage, etc).
  final ImageProvider imageProvider;

  /// The name of the album to display on the card.
  final String albumName;

  /// Whether the album is a prime album.
  final bool isPrime;

  /// Callback when the profile image is tapped.
  final Function()? onTap;

  /// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  const MemoriesAlbumCards({
    super.key,
    required this.imageProvider,
    required this.albumName,
    this.variant = MemoriesAlbumCardsVariant.small,
    this.isPrime = false,
    this.onTap,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: variant.isSmall ? 160 : 340,
        height: variant.isSmall ? 160 : 340,
        clipBehavior: Clip.antiAlias,
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
                      theme.colors.bgContainerPrimary,
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
                        albumName,
                        textAlign: TextAlign.center,
                        style: variant.isSmall
                            ? theme.typo.main.labelDefaultMedium.copyWith(color: theme.colors.textPrimary)
                            : theme.typo.main.bodyLargeMedium.copyWith(color: theme.colors.textPrimary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  if (isPrime)
                    Positioned(
                      left: 0,
                      top: 0,
                      child: PrimeTag(
                        size: variant.isSmall ? 20 : 28,
                        iconSize: variant.isSmall ? 16 : 20,
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