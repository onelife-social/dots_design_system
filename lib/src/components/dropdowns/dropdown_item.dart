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

  // If true, the item shrinks to fit its content instead of using fixed width.
  //
  // Defaults to `false`.
  final bool minSize;

  const DropdownItem({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.itemColor,
    this.minSize = false,
  });

  @override
  Widget build(BuildContext context) {
    final DotsTheme theme = context.dotsTheme;
    final Color color = itemColor ?? theme.colors.textPrimary;

    final textWidget = Text(
      text,
      style: theme.typo.main.bodyDefaultMedium.copyWith(
        color: color,
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: minSize ? null : 234,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: minSize ? MainAxisSize.min : MainAxisSize.max,
          children: [
            Expanded(child: textWidget),
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
