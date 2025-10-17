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
  /// Member unique id.
  final String? id;

  /// The visual variant of the item.
  final UserItemListVariant variant;

  /// User information data to display.
  final UserInfoData? data;

  // Callback when the component is pressed.
  final void Function(String?)? onTap;

  /// *(Only for `label/button/text` variant)* Label to display.
  final String label;

  /// *(Only for `button` variant)* Icon to display.
  final DotsIconData? icon;

  /// *(Only for `text` variant)* Text controller for the input field.
  final TextEditingController? textController;

  /// *(Only for `text` variant)* Text onChanged callback for the input field.
  final ValueChanged<String>? textOnChanged; //* onLostFocus

  const UsersItemList._({
    super.key,
    this.id,
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
    required String id,
    required UserInfoData data,
    required void Function(String?)? onTap,
  }) =>
      UsersItemList._(
        key: key,
        id: id,
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
    required String? id,
    required String label,
    required TextEditingController textController,
    required ValueChanged<String> textOnChanged,
    required void Function(String?)? onTap,
  }) =>
      UsersItemList._(
        key: key,
        id: id,
        variant: UserItemListVariant.textfield,
        label: label,
        textController: textController,
        textOnChanged: textOnChanged,
        onTap: onTap,
      );

  factory UsersItemList.button({
    Key? key,
    required void Function(String?)? onTap,
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
    final String? tapValue = switch (variant) {
      UserItemListVariant.main || UserItemListVariant.textfield => id,
      _ => null,
    };

    return GestureDetector(
      onTap: () => onTap?.call(tapValue),
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
              tapValue: tapValue,
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
        return SizedBox(
          height: 30,
          child: Center(
            child: Row(
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
            ),
          ),
        );
    }
  }
}

class _TrailingWidget extends StatelessWidget {
  final UserItemListVariant variant;
  final void Function(String?)? onTap;
  final String? tapValue;
  final String? label;

  const _TrailingWidget({
    required this.variant,
    this.onTap,
    this.tapValue,
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
          onTap: () => onTap?.call(tapValue),
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
