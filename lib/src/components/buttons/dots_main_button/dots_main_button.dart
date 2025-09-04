import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/components/common/dots_shader_mask.dart';
import 'package:flutter/material.dart';

import 'dots_main_button_theme.dart';

class DotsMainButton extends StatelessWidget {
  const DotsMainButton({
    super.key,
    required this.content,
    this.icon,
    this.details,
    this.iconSize = 20,
    this.size = DotsMainButtonSize.large,
    this.variant = DotsMainButtonVariant.main,
    this.enabled = true,
    this.onTap,
    this.expand = true,
    this.adaptPaddingForText = false,
  });

  /// The text to display on the button.
  final String content;

  /// The icon to display on the button.
  ///
  /// If not provided, no icon will be displayed.
  final DotsIconData? icon;

  /// Additional details to display on the button.
  ///
  /// If not provided, no details will be displayed
  /// only show if [size] is [DotsMainButtonSize.mainAction] or [DotsMainButtonSize.large].
  final String? details;

  /// The size of the button.
  ///
  /// Defaults to [DotsMainButtonSize.large].
  final DotsMainButtonSize size;

  /// The size of the icon in the button.
  ///
  /// Defaults to 20.
  final double iconSize;

  /// The visual variant of the button.
  ///
  /// Defaults to [DotsMainButtonVariant.main].
  final DotsMainButtonVariant variant;

  /// Whether the button is enabled.
  final bool enabled;

  /// Callback when the button is tapped.
  final Function()? onTap;

  /// Whether the button should expand to fill available space.
  final bool expand;

  /// Whether to adapt padding based on text.
  final bool adaptPaddingForText;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final buttonTheme = getButtonThemeByButtonVariant(
        theme, enabled ? variant : DotsMainButtonVariant.disabled, size);
    final borderRadius = BorderRadius.circular(size.height);

    final foregroundColor =
        buttonTheme.foregroundGradient == null ? buttonTheme.foregroundColor : Colors.white;
    Widget button = Material(
      color: buttonTheme.backgroundColor ?? Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          height: size.height,
          padding: adaptPaddingForText ? EdgeInsets.symmetric(horizontal: 7) : size.padding,
          child: DotsShaderMask(
            styleType: buttonTheme.foregroundGradient,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: size.spacing,
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              children: [
                if (icon != null)
                  DotsIcon(
                    iconData: icon ?? DotsIconData.values.first,
                    size: iconSize,
                    color: foregroundColor,
                  ),
                Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  style: size.getTextStyle(theme).copyWith(
                        color: foregroundColor,
                      ),
                ),
                if (details != null &&
                    (size == DotsMainButtonSize.mainAction || size == DotsMainButtonSize.large))
                  Text(
                    details ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: theme.typo.main.bodyDefaultMedium.copyWith(
                      color: buttonTheme.foregroundSecondaryColor ?? foregroundColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    if (buttonTheme.backgroundGradient != null) {
      button = DotsDecoratedBox(
        styleType: buttonTheme.backgroundGradient,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: button,
      );
    }
    if (buttonTheme.blur) {
      button = DotsDecoratedBox(
        styleType: theme.styles.bgBlur,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: button,
      );
    }
    if (buttonTheme.shadow) {
      button = DotsDecoratedBox(
        styleType: theme.styles.defaultShadow,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: button,
      );
    }

    return button;
  }
}
