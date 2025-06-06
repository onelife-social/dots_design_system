import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

import 'dots_icon_button_theme.dart';

class DotsIconButton extends StatelessWidget {
  const DotsIconButton({
    super.key,
    required this.icon,
    this.label,
    this.size = DotsIconButtonSize.large,
    this.variant = DotsIconButtonVariant.solid,
    this.onTap,
  });

  /// The icon to display on the button.
  final DotsIconData icon;

  /// Additional label to display on the button.
  ///
  /// If not provided, no label will be displayed.
  final String? label;

  /// The size of the button.
  ///
  /// Defaults to [DotsIconButtonSize.large].
  final DotsIconButtonSize size;

  /// The visual variant of the button.
  ///
  /// Defaults to [DotsIconButtonVariant.solid].
  final DotsIconButtonVariant variant;

  /// Callback when the button is tapped.
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final buttonTheme = getIconButtonThemeByVariant(
      theme,
      variant,
    );
    final borderRadius = BorderRadius.circular(size.size);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: size.size,
          width: size.size,
          child: Material(
            color: buttonTheme.backgroundColor ?? Colors.transparent,
            borderRadius: borderRadius,
            child: InkWell(
              onTap: onTap,
              borderRadius: borderRadius,
              child: Container(
                decoration: BoxDecoration(borderRadius: borderRadius),
                height: size.size,
                width: size.size,
                child: Center(
                  child: DotsIcon(
                    iconData: icon,
                    size: size.iconSize,
                    color: buttonTheme.foregroundColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (label != null)
          Text(
            label ?? '',
            style: theme.typo.main.labelDefaultRegular,
          )
      ],
    );
  }
}
