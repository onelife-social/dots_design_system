import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

import 'dots_close_button_theme.dart';

class DotsCloseButton extends StatelessWidget {
  const DotsCloseButton({
    super.key,
    this.icon = DotsIconData.cross,
    this.size = DotsCloseButtonSize.large,
    this.variant = DotsCloseButtonVariant.softContrast,
    this.onTap,
    this.color,
    this.addBlur = true,
  });

  /// The icon to display on the button.
  final DotsIconData icon;

  /// The size of the button.
  ///
  /// Defaults to [DotsCloseButtonSize.large].
  final DotsCloseButtonSize size;

  /// The visual variant of the button.
  ///
  /// Defaults to [DotsCloseButtonVariant.solid].
  final DotsCloseButtonVariant variant;

  /// Callback when the button is tapped.
  final Function()? onTap;

  /// Optional color for the icon.
  ///
  /// If not provided, the icon will use the default color from the theme.
  final dynamic color;

  /// Whether to apply a blur effect to the button background.
  final bool addBlur;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final buttonTheme = getCloseButtonThemeByVariant(theme, variant);
    final borderRadius = BorderRadius.circular(size.size);

    return DotsDecoratedBox(
      styleType: addBlur ? theme.styles.bgBlur : null,
      decoration: BoxDecoration(
        color: buttonTheme.backgroundColor ?? Colors.transparent,
        borderRadius: borderRadius,
      ),
      child: SizedBox(
        height: size.size,
        width: size.size,
        child: Material(
          color: buttonTheme.backgroundColor ?? Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: Center(
              child: DotsIcon(
                iconData: icon,
                size: size.iconSize,
                color: color ?? buttonTheme.foregroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
