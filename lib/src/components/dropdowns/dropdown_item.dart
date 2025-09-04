import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DropdownItem extends StatelessWidget {
  //Dropdown item text.
  final String text;

  //Dropdown item icon.
  final DotsIconData? icon;

  //Dropdown onTap item.
  final VoidCallback onTap;

  // Optional color override for text and icon.
  final Color? itemColor;

  const DropdownItem({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.itemColor,
  });

  @override
  Widget build(BuildContext context) {
    final DotsTheme theme = context.dotsTheme;
    final Color color = itemColor ?? theme.colors.textPrimary;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 234,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                text,
                style: theme.typo.main.bodyDefaultMedium.copyWith(
                  color: color,
                ),
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 6),
              DotsIcon(
                iconData: icon!,
                size: 16,
                color: color,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
