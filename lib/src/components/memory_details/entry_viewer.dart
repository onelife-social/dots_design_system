import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsEntryViewerVariant {
  main,
  emoji;

  bool get isMain => this == DotsEntryViewerVariant.main;
  bool get isEmoji => this == DotsEntryViewerVariant.emoji;
}


class DotsEntryViewer extends StatelessWidget {

  /// The variant of the entry viewer.
  /// default is [DotsEntryViewerVariant.main].
  final DotsEntryViewerVariant variant;

  /// The user image to display in the entry viewer.
  final ImageProvider? userImage;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// The user name to display in the entry viewer.
  final String? userName;

  /// Whether the entry is liked by the user.
  /// Used to display a like icon or similar indicator.
  /// Default is false.
  final bool isLiked;

  /// The emojiReaction to display in the entry viewer.
  final String? emojiReaction;

  const DotsEntryViewer({
    super.key,
    this.variant = DotsEntryViewerVariant.main,
    this.userImage,
    this.onError,
    this.userName,
    this.isLiked = false,
    this.emojiReaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (userImage != null && variant.isMain)
            Padding(
              padding: const EdgeInsets.only(right: 6.0, bottom: 4.0),
              child: DotsProfilePhoto(
                imageProvider: userImage!,
                onError: onError,
                width: 44,
                height: 44,
              ),
            )
          else if (variant.isEmoji && emojiReaction != null)
            Padding(
              padding: const EdgeInsets.only(right: 6.0, bottom: 4.0),
              child: DotsProfilePhotoBited(
                imageProvider: userImage!,
                onError: onError,
                width: 44,
                height: 44,
                reaction: emojiReaction,
                emojiStyle: theme.typo.main.labelDefaultBold,
              ),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              userName ?? '',
              style: theme.typo.main.bodyLargeRegular.copyWith(
                color: theme.colors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          if (isLiked)
            DotsIcon(
              iconData: DotsIconData.heart,
              size: 20,
              color: theme.colors.couple007,
            ),
        ],
      ),
    );
  }
}