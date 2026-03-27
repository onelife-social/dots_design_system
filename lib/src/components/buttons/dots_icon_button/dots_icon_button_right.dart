import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsIconButtonRightVariant {
  primaryActive,
  primaryDisabled,
  secondaryActive,
  secondaryDisabled;

  bool get isDisabled => this == primaryDisabled || this == secondaryDisabled;
}

class DotsIconButtonRight extends StatelessWidget {
  /// The state of the button.
  final DotsIconButtonRightVariant variant;

  /// The text label to display.
  final String label;

  /// The icon to display.
  final DotsIconData icon;

  /// The padding of the button.
  final double padding;

  /// Callback when the button is tapped.
  final VoidCallback? onTap;

  const DotsIconButtonRight({
    super.key,
    this.variant = DotsIconButtonRightVariant.primaryActive,
    required this.label,
    required this.icon,
    required this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = switch (variant) {
      DotsIconButtonRightVariant.primaryActive => context.dotsTheme.colors.labelHighlight,
      DotsIconButtonRightVariant.primaryDisabled => context.dotsTheme.colors.textDisabled,
      DotsIconButtonRightVariant.secondaryActive => context.dotsTheme.colors.textSecondary,
      DotsIconButtonRightVariant.secondaryDisabled => context.dotsTheme.colors.textDisabled,
    };

    return GestureDetector(
      onTap: variant.isDisabled ? null : onTap,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Text(
              label,
              style: context.dotsTheme.typo.main.bodyDefaultMedium.copyWith(color: color),
            ),
            DotsIcon(
              iconData: icon,
              size: 16,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
