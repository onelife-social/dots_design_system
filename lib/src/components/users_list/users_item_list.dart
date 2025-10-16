import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum UserItemListVariant {
  main,
  label,
  textfield,
  button,
  ;
}

class UsersItemList extends StatelessWidget {
  /// The visual variant of the item.
  final UserItemListVariant variant;

  /// User information data to display.
  final UserInfoData? data;

  // Callback when the component is pressed.
  final VoidCallback? onTap;

  /// *(Only for `label/button/text` variant)* Label to display.
  final String label;

  /// *(Only for `button` variant)* Icon to display.
  final DotsIconData? icon;

  /// *(Only for `text` variant)* Text controller for the input field.
  final TextEditingController? textController;

  /// *(Only for `text` variant)* Text onChanged callback for the input field.
  final ValueChanged<String>? textOnChanged;

  const UsersItemList._({
    super.key,
    this.variant = UserItemListVariant.main,
    this.data,
    this.onTap,
    this.label = '',
    this.icon,
    this.textController,
    this.textOnChanged,
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

  factory UsersItemList.textfield({
    Key? key,
    required VoidCallback onTap,
    required String label,
    required TextEditingController textController,
    required ValueChanged<String> textOnChanged,
  }) =>
      UsersItemList._(
        key: key,
        variant: UserItemListVariant.textfield,
        onTap: onTap,
        label: label,
        textController: textController,
        textOnChanged: textOnChanged,
      );

  factory UsersItemList.button({
    Key? key,
    required VoidCallback onTap,
    required String label,
    required DotsIconData icon,
  }) =>
      UsersItemList._(
        key: key,
        variant: UserItemListVariant.button,
        onTap: onTap,
        label: label,
        icon: icon,
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
            _MainWidget(
              variant: variant,
              data: data,
              icon: icon,
              label: label,
              textController: textController,
              textOnChanged: textOnChanged,
            ),
            _TrailingWidget(
              variant: variant,
              onTap: onTap,
              label: label,
            ),
          ],
        ),
      ),
    );
  }
}

class _MainWidget extends StatelessWidget {
  final UserItemListVariant variant;
  final UserInfoData? data;
  final DotsIconData? icon;
  final String? label;
  final TextEditingController? textController;
  final ValueChanged<String>? textOnChanged;

  const _MainWidget({
    required this.variant,
    this.data,
    this.icon,
    this.label,
    this.textController,
    this.textOnChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    switch (variant) {
      case UserItemListVariant.main:
      case UserItemListVariant.label:
        return UserInfo(data: data!);

      case UserItemListVariant.textfield:
        return Expanded(
          child: SizedBox(
            height: 30,
            child: Center(
              child: TextField(
                controller: textController!,
                decoration: InputDecoration(
                  hintText: label!,
                  hintStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                    color: theme.colors.textQuarternary,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.only(right: 12),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: theme.typo.main.bodyDefaultMedium.copyWith(
                  color: theme.colors.textPrimary,
                ),
                onChanged: textOnChanged,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                cursorColor: theme.colors.labelHighlight,
              ),
            ),
          ),
        );

      case UserItemListVariant.button:
        return Row(
          spacing: 6,
          children: [
            DotsIcon(
              iconData: icon!,
              size: 16,
              color: theme.colors.labelHighlight,
            ),
            Text(
              label!,
              style: theme.typo.main.bodyDefaultMedium.copyWith(
                color: theme.colors.labelHighlight,
              ),
            ),
          ],
        );
    }
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
      case UserItemListVariant.textfield:
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

      case UserItemListVariant.button:
        return Offstage();
    }
  }
}
