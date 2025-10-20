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

  /// *(Only for `text` variant)* Callback when the textfield changes.
  final void Function(String?, String?)? textOnChanged;

  /// *(Only for `text` variant)* Callback when the textfield loses focus.
  final void Function(String?)? textOnFocusLost;

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
    this.textOnFocusLost,
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
    required void Function(String?)? onTap,
    required void Function(String?, String?)? textOnChanged,
    required void Function(String?)? textOnFocusLost,
  }) =>
      UsersItemList._(
        key: key,
        id: id,
        variant: UserItemListVariant.textfield,
        label: label,
        textController: textController,
        onTap: onTap,
        textOnChanged: textOnChanged,
        textOnFocusLost: textOnFocusLost,
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
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap?.call(tapValue),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
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
              textOnFocusLost: textOnFocusLost,
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

class _MainWidget extends StatefulWidget {
  final UserItemListVariant variant;
  final String? id;
  final UserInfoData? data;
  final DotsIconData? icon;
  final String? label;
  final TextEditingController? textController;
  final void Function(String?, String?)? textOnChanged;
  final void Function(String?)? textOnFocusLost;

  const _MainWidget({
    required this.variant,
    this.id,
    this.data,
    this.icon,
    this.label,
    this.textController,
    this.textOnChanged,
    this.textOnFocusLost,
  });

  @override
  State<_MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<_MainWidget> {
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    if (widget.variant == UserItemListVariant.textfield) {
      _focusNode = FocusNode();
      _focusNode!.addListener(_handleFocusChange);
    }
  }

  void _handleFocusChange() {
    if (_focusNode!.hasFocus == false) {
      widget.textOnFocusLost?.call(widget.textController?.text);
    }
  }

  @override
  void dispose() {
    _focusNode?.removeListener(_handleFocusChange);
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    switch (widget.variant) {
      case UserItemListVariant.main:
      case UserItemListVariant.label:
        return UserInfo(data: widget.data!);

      case UserItemListVariant.textfield:
        return Expanded(
          child: SizedBox(
            height: 30,
            child: Center(
              child: TextField(
                controller: widget.textController!,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: widget.label!,
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                cursorColor: theme.colors.labelHighlight,
                onChanged: (value) => widget.textOnChanged?.call(widget.id , value),
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
                  iconData: widget.icon!,
                  size: 16,
                  color: theme.colors.labelHighlight,
                ),
                Text(
                  widget.label!,
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
