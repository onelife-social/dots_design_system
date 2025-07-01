import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

import 'dots_icon_button_theme.dart';

class DotsIconButton extends StatelessWidget {
  const DotsIconButton({
    super.key,
    required this.icon,
    this.label,
    this.tag,
    this.size = DotsIconButtonSize.large,
    this.variant = DotsIconButtonVariant.solid,
    this.direction = DotsIconButtonDirection.column,
    this.labelStyle,
    this.onTap,
    this.color,
  });

  /// The icon to display on the button.
  final DotsIconData icon;

  /// Additional label to display on the button.
  ///
  /// If not provided, no label will be displayed.
  final String? label;

  /// Optional notification badge text.
  final String? tag;

  /// The size of the button.
  ///
  /// Defaults to [DotsIconButtonSize.large].
  final DotsIconButtonSize size;

  /// The visual variant of the button.
  ///
  /// Defaults to [DotsIconButtonVariant.solid].
  final DotsIconButtonVariant variant;

  /// The direction of the button.
  ///
  /// Defaults to [DotsIconButtonDirection.column].
  final DotsIconButtonDirection direction;

  /// Callback when the button is tapped.
  final Function()? onTap;

  /// Optional label style.
  ///
  /// If not provided, the default label style will be used.
  final TextStyle? labelStyle;

  /// Optional color for the icon.
  ///
  /// If not provided, the icon will use the default color from the theme.
  final dynamic color;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final buttonTheme = getIconButtonThemeByVariant(theme, variant);
    final borderRadius = BorderRadius.circular(size.size);

    return direction == DotsIconButtonDirection.column
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ..._getChildren(buttonTheme, borderRadius, context),
            ],
          )
        : Row(
            spacing: 8,
            children: [
              ..._getChildren(buttonTheme, borderRadius, context),
            ],
          );
  }

  List<Widget> _getChildren(
    DotsIconButtonTheme buttonTheme,
    BorderRadius borderRadius,
    BuildContext context,
  ) {
    final theme = context.dotsTheme;

    return [
      _IconButton(
        icon: icon,
        size: size,
        buttonTheme: buttonTheme,
        borderRadius: borderRadius,
        onTap: onTap,
        tag: tag,
        color: color,
      ),
      if (label != null)
        _Label(
          label: label,
          style: labelStyle ?? theme.typo.main.labelDefaultRegular,
        )
    ];
  }
}

class _IconButton extends StatelessWidget {
  final DotsIconData icon;
  final DotsIconButtonSize size;
  final DotsIconButtonTheme buttonTheme;
  final BorderRadius borderRadius;
  final Function()? onTap;
  final String? tag;
  final dynamic color;

  const _IconButton({
    required this.icon,
    required this.size,
    required this.buttonTheme,
    required this.borderRadius,
    required this.onTap,
    required this.tag,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            child: Center(
              child: tag != null
                  ? DotsIconTag(
                      tag: tag!,
                      child: DotsIcon(
                        iconData: icon,
                        size: size.iconSize,
                        color: color ?? buttonTheme.foregroundColor,
                      ),
                    )
                  : DotsIcon(
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

class _Label extends StatelessWidget {
  final String? label;
  final TextStyle? style;

  const _Label({
    required this.label,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label ?? '',
      style: style,
    );
  }
}
