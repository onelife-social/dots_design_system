import '../../../../dots_design_system.dart';
import 'package:flutter/material.dart';

import '../../../../utils/text_utils.dart';

enum DotsNotificationItemVariant {
  main,
  event,
  reaction;

  bool get isMain => this == DotsNotificationItemVariant.main;
  bool get isEvent => this == DotsNotificationItemVariant.event;
  bool get isReaction => this == DotsNotificationItemVariant.reaction;
}

class DotsNotificationItem extends StatelessWidget {
  /// The variant of the notification item.
  final DotsNotificationItemVariant variant;

  /// Callback when the notification item is tapped.
  final void Function()? onTap;

  /// The profile image to be displayed in the notification item.
  final ImageProvider profileImage;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onProfileImageError;

  /// The action image to be displayed in the notification item.
  final ImageProvider? actionImage;

  /// Callback for action image load error.
  /// Called when the action image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onActionImageError;

  /// Text for the main button, if applicable.
  final String? mainBtnText;

  /// Callback when the main button is tapped.
  final void Function()? onMainBtnTap;

  /// The icon data to be displayed if the variant is icon.
  /// Defaults to DotsIconData.notification.
  final DotsIconData iconData;

  /// Size of the icon if the variant is icon.
  /// Defaults to 24.
  final double iconSize;

  /// Color of the icon if the variant is icon.
  final Color? iconColor;

  /// Title text for the notification item.
  final String title;

  /// Description text for the notification item.
  final String description;

  /// Date text for the notification item.
  final String? date;

  /// Max lines for the title and description.
  final int? maxLines;

  /// Action image text
  final String? actionImageText;

  const DotsNotificationItem({
    super.key,
    required this.variant,
    this.onTap,
    required this.profileImage,
    this.actionImage,
    this.onActionImageError,
    this.onProfileImageError,
    this.mainBtnText,
    this.onMainBtnTap,
    this.iconData = DotsIconData.cake,
    this.iconSize = 24,
    this.iconColor,
    this.title = '',
    this.description = '',
    this.date,
    this.maxLines,
    this.actionImageText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DotsProfilePhoto(
              imageProvider: profileImage,
              onError: onProfileImageError,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _Info(
                variant: variant,
                title: title,
                description: description,
                date: date,
                maxLines: maxLines,
              ),
            ),
            const SizedBox(width: 12),
            if (variant.isMain)
              DotsMainButton(
                content: mainBtnText ?? '',
                variant: DotsMainButtonVariant.main,
                size: DotsMainButtonSize.small,
                onTap: onMainBtnTap,
                expand: false,
              )
            else if (variant.isReaction)
              Stack(
                children: [
                  DotsImageThumbnail(
                    variant: DotsImageThumbnailVariant.image,
                    image: actionImage,
                    onError: onActionImageError,
                    coverImage: actionImageText?.isNotEmpty == true,
                  ),
                  if (actionImageText?.isNotEmpty == true)
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          actionImageText!,
                          style: theme.typo.number.numBodyDefault.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.colors.labelAlwaysWhite,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                ],
              )
            else
              DotsImageThumbnail(
                variant: DotsImageThumbnailVariant.icon,
                iconData: iconData,
                iconSize: iconSize,
                iconColor: iconColor,
              ),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final DotsNotificationItemVariant variant;
  final String? title;
  final String? description;
  final String? date;
  final int? maxLines;

  const _Info({
    required this.variant,
    this.title,
    this.description,
    this.date,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    if (variant.isMain) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title!.isNotEmpty)
            Text(
              title!,
              style: theme.typo.main.labelDefaultBold.copyWith(
                color: theme.colors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          if (description != null && description!.isNotEmpty)
            Text.rich(
              TextSpan(
                children: TextUtils().buildTextWithEmojiSpans(
                  text: description!,
                  baseStyle: theme.typo.main.labelDefaultRegular.copyWith(
                    color: theme.colors.textSecondary,
                  ),
                ),
              ),
              maxLines: maxLines,
              overflow: maxLines != null ? TextOverflow.ellipsis : null,
            ),
        ],
      );
    } else {
      return Text.rich(
        TextSpan(
          children: [
            if (title != null && title!.isNotEmpty)
              TextSpan(
                text: '$title ',
                style: theme.typo.main.labelDefaultBold.copyWith(
                  color: theme.colors.textPrimary,
                ),
              ),
            TextSpan(
              children: [
                if (description != null && description!.isNotEmpty)
                  ...TextUtils().buildTextWithEmojiSpans(
                    text: description!,
                    baseStyle: theme.typo.main.labelDefaultRegular.copyWith(
                      color: theme.colors.textSecondary,
                    ),
                  ),
                if (date != null && date!.isNotEmpty && !variant.isEvent)
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: Text(
                      ' $date',
                      style: theme.typo.number.numLabelDefault.copyWith(
                        color: theme.colors.textQuarternary,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
      );
    }
  }
}
