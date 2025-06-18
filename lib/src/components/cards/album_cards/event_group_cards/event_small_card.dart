
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class EventAlbumCardSmall extends StatelessWidget {
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

  EventAlbumCardSmall({
    required this.imageProvider,
    required this.albumName,
    required this.isPrime,
    this.onTap,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 160,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            onError: onError,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 43,
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
              padding: EdgeInsets.all(16),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        albumName,
                        textAlign: TextAlign.center,
                        style:theme.typo.main.labelDefaultMedium.copyWith(color: theme.colors.textPrimary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  if(isPrime)
                     Positioned(
                    left: 0,
                    top: 0,
                    child: PrimeTag(
                        size: 24,
                        iconSize: 16,
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