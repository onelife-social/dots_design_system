import '../../../dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsListsItemVariant {
  main,
  selector,
  icon,
  check,
  radioButton,
  divider;

  bool get isMain => this == DotsListsItemVariant.main;
  bool get isSelector => this == DotsListsItemVariant.selector;
  bool get isIcon => this == DotsListsItemVariant.icon;
  bool get isCheck => this == DotsListsItemVariant.check;
  bool get isRadioButton => this == DotsListsItemVariant.radioButton;
  bool get isDivider => this == DotsListsItemVariant.divider;
}

enum DotsListsItemPicType {
  album,
  user;

  bool get isAlbum => this == DotsListsItemPicType.album;
  bool get isUser => this == DotsListsItemPicType.user;
}

class DotsListItemModel {
  final String label;
  final DotsIconData iconData;
  final ImageProvider? image;
  final DotsListsItemPicType picType;
  final DotsListsItemVariant variant;
  final void Function()? onTap;

  DotsListItemModel({
    required this.label,
    this.iconData = DotsIconData.user,
    this.image,
    this.picType = DotsListsItemPicType.album,
    required this.variant,
    this.onTap,
  });
}

class DotsListsItem extends StatelessWidget {
  /// The [image] can be used to display an icon or image next to the label.
  final ImageProvider? image;

  /// The label for the filter chip.
  final String? label;

  /// Callback when the close button chip is tapped.
  final void Function()? onTap;

  /// The icon data to be displayed if the variant is icon.
  final DotsIconData iconData;

  /// The variant of the list item.
  final DotsListsItemVariant variant;

  /// The type of the picture.
  final DotsListsItemPicType picType;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  const DotsListsItem({
    super.key,
    this.variant = DotsListsItemVariant.main,
    this.image,
    this.label,
    this.onTap,
    this.picType = DotsListsItemPicType.album,
    this.iconData = DotsIconData.user,
    this.onError,
  });

  static Image defaultImage = Image.asset(
    ImagesPaths.defaultUserItem,
    width: 40,
    height: 40,
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    if (variant.isDivider) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label ?? '',
                style: theme.typo.main.labelSmallMedium.copyWith(color: theme.colors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            height: 3,
            color: theme.colors.labelSecondary.dotsWithOpacity(0.5),
            thickness: 0.2,
          ),
        ],
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (image != null && !variant.isIcon && picType.isAlbum)
            DotsImageThumbnail(
              variant: DotsImageThumbnailVariant.image,
              image: image,
              onError: onError,
            )
          else if (image != null && !variant.isIcon && picType.isUser)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colors.bgBaseContrast,
              ),
              child: ClipOval(
                child: Image(
                  image: image!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return defaultImage;
                  },
                  errorBuilder: (context, error, stackTrace) {
                    if (onError != null) onError!(error, stackTrace);
                    return defaultImage;
                  },
                ),
              ),
            )
          else
            DotsImageThumbnail(
              variant: DotsImageThumbnailVariant.icon,
              iconData: iconData,
              iconColor: theme.colors.textPrimary,
              iconSize: 20,
            ),
          const SizedBox(width: 12),
          if (label != null)
            Expanded(
              child: Text(
                label!,
                style: theme.typo.main.bodyDefaultMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          const SizedBox(width: 8),
          if (variant.isSelector || variant.isRadioButton)
            DotsRadioButton(
              isSelected: variant.isRadioButton,
              size: 22,
            )
          else if (variant.isCheck)
            DotsSelector.check(
              size: DotsSelectorSize.small,
              isSelected: true,
            ),
        ],
      ),
    );
  }
}
