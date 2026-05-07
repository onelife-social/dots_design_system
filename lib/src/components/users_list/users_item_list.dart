import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum UserItemListVariant {
  main,
  label,
  textfield,
  button,
  pending,
  join,
  waiting,
  basic,
  existingAlias,
  pendingMember;

  bool get isMain => this == UserItemListVariant.main;
  bool get isLabel => this == UserItemListVariant.label;
  bool get isTextfield => this == UserItemListVariant.textfield;
  bool get isButton => this == UserItemListVariant.button;
  bool get isPending => this == UserItemListVariant.pending;
  bool get isJoin => this == UserItemListVariant.join;
  bool get isWaiting => this == UserItemListVariant.waiting;
  bool get isBasic => this == UserItemListVariant.basic;
  bool get isExistingAlias => this == UserItemListVariant.existingAlias;
  bool get isPendingMember => this == UserItemListVariant.pendingMember;
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
  final String? label;

  /// *(Only for `button` variant)* Icon to display.
  final DotsIconData? icon;

  /// *(Only for `text` variant)* Text controller for the input field.
  final TextEditingController? textController;

  /// *(Only for `text` variant)* Callback when the textfield changes.
  final void Function(String?, String?)? textOnChanged;

  /// *(Only for `text` variant)* Focus node to preserve focus.
  final FocusNode? textFocusNode;

  /// *(Only for `pending` and `join` variants)* Icon size.
  final double? iconSize;

  /// *(Only for `text` variant)* Whether to autofocus on empty textfield.
  final bool autofocusOnEmpty;

  /// *(Only for `pendingMember` variant)* On tap callback for button 1.
  final void Function(String?)? onTapButton1;

  /// *(Only for `pendingMember` variant)* On tap callback for button 2.
  final void Function(String?)? onTapButton2;

  /// *(Only for `pendingMember` variant)* Button label for button 1.
  final String? buttonLabel1;

  /// *(Only for `pendingMember` variant)* Button label for button 2.
  final String? buttonLabel2;

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
    this.textFocusNode,
    this.iconSize,
    this.autofocusOnEmpty = true,
    this.onTapButton1,
    this.onTapButton2,
    this.buttonLabel1,
    this.buttonLabel2,
  });

  factory UsersItemList.main({
    Key? key,
    required String id,
    required UserInfoData data,
    required void Function(String?)? onTap,
  }) => UsersItemList._(
    key: key,
    id: id,
    variant: UserItemListVariant.main,
    data: data,
    onTap: onTap,
  );

  factory UsersItemList.label({
    Key? key,
    String? id,
    required UserInfoData data,
    required String label,
    void Function(String?)? onTap,
  }) => UsersItemList._(
    key: key,
    id: id,
    variant: UserItemListVariant.label,
    data: data,
    label: label,
    onTap: onTap,
  );

  factory UsersItemList.pending({
    Key? key,
    required UserInfoData data,
    Function(String?)? onTap,
    double? iconSize,
  }) => UsersItemList._(
    key: key,
    variant: UserItemListVariant.pending,
    data: data,
    onTap: onTap,
    iconSize: iconSize,
  );

  factory UsersItemList.basic({Key? key, String? id, required UserInfoData data}) =>
      UsersItemList._(key: key, id: id, variant: UserItemListVariant.basic, data: data);

  factory UsersItemList.join({
    Key? key,
    String? id,
    required UserInfoData data,
    required void Function(String?)? onTap,
    double? iconSize,
  }) => UsersItemList._(
    key: key,
    id: id,
    variant: UserItemListVariant.join,
    data: data,
    onTap: onTap,
    iconSize: iconSize,
  );

  factory UsersItemList.waiting({
    Key? key,
    String? id,
    required UserInfoData data,
    void Function(String?)? onTap,
  }) => UsersItemList._(
    key: key,
    id: id,
    variant: UserItemListVariant.waiting,
    data: data,
    onTap: onTap,
  );

  factory UsersItemList.pendingMember({
    Key? key,
    String? id,
    required UserInfoData data,
    required void Function(String?)? onTapButton1,
    required void Function(String?)? onTapButton2,
    required String? buttonLabel1,
    required String? buttonLabel2,
  }) => UsersItemList._(
    key: key,
    id: id,
    variant: UserItemListVariant.pendingMember,
    data: data,
    onTapButton1: onTapButton1,
    onTapButton2: onTapButton2,
    buttonLabel1: buttonLabel1,
    buttonLabel2: buttonLabel2,
  );

  factory UsersItemList.existingAlias({Key? key, String? id, required UserInfoData data}) =>
      UsersItemList._(key: key, id: id, variant: UserItemListVariant.existingAlias, data: data);

  factory UsersItemList.textfield({
    Key? key,
    required String? id,
    required String label,
    required TextEditingController textController,
    required void Function(String?)? onTap,
    void Function(String?, String?)? textOnChanged,
    FocusNode? focusNode,
    bool autofocusOnEmpty = true,
  }) => UsersItemList._(
    key: key ?? ValueKey(id),
    id: id,
    variant: UserItemListVariant.textfield,
    label: label,
    textController: textController,
    onTap: onTap,
    textOnChanged: textOnChanged,
    textFocusNode: focusNode,
    autofocusOnEmpty: autofocusOnEmpty,
  );

  factory UsersItemList.button({
    Key? key,
    required void Function(String?)? onTap,
    required String label,
    required DotsIconData icon,
  }) => UsersItemList._(
    key: key,
    variant: UserItemListVariant.button,
    onTap: onTap,
    label: label,
    icon: icon,
  );

  @override
  Widget build(BuildContext context) {
    final String tapValue = id ?? '';

    final content = Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: _UserListRow(
        variant: variant,
        id: id,
        data: data,
        icon: icon,
        label: label,
        textController: textController,
        textOnChanged: textOnChanged,
        textFocusNode: textFocusNode,
        onTap: onTap,
        tapValue: tapValue,
        iconSize: iconSize,
        autofocusOnEmpty: autofocusOnEmpty,
        onTapButton1: onTapButton1,
        onTapButton2: onTapButton2,
        buttonLabel1: buttonLabel1,
        buttonLabel2: buttonLabel2,
      ),
    );

    if (variant == UserItemListVariant.textfield) {
      return content;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap?.call(tapValue),
      child: content,
    );
  }
}

