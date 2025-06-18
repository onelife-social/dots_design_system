import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';


class EventAlbumCardLarge extends StatelessWidget {
  /// The variant of the album card.
  /// 
  /// Defaults to [EventAlbumCardsVariant.active].
  final EventAlbumCardsVariant variant;

  /// The image provider to display (NetworkImage, AssetImage, etc).
  final ImageProvider imageProvider;

  /// Whether the album is a prime album.
  final bool isPrime;

  /// The name of the album to display on the card.
  final String albumName;

  /// The text to display when the album is active.
  final String activeText;

  /// The text to display on the button when the album is not active.
  final String btnText;

  /// Callback when the profile image is tapped.
  final Function()? onTap;

  /// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// The actions to display in the card menu.
  final List<EventGroupCardModel> actions;

  const EventAlbumCardLarge({
    required this.variant,
    required this.imageProvider,
    required this.albumName,
    required this.isPrime,
    this.onTap,
    this.onError,
    required this.actions,
    required this.activeText,
    required this.btnText,
  });
   

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 340,
        height: 340,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            onError: onError,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(52),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 94,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colors.bgContainerPrimary,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Stack(
                children: [
                  if(isPrime)
                     Positioned(
                    left: 0,
                    top: 0,
                    child: PrimeTag(
                        size: 28,
                        iconSize: 20,
                      ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          albumName,
                          textAlign: TextAlign.center,
                          style: theme.typo.main.bodyLargeBold.copyWith(color: theme.colors.textPrimary),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height:  variant.isActive ? 4 : 5),
                        variant.isActive
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 3,
                                  height: 3,
                                  decoration: ShapeDecoration(
                                    color: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.7),
                                    shape: OvalBorder(),
                                  ),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  activeText,
                                  style: theme.typo.main.labelSmallRegular.copyWith(color: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.7)),
                                ),
                              ],
                            )
                          : DotsMainButton(
                              content: btnText,
                              icon: DotsIconData.exitFullscreen,
                              variant: DotsMainButtonVariant.secondary,
                              iconSize: 14,
                              expand: false,
                              size: DotsMainButtonSize.small,
                              onTap: () {},
                            ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _MenuEventAlbumCard(
                      actions: actions,
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


class _MenuEventAlbumCard extends StatelessWidget {
  final List<EventGroupCardModel> actions;

  const _MenuEventAlbumCard({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            color: theme.colors.bgBtnDisabled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(actions.length * 2 - 1, (i) {
              if (i.isOdd) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Container(
                    width: 0.5,
                    height: 22.78,
                    color: Colors.black.withOpacity(0.1),
                  ),
                );
              }
              final action = actions[i ~/ 2];
              return GestureDetector(
                onTap: action.onTap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DotsIcon(
                      iconData: action.icon,
                      size: 20,
                    ),
                    SizedBox(
                      width: 46,
                      child: Text(
                        action.text,
                        textAlign: TextAlign.center,
                        style: theme.typo.main.labelSmallRegular,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}