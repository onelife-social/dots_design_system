import 'package:dots_design_system/src/components/models/group_card_model.dart';
import 'package:flutter/material.dart';
import 'event_small_card.dart';
import 'event_large_card.dart';

enum EventAlbumCardsVariant {
  small,
  active,
  passed;

  bool get isSmall => this == EventAlbumCardsVariant.small;
  bool get isActive => this == EventAlbumCardsVariant.active;
  bool get isPassed => this == EventAlbumCardsVariant.passed;
}


class EventAlbumCards extends StatelessWidget {
  /// The variant of the album card.
  final EventAlbumCardsVariant variant;

  /// The image provider to display (NetworkImage, AssetImage, etc).
  final ImageProvider imageProvider;

  /// The name of the album to display on the card.
  final String albumName;

  /// Whether the album is a prime album.
  final bool isPrime;

  /// Callback when the profile image is tapped.
  final Function()? onTap;

  /// The text to display when the album is active.
  final String activeText;

  /// The text to display on the button when the album is not active.
  final String btnText;

  /// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// The actions to display in the card menu.
  final List<EventGroupCardModel> actions;


  const EventAlbumCards._internal({
    super.key,
    required this.variant,
    required this.imageProvider,
    required this.albumName,
    required this.isPrime,
    required this.activeText,
    required this.btnText,
    this.onTap,
    this.onError,
    this.actions = const [],
  });

  factory EventAlbumCards.small({
    Key? key,
    required ImageProvider imageProvider,
    required String albumName,
    required bool isPrime,
    Function()? onTap,
    void Function(Object, StackTrace?)? onError,
  }) {
    return EventAlbumCards._internal(
      key: key,
      variant: EventAlbumCardsVariant.small,
      imageProvider: imageProvider,
      albumName: albumName,
      isPrime: isPrime,
      activeText: '',
      btnText: '',
      onTap: onTap,
      onError: onError,
      actions: const [],
    );
  }

  factory EventAlbumCards.large({
    Key? key,
    required EventAlbumCardsVariant variant,
    required ImageProvider imageProvider,
    required String albumName,
    required bool isPrime,
    required String activeText,
    required String btnText,
    Function()? onTap,
    void Function(Object, StackTrace?)? onError,
    required List<EventGroupCardModel> actions,
  }) {
    return EventAlbumCards._internal(
      key: key,
      variant: variant,
      imageProvider: imageProvider,
      albumName: albumName,
      isPrime: isPrime,
      onTap: onTap,
      onError: onError,
      actions: actions,
      activeText: activeText,
      btnText: btnText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return variant.isSmall
        ? EventAlbumCardSmall(
            isPrime: isPrime,
            imageProvider: imageProvider,
            albumName: albumName,
            onTap: onTap,
            onError: onError,
          )
        : EventAlbumCardLarge(
            variant: variant,
            isPrime: isPrime,
            imageProvider: imageProvider,
            albumName: albumName,
            onTap: onTap,
            onError: onError,
            actions: actions,
            activeText: activeText,
            btnText: btnText,
          );
  }
}