class _UserListRow extends StatelessWidget {
  const _UserListRow({
    required this.variant,
    required this.id,
    required this.data,
    required this.icon,
    this.label,
    this.textController,
    this.textOnChanged,
    this.textFocusNode,
    required this.onTap,
    required this.tapValue,
    this.iconSize,
    this.autofocusOnEmpty = true,
    this.onTapButton1,
    this.onTapButton2,
    this.buttonLabel1,
    this.buttonLabel2,
  });

  final UserItemListVariant variant;
  final String? id;
  final UserInfoData? data;
  final DotsIconData? icon;
  final String? label;
  final TextEditingController? textController;
  final void Function(String? p1, String? p2)? textOnChanged;
  final FocusNode? textFocusNode;
  final void Function(String? p1)? onTap;
  final String? tapValue;
  final double? iconSize;
  final bool autofocusOnEmpty;
  final void Function(String?)? onTapButton1;
  final void Function(String?)? onTapButton2;
  final String? buttonLabel1;
  final String? buttonLabel2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8,
      children: [
        _MainWidget(
          variant: variant,
          id: id,
          data: data,
          icon: icon,
          label: label,
          textController: textController,
          textOnChanged: textOnChanged,
          textFocusNode: textFocusNode,
          autofocusOnEmpty: autofocusOnEmpty,
        ),
        _TrailingWidget(
          variant: variant,
          onTap: onTap,
          tapValue: tapValue,
          label: label,
          iconSize: iconSize,
          onTapButton1: onTapButton1,
          onTapButton2: onTapButton2,
          buttonLabel1: buttonLabel1,
          buttonLabel2: buttonLabel2,
        ),
      ],
    );
  }
}

class _MainWidget extends StatelessWidget {
  final UserItemListVariant variant;
  final String? id;
  final UserInfoData? data;
  final DotsIconData? icon;
  final String? label;
  final TextEditingController? textController;
  final void Function(String?, String?)? textOnChanged;
  final FocusNode? textFocusNode;
  final bool autofocusOnEmpty;

  const _MainWidget({
    required this.variant,
    this.id,
    this.data,
    this.icon,
    this.label,
    this.textController,
    this.textOnChanged,
    this.textFocusNode,
    this.autofocusOnEmpty = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    switch (variant) {
      case UserItemListVariant.main:
      case UserItemListVariant.label:
      case UserItemListVariant.pending:
      case UserItemListVariant.join:
      case UserItemListVariant.waiting:
      case UserItemListVariant.basic:
      case UserItemListVariant.existingAlias:
      case UserItemListVariant.pendingMember:
        return UserInfo(
          data: data!,
          size: variant.isWaiting || variant.isPendingMember
              ? UserInfoSize.large
              : UserInfoSize.small,
        );

      case UserItemListVariant.textfield:
        return Expanded(
          child: SizedBox(
            height: 30,
            child: Center(
              child: TextField(
                controller: textController!,
                focusNode: textFocusNode,
                autofocus: autofocusOnEmpty ? textController!.text.isEmpty : false,
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
                style: theme.typo.main.bodyDefaultMedium.copyWith(color: theme.colors.textPrimary),
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                cursorColor: theme.colors.labelHighlight,
                onChanged: (value) => textOnChanged?.call(id, value),
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
                DotsIcon(iconData: icon!, size: 16, color: theme.colors.labelHighlight),
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
  final double? iconSize;
  final void Function(String?)? onTapButton1;
  final void Function(String?)? onTapButton2;
  final String? buttonLabel1;
  final String? buttonLabel2;

  const _TrailingWidget({
    required this.variant,
    this.onTap,
    this.tapValue,
    this.label,
    this.iconSize,
    this.onTapButton1,
    this.onTapButton2,
    this.buttonLabel1,
    this.buttonLabel2,
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

      case UserItemListVariant.pending:
      case UserItemListVariant.join:
        return DotsIcon(
          iconData: variant == UserItemListVariant.join
              ? DotsIconData.chevronRight
              : DotsIconData.clockFilled,
          size: iconSize ?? (variant == UserItemListVariant.join ? 14 : 16),
          color: theme.colors.textSecondary,
        );

      case UserItemListVariant.label:
        return Text(
          label!,
          style: theme.typo.main.labelSmallMedium.copyWith(color: theme.colors.labelActive),
        );

      case UserItemListVariant.pendingMember:
        return Row(
          spacing: 4,
          children: [
            DotsMainButton(
              onTap: () => onTapButton1?.call(tapValue),
              content: buttonLabel1!,
              size: DotsMainButtonSize.small,
              variant: DotsMainButtonVariant.main,
            ),
            DotsMainButton(
              onTap: () => onTapButton2?.call(tapValue),
              content: buttonLabel2!,
              size: DotsMainButtonSize.small,
              variant: DotsMainButtonVariant.secondary,
            ),
          ],
        );

      case UserItemListVariant.button:
      case UserItemListVariant.waiting:
      case UserItemListVariant.basic:
      case UserItemListVariant.existingAlias:
        return Offstage();
    }
  }
}
