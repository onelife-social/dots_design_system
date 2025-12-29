import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

import 'dots_system_button_theme.dart';

class DotsSystemButton extends StatelessWidget {
  const DotsSystemButton({
    super.key,
    required this.content,
    this.icon,
    this.size = DotsSystemButtonSize.medium,
    this.variant = DotsSystemButtonVariant.active,
    this.onTap,
  });

  final String content;
  final DotsIconData? icon;
  final DotsSystemButtonSize size;
  final DotsSystemButtonVariant variant;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final buttonTheme = getSystemButtonThemeByVariant(
      theme,
      variant,
    );

    final borderRadius = DotsBorderRadius.r16;

    final Widget? iconWidget = icon == null ? null : DotsIcon(
      iconData: icon!,
      size: size.iconSize,
      color: buttonTheme.iconColor,
    );

    final Widget text = Text(
      content,
      overflow: TextOverflow.ellipsis,
      style: size
          .getTextStyle(theme)
          .copyWith(
            color: buttonTheme.textColor,
          ),
    );

    return Material(
      color: buttonTheme.backgroundColor,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(borderRadius: borderRadius),
          height: size.height,
          padding: size.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: size.spacing,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (iconWidget != null) iconWidget,
              text,
            ],
          ),
        ),
      ),
    );
  }
}
