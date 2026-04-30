import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotbookCalendarHeader extends StatelessWidget {
  //Text display month and year
  final String title;
  //Callbacks for when the title is tapped (e.g., to switch to year selection mode)
  final Function()? onTitleTap;
  //Callbacks for when the previous month button is tapped
  final Function()? onPreviousMonth;
  //Callbacks for when the next month button is tapped
  final Function()? onNextMonth;

  const DotbookCalendarHeader({
    super.key,
    required this.title,
    this.onTitleTap,
    this.onPreviousMonth,
    this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTitleTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: theme.typo.main.bodyLargeMedium.copyWith(
                        color: theme.colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  DotsIcon(
                    iconData: DotsIconData.chevronRight,
                    size: 12,
                    color: theme.colors.labelHighlight,
                  ),
                ],
              ),
            ),
          ),
        ),
        _DotbookCalendarHeaderButton(
          icon: DotsIconData.chevronLeft,
          onTap: onPreviousMonth,
        ),
        const SizedBox(width: 4),
        _DotbookCalendarHeaderButton(
          icon: DotsIconData.chevronRight,
          onTap: onNextMonth,
        ),
      ],
    );
  }
}

class _DotbookCalendarHeaderButton extends StatelessWidget {
  const _DotbookCalendarHeaderButton({
    required this.icon,
    this.onTap,
  });

  final DotsIconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final isEnabled = onTap != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: DotsIcon(
            iconData: icon,
            size: 18,
            color: isEnabled ? theme.colors.labelHighlight : theme.colors.textQuarternary,
          ),
        ),
      ),
    );
  }
}
