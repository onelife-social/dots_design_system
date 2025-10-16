import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BtnFolder extends StatelessWidget {
  // The icon to display in the button.
  final DotsIconData icon;

  // The text to display in the button when selected.
  final String? text;

  // Callback function when the button is clicked.
  final VoidCallback? onTap;

  // Callback function when the button is pressed.
  final VoidCallback? onLongPress;

  // Variable to determine if the button is selected.
  final bool isSelected;

  // Variable to determine if the button is a search button.
  final bool isSearchBtn;

  // The color of the icon when the button is selected.
  final Color iconSelectedColor;

  // Variable to determine if the edit icon should be shown.
  final bool showEditIcon;

  //Variable to determine if the field is editable.
  final bool isEditable;

  const BtnFolder({
    super.key,
    required this.icon,
    this.text,
    required this.onTap,
    required this.onLongPress,
    this.isSelected = false,
    this.isSearchBtn = false,
    required this.iconSelectedColor,
    this.showEditIcon = false,
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: _FolderButton(
              isSelected: isSelected,
              isSearchBtn: isSearchBtn,
              onTap: onTap,
              onLongPress: onLongPress,
              icon: icon,
              iconSelectedColor: iconSelectedColor,
              text: text,
            ),
          ),
        ),
        if (showEditIcon && isEditable)
          Positioned(
            right: 0,
            top: 0,
            child: _EditIcon(onPressed: onLongPress),
          ),
      ],
    );
  }
}

class _FolderButton extends StatelessWidget {
  final bool isSelected;
  final bool isSearchBtn;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final DotsIconData icon;
  final Color iconSelectedColor;
  final String? text;

  const _FolderButton({
    this.isSelected = false,
    this.isSearchBtn = false,
    required this.onTap,
    required this.onLongPress,
    required this.icon,
    required this.iconSelectedColor,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          height: 44,
          margin: const EdgeInsets.only(bottom: 6),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: isSelected
              ? BoxDecoration(
                  color: theme.colors.bgStrong,
                  borderRadius: DotsBorderRadius.r1000,
                  boxShadow: [
                      BoxShadow(
                        color: theme.colors.shadowPrimary,
                        blurRadius: 4,
                        offset: const Offset(1, 4),
                      ),
                    ])
              : BoxDecoration(
                  color: theme.colors.bgContainerSecondaryOnBackground,
                  borderRadius: DotsBorderRadius.r1000,
                ),
          child: isSearchBtn
              ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: DotsIcon(
                    iconData: icon,
                    size: 20,
                    color: theme.colors.textQuarternary,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    DotsIcon(
                      iconData: icon,
                      size: 20,
                      color: isSelected
                          ? iconSelectedColor
                          : theme.colors.textQuarternary,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Flexible(
                      child: text != null
                          ? Text(
                              text!.length > 20 ? '${text!.substring(0, 20)}…' : text!,
                              style: theme.typo.main.bodyDefaultMedium.copyWith(
                                color: isSelected
                                    ? theme.colors.textPrimary
                                    : theme.colors.textQuarternary,
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                )
        ),
      ),
    );
  }
}

class _EditIcon extends StatelessWidget {
  final VoidCallback? onPressed;

  const _EditIcon({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: theme.colors.bgChip,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: DotsIcon(
            iconData: DotsIconData.pencil,
            size: 10,
            color: theme.colors.labelAlwaysWhite,
          ),
        ),
      ),
    );
  }
}

class BtnFolderData {
  final DotsIconData icon;
  final String? text;
  final VoidCallback? onTap;
  final VoidCallback? onPressed;
  final bool isSelected;
  final Color iconSelectedColor;
  final bool isEditable;

  const BtnFolderData({
    required this.icon,
    this.text,
    this.onTap,
    this.onPressed,
    this.isSelected = false,
    required this.iconSelectedColor,
    this.isEditable = false,
  });
}

class DefaultFolderWidget {
  final int index;
  final Widget widget;

  const DefaultFolderWidget({
    required this.index,
    required this.widget,
  });
}
