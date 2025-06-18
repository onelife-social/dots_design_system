import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'event_small_card.dart';
import 'event_large_card.dart';

enum GroupEventCardsVariant {
  small,
  active,
  passed;

  bool get isSmall => this == GroupEventCardsVariant.small;
  bool get isActive => this == GroupEventCardsVariant.active;
  bool get isPassed => this == GroupEventCardsVariant.passed;
}


class GroupEventCards extends StatelessWidget {
  /// The variant of the group card.
  final GroupEventCardsVariant variant;

  /// The image provider to display (NetworkImage, AssetImage, etc).
  final ImageProvider imageProvider;

  /// The name of the group to display on the card.
  final String groupName;

  /// Whether the group is a prime group.
  final bool isPrime;

  /// The icon data for the Card tag.
  final DotsIconData iconDataTag;

  /// Callback when the profile image is tapped.
  final Function()? onTap;

  /// The text to display when the group is active.
  final String activeText;

  /// The text to display on the button when the group is not active.
  final String btnText;

  /// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// The actions to display in the card menu.
  final List<GroupEventCardModel> actions;


  const GroupEventCards._internal({
    super.key,
    required this.variant,
    required this.imageProvider,
    required this.groupName,
    required this.isPrime,
    required this.iconDataTag,
    required this.activeText,
    required this.btnText,
    this.onTap,
    this.onError,
    this.actions = const [],
  });

  factory GroupEventCards.small({
    Key? key,
    required ImageProvider imageProvider,
    required String groupName,
    required bool isPrime,
    required DotsIconData iconDataTag,
    Function()? onTap,
    void Function(Object, StackTrace?)? onError,
  }) {
    return GroupEventCards._internal(
      key: key,
      variant: GroupEventCardsVariant.small,
      imageProvider: imageProvider,
      groupName: groupName,
      isPrime: isPrime,
      iconDataTag: iconDataTag,
      activeText: '',
      btnText: '',
      onTap: onTap,
      onError: onError,
      actions: const [],
    );
  }

  factory GroupEventCards.large({
    Key? key,
    required GroupEventCardsVariant variant,
    required ImageProvider imageProvider,
    required String groupName,
    required bool isPrime,
    required DotsIconData iconDataTag,
    required String activeText,
    required String btnText,
    Function()? onTap,
    void Function(Object, StackTrace?)? onError,
    required List<GroupEventCardModel> actions,
  }) {
    return GroupEventCards._internal(
      key: key,
      variant: variant,
      imageProvider: imageProvider,
      groupName: groupName,
      isPrime: isPrime,
      iconDataTag: iconDataTag,
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
        ? GroupEventCardSmall(
            isPrime: isPrime,
            iconDataTag: iconDataTag,
            imageProvider: imageProvider,
            groupName: groupName,
            onTap: onTap,
            onError: onError,
          )
        : GroupEventCardLarge(
            variant: variant,
            isPrime: isPrime,
            iconDataTag: iconDataTag,
            imageProvider: imageProvider,
            groupName: groupName,
            onTap: onTap,
            onError: onError,
            actions: actions,
            activeText: activeText,
            btnText: btnText,
          );
  }
}
