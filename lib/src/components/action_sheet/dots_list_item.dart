import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsListItem extends StatelessWidget {
  final Widget icon;
  final String text;
  final bool? isGroupBlocked;
  final Function()? onTap;

  const DotsListItem({
    super.key,
    required this.icon,
    required this.text,
    this.isGroupBlocked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final groupName = Text(text, style: theme.typo.main.bodyLargeBold);
    final fullGroupName = isGroupBlocked == true
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              groupName,
              const SizedBox(width: 4),
              DotsIcon(
                iconData: DotsIconData.lock,
                color: context.dotsTheme.colors.textSecondary,
                size: 14,
              ),
            ],
          )
        : groupName;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          spacing: 12,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.colors.bgBaseContrast,
                borderRadius: DotsBorderRadius.r12,
              ),
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: DotsBorderRadius.r12,
                child: icon,
              ),
            ),
            Expanded(child: fullGroupName),
          ],
        ),
      ),
    );
  }
}
