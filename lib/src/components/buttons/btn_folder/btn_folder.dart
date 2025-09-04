import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BtnFolder extends StatelessWidget {
  // The icon to display in the button.
  final DotsIconData icon;

  // The text to display in the button when selected.
  final String? text;

  // Callback function when the button is pressed.
  final VoidCallback? onPressed;

  // Variable to determine if the button is selected.
  final bool isSelected;

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
    required this.onPressed,
    this.isSelected = false,
    required this.iconSelectedColor,
    this.showEditIcon = false,
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _FolderButton(
            isSelected: isSelected,
            onPressed: onPressed,
            icon: icon,
            iconSelectedColor: iconSelectedColor,
            text: text,
          ),
          if (showEditIcon && isEditable)
            Positioned(
              right: -5,
              top: -5,
              child: _EditIcon(onPressed: onPressed),
            ),
        ],
      ),
    );
  }
}

class _FolderButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onPressed;
  final DotsIconData icon;
  final Color iconSelectedColor;
  final String? text;

  const _FolderButton({
    this.isSelected = false,
    required this.onPressed,
    required this.icon,
    required this.iconSelectedColor,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    if (!isSelected) {
      return SizedBox(
        width: 42,
        height: 42,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 11),
            backgroundColor: context.dotsTheme.colors.bgContainerSecondaryOnBackground,
            elevation: 0,
          ),
          child: DotsIcon(
            iconData: icon,
            size: 20,
            color: context.dotsTheme.colors.textQuarternary,
          ),
        ),
      );
    }
    return SizedBox(
      height: 42,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        label: text != null
            ? Text(
                text!.length > 20 ? '${text!.substring(0, 20)}…' : text!,
                style: context.dotsTheme.typo.main.bodyDefaultMedium,
              )
            : SizedBox.shrink(),
        icon: DotsIcon(
          iconData: icon,
          size: 20,
          color: iconSelectedColor,
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: context.dotsTheme.colors.bgStrong,
          elevation: 0,
          side: BorderSide(
            color: Colors.black.dotsWithOpacity(0.08),
            width: 1,
          ),
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
    return GestureDetector(
      onTap: () => onPressed,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: context.dotsTheme.colors.bgChip,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: DotsIcon(
            iconData: DotsIconData.pencil,
            size: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class BtnFolderData {
  final DotsIconData icon;
  final String? text;
  final VoidCallback? onPressed;
  final bool isSelected;
  final Color iconSelectedColor;
  final bool isEditable;

  const BtnFolderData({
    required this.icon,
    this.text,
    this.onPressed,
    this.isSelected = false,
    required this.iconSelectedColor,
    this.isEditable = false,
  });
}

class CustomFolderWidget {
  final int index;
  final Widget widget;

  const CustomFolderWidget({
    required this.index,
    required this.widget,
  });
}
