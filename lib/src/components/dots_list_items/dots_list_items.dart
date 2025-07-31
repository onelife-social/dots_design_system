import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsListsItemVariant {
  main,
  selector,
  icon,
  radioButton;

  bool get isMain => this == DotsListsItemVariant.main;
  bool get isSelector => this == DotsListsItemVariant.selector;
  bool get isIcon => this == DotsListsItemVariant.icon;
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: variant.isIcon
                  ? theme.colors.bgContainerSecondaryOnBackground
                  : theme.colors.transparent,
              borderRadius: BorderRadius.circular(12),
              image: (image != null && !variant.isIcon)
                  ? DecorationImage(
                      image: image!,
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        onError?.call(exception, stackTrace);
                      },
                    )
                  : null,
            ),
            child: Center(
              child: variant.isIcon
                  ? DotsIcon(
                      iconData: iconData,
                      color: Colors.white,
                      size: 20,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          if (label != null)
            Expanded(
              child: Text(
                label!,
                style: theme.typo.main.bodyLargeBold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          const SizedBox(width: 8),
          if (variant.isSelector || variant.isRadioButton)
            DotsRadioButton(
              isSelected: variant.isRadioButton,
              size: 22,
            ),
        ],
      ),
    );
  }
}