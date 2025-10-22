import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsFilterChip extends StatelessWidget {
  /// The label for the filter chip.
  final String? label;

  /// Callback when the close button chip is tapped.
  final void Function()? onTap;

  const DotsFilterChip({
    super.key,
    this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.colors.bgContainerSecondary,
          borderRadius: DotsBorderRadius.r22,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 6, top: 6, bottom: 6),
          child: Row(
            children: [
              Text(
                label ?? '',
                style: theme.typo.main.labelDefaultBold.copyWith(color: theme.colors.textSecondary),
              ),
              const SizedBox(width: 8),
              DotsCloseButton(
                icon: DotsIconData.cross,
                size: DotsCloseButtonSize.extraSmall,
                variant: DotsCloseButtonVariant.highContrast,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
