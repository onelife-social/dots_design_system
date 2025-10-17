import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsListsItemVariant {
  main,
  selector,
  icon,
  check,
  radioButton;

  bool get isMain => this == DotsListsItemVariant.main;
  bool get isSelector => this == DotsListsItemVariant.selector;
  bool get isIcon => this == DotsListsItemVariant.icon;
  bool get isCheck => this == DotsListsItemVariant.check;
  bool get isRadioButton => this == DotsListsItemVariant.radioButton;
}

class DotsListItemModel {
  final String label;
  final DotsIconData iconData;
  final ImageProvider? image;
  final DotsListsItemVariant variant;
  final void Function()? onTap;

  DotsListItemModel({
    required this.label,
    this.iconData = DotsIconData.user,
    this.image,
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

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  const DotsListsItem({
    super.key,
    this.variant = DotsListsItemVariant.main,
    this.image,
    this.label,
    this.onTap,
    this.iconData = DotsIconData.user,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (image != null && !variant.isIcon)
            DotsImageThumbnail(
              variant: DotsImageThumbnailVariant.image,
              image: image,
              onError: onError,
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
