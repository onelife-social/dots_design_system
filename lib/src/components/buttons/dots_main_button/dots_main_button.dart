import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

import 'dots_main_button_enums.dart';
import 'dots_main_button_theme.dart';

class DotsMainButton extends StatelessWidget {
  const DotsMainButton({
    super.key,
    required this.content,
    this.icon,
    this.details,
    this.size = DotsMainButtonSize.large,
    this.variant = DotsMainButtonVariant.main,
    this.enabled = true,
    this.onTap,
  });

  final String content;
  final DotsIconData? icon;
  final String? details;

  final DotsMainButtonSize size;
  final DotsMainButtonVariant variant;
  final bool enabled;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final buttonTheme = getButtonThemeByButtonVariant(
      theme,
      enabled ? variant : DotsMainButtonVariant.disabled,
    );
    final borderRadius = BorderRadius.circular(size.height);

    return Material(
      color: buttonTheme.backgroundColor,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(borderRadius: borderRadius),
          height: size.height,
          padding: size.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: size.spacing,
            children: [
              if (icon != null)
                DotsIcon(
                  iconData: icon ?? DotsIconData.values.first,
                  size: 20,
                  color: buttonTheme.foregroundColor,
                ),
              Text(
                content,
                style: theme.typo.main.bodyDefaultMedium.copyWith(
                  color: buttonTheme.foregroundColor,
                ),
              ),
              if (details != null)
                Text(
                  details ?? '',
                  style: theme.typo.main.bodyDefaultMedium.copyWith(
                    color: buttonTheme.foregroundSecondaryColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
