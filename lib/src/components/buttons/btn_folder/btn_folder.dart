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

  const BtnFolder({
    super.key,
    required this.icon,
    this.text,
    required this.onPressed,
    this.isSelected = false,
    required this.iconSelectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: !isSelected
          ? SizedBox(
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
            )
          : SizedBox(
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
                    color: Colors.black.withOpacity(0.08),
                    width: 1,
                  ),
                ),
              ),
            ),
    );
  }
}
