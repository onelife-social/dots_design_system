import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DropdownItem extends StatefulWidget {
  //Dropdown item text.
  final String text;

  //Dropdown item subtitle.
  final String? subtitle;

  //Dropdown item leading icon/widget.
  final Widget? leading;

  // Backwards-compatible trailing icon.
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
    this.subtitle,
    this.leading,
    this.icon,
    required this.onTap,
    this.itemColor,
    this.minSize = false,
  });

  String get resolvedSubtitle => subtitle ?? '';

  @override
  State<DropdownItem> createState() => _DropdownItemState();
}

class _DropdownItemState extends State<DropdownItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final DotsTheme theme = context.dotsTheme;
    final Color color = widget.itemColor ?? theme.colors.textPrimary;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        width: widget.minSize ? null : 234,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _isPressed ? theme.colors.bgContainerSecondary : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: widget.minSize ? MainAxisSize.min : MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.leading != null) ...[
              widget.leading!,
              const SizedBox(width: 6),
            ],
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: widget.text,
                      style: theme.typo.main.bodyDefaultMedium.copyWith(color: color),
                    ),
                    if (widget.resolvedSubtitle.isNotEmpty)
                      TextSpan(
                        text: ' ${widget.resolvedSubtitle}',
                        style: theme.typo.main.bodyDefaultRegular.copyWith(
                          color: theme.colors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (widget.icon != null) ...[
              const SizedBox(width: 6),
              DotsIcon(
                iconData: widget.icon!,
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
