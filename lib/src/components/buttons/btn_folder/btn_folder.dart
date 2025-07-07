import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BtnFolder extends StatelessWidget {
  final DotsIconData icon;
  final String text;
  final VoidCallback? onPressed;
  final bool isSelected;
  final Color iconSelectedColor;

  const BtnFolder({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    required this.iconSelectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
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
                label: Text(
                  text,
                  style: context.dotsTheme.typo.main.bodyDefaultMedium,
                ),
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
