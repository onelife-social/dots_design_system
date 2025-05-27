import 'package:dots_design_system/buttons/dots_button_theme.dart';
import 'package:dots_design_system/theme/dots_theme.dart';
import 'package:flutter/material.dart';

import 'dots_button_enums.dart';

class DotsButton extends StatelessWidget {
  const DotsButton({
    super.key,
    required this.content,
    this.details,
    this.size = DotsButtonSize.large,
    this.variant = DotsButtonVariant.main,
    this.enabled = true,
    this.onTap,
  });

  //TODO add icon
  final String content;
  final String? details;

  final DotsButtonSize size;
  final DotsButtonVariant variant;
  final bool enabled;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final buttonTheme = getButtonThemeByButtonVariant(
      theme,
      enabled ? variant : DotsButtonVariant.disabled,
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
