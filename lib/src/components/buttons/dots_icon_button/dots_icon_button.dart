import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

import 'dots_icon_button_theme.dart';

class DotsIconButton extends StatelessWidget {
  const DotsIconButton({
    super.key,
    required this.icon,
    this.iconSize,
    this.label,
    this.tag,
    this.size = DotsIconButtonSize.large,
    this.variant = DotsIconButtonVariant.solid,
    this.style = DotsIconButtonStyle.defaultStyle,
    this.state = DotsIconButtonState.defaultState,
    this.direction = DotsIconButtonDirection.column,
    this.labelStyle,
    this.onTap,
    this.color,
    this.backgroundColor,
    this.textTappable = false,
    this.shouldApplyBlur = true,
    this.overflow,
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

  /// The size of the icon within the button.
  ///
  /// Defaults to the size of the button.
  final double? iconSize;

  /// The visual variant of the button.
  ///
  /// Defaults to [DotsIconButtonVariant.solid].
  @Deprecated('Use DotsIconButtonStyle and DotsIconButtonState instead')
  final DotsIconButtonVariant variant;

  /// The style of the button.
  ///
  /// Defaults to [DotsIconButtonStyle.defaultStyle].
  final DotsIconButtonStyle style;

  /// The state of the button.
  ///
  /// Defaults to [DotsIconButtonState.defaultState].
  final DotsIconButtonState state;

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
  final Color? color;

  /// Optional background color for the button.
  ///
  /// If not provided, the button will use the default background color from the theme.
  final Color? backgroundColor;

  /// Whether the text label is tappable.
  final bool textTappable;

  /// Whether the button should apply the blur effect.
  final bool shouldApplyBlur;

  /// The overflow behavior for the label text.
  final TextOverflow? overflow;

  bool get isStyleAndStateDefault =>
      style == DotsIconButtonStyle.defaultStyle && state == DotsIconButtonState.defaultState;

  bool get isVariantDefault => variant == DotsIconButtonVariant.solid;

  bool get useVariantInsteadOfStyleAndState => isStyleAndStateDefault && !isVariantDefault;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final buttonTheme = useVariantInsteadOfStyleAndState
        ? getIconButtonThemeByVariant(theme, variant)
        : getIconButtonThemeByStyleAndState(theme, style, state);
    final borderRadius = BorderRadius.circular(size.size);

    final widget = InkWell(
      onTap: onTap,
      focusColor: null,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: direction == DotsIconButtonDirection.column
          ? Column(
              mainAxisSize: MainAxisSize.min,
              spacing: size.spacing,
              children: [..._getChildren(buttonTheme, borderRadius, context)],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: style.isNoBackground ? 4 : 8,
              children: [..._getChildren(buttonTheme, borderRadius, context)],
            ),
    );

    if (textTappable && label != null) {
      return GestureDetector(onTap: onTap, child: widget);
    }
    return widget;
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
        iconSize: iconSize ?? size.iconSize,
        size: size,
        buttonTheme: buttonTheme,
        borderRadius: borderRadius,
        onTap: onTap,
        tag: tag,
        color: color,
        backgroundColor: backgroundColor,
        noButtonSize: style.isNoBackground,
        shouldApplyBlur: shouldApplyBlur,
      ),
      if (label != null)
        _Label(
          label: label,
          style:
              labelStyle ??
              theme.typo.main.labelDefaultRegular.copyWith(color: color ?? buttonTheme.labelColor),
          overflow: overflow,
        ),
    ];
  }
}

class _IconButton extends StatelessWidget {
  final DotsIconData icon;
  final double? iconSize;
  final DotsIconButtonSize size;
  final DotsIconButtonTheme buttonTheme;
  final BorderRadius borderRadius;
  final Function()? onTap;
  final String? tag;
  final bool noButtonSize;
  final dynamic color;
  final dynamic backgroundColor;
  final bool shouldApplyBlur;

  const _IconButton({
    required this.icon,
    required this.size,
    this.iconSize,
    required this.buttonTheme,
    required this.borderRadius,
    required this.onTap,
    required this.tag,
    required this.color,
    required this.noButtonSize,
    required this.backgroundColor,
    required this.shouldApplyBlur,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = DotsIcon(
      iconData: icon,
      size: iconSize ?? size.iconSize,
      color: color ?? buttonTheme.foregroundColor,
    );

    final widget = Center(
      child: tag != null ? BadgeTag(tag: tag!, child: iconWidget) : iconWidget,
    );

    if (noButtonSize) {
      return widget;
    }

    if (!shouldApplyBlur) {
      return SizedBox(
        height: noButtonSize ? null : size.size,
        width: noButtonSize ? null : size.size,
        child: DotsDecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor ?? buttonTheme.backgroundColor ?? Colors.transparent,
            borderRadius: borderRadius,
            border: buttonTheme.borderColor != null
                ? Border.all(color: buttonTheme.borderColor ?? Colors.transparent, width: 0.7)
                : null,
          ),
          child: widget,
        ),
      );
    }

    return SizedBox(
      height: noButtonSize ? null : size.size,
      width: noButtonSize ? null : size.size,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: DotsDecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor ?? buttonTheme.backgroundColor ?? Colors.transparent,
              borderRadius: borderRadius,
              border: buttonTheme.borderColor != null
                  ? Border.all(color: buttonTheme.borderColor ?? Colors.transparent, width: 0.7)
                  : null,
            ),
            child: widget,
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String? label;
  final TextStyle? style;
  final TextOverflow? overflow;

  const _Label({required this.label, required this.style, required this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(label ?? '', style: style, overflow: overflow);
  }
}
