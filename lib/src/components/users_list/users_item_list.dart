import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum UserItemListVariant {
  main,
  label,
  ;
}

class UsersItemList extends StatelessWidget {
  /// The visual variant of the item.
  final UserItemListVariant variant;

  /// User information data to display.
  final UserInfoData data;

  // Callback when the component is pressed.
  final VoidCallback? onTap;

  /// *(Only for label variant)* Label to display.
  final String label;

  const UsersItemList._({
    super.key,
    this.variant = UserItemListVariant.main,
    required this.data,
    this.onTap,
    this.label = '',
  });

  factory UsersItemList.main({
    Key? key,
    required UserInfoData data,
    required VoidCallback onTap,
  }) =>
      UsersItemList._(
        key: key,
        variant: UserItemListVariant.main,
        data: data,
        onTap: onTap,
      );

  factory UsersItemList.label({
    Key? key,
    required UserInfoData data,
    required String label,
  }) =>
      UsersItemList._(
        key: key,
        variant: UserItemListVariant.label,
        data: data,
        label: label,
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            UserInfo(data: data),
            _TrailingWidget(variant: variant, onTap: onTap, label: label),
          ],
        ),
      ),
    );
  }
}

class _TrailingWidget extends StatelessWidget {
  final UserItemListVariant variant;
  final VoidCallback? onTap;
  final String? label;

  const _TrailingWidget({
    required this.variant,
    this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    switch (variant) {
      case UserItemListVariant.main:
        return DotsCloseButton(
          size: DotsCloseButtonSize.extraSmall,
          onTap: onTap,          
        );

      case UserItemListVariant.label:
        return Text(
          label!,
          style: theme.typo.main.labelSmallMedium.copyWith(
            color: theme.colors.labelActive,
          ),
        );
    }
  }
}
