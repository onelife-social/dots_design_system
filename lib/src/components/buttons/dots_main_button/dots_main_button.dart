import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/components/common/dots_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:easy_debounce/easy_debounce.dart';


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
    this.textColor,
    this.iconColor,
    this.backgroundColor,
    this.shouldApplyBlur = false,
    this.iconPosition = DotsMainButtonIconPosition.left,
    this.splashColor,
    this.textStyle,
    this.highlightColor,
    this.isLoading = false,
    this.disabledVariant = DotsMainButtonVariant.disabled,
    this.useDebounce = false,
    this.debounceDuration = const Duration(milliseconds: 400),
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

  /// Optional text color to override the default one from the theme.
  final Color? textColor;

  /// Optional icon color to override the default one from the theme.
  final Color? iconColor;

  /// Optional background color to override the default one from the theme.
  final Color? backgroundColor;

  /// Optional text style to override the default one from the theme.
  final TextStyle? textStyle;

  /// Whether the button should apply the blur effect.
  final bool shouldApplyBlur;

  /// Position of the icon in the button.
  final DotsMainButtonIconPosition iconPosition;

  /// Optional splash color to override the default one.
  final Color? splashColor;

  /// Optional highlight color to override the default one.
  final Color? highlightColor;

  /// Whether the button is in loading state.
  final bool isLoading;

  /// The disabled variant of the button, used when [enabled] is false.
  final DotsMainButtonVariant disabledVariant;

  /// Whether to use debounce for the onTap callback.
  final bool useDebounce;

  /// The duration for the debounce when [useDebounce] is true.
  final Duration debounceDuration;

  void _handleTap() {
    if (onTap == null) return;

    if (useDebounce) {
      EasyDebounce.debounce(
        'dots_main_button_${content.hashCode}',
        debounceDuration,
        () => onTap!(),
      );
    } else {
      onTap!();
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final buttonTheme = getButtonThemeByButtonVariant(
      theme,
      enabled ? variant : disabledVariant,
      size,
      textColor,
      iconColor,
    );

    final borderRadius = BorderRadius.circular(size.height);
    final foregroundColor =
        textColor ??
        (buttonTheme.foregroundGradient == null ? buttonTheme.foregroundColor : Colors.white);

    final Widget iconWidget = icon != null
        ? DotsIcon(iconData: icon!, size: iconSize, color: buttonTheme.iconColor ?? foregroundColor)
        : const SizedBox.shrink();

    final Widget text = DotsShaderMask(
      styleType: buttonTheme.foregroundGradient,
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: size.spacing,
          children: [
            Text(
              content,
              overflow: TextOverflow.ellipsis,
              style: textStyle ?? size.getTextStyle(theme).copyWith(color: foregroundColor),
            ),
            if (details != null &&
                (size == DotsMainButtonSize.mainAction || size == DotsMainButtonSize.large))
              Text(
                details ?? '',
                overflow: TextOverflow.ellipsis,
                style: theme.typo.main.bodyDefaultMedium.copyWith(
                  color:
                      buttonTheme.foregroundSecondaryColor?.dotsWithOpacity(0.6) ??
                      foregroundColor?.dotsWithOpacity(0.6),
                ),
              ),
          ],
        ),
      ),
    );

    Widget button = Material(
      color: backgroundColor ?? buttonTheme.backgroundColor ?? Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        splashColor: splashColor,
        highlightColor: highlightColor,
        onTap: (enabled && !isLoading) ? _handleTap : null,
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(borderRadius: borderRadius),
          height: size.height,
          padding: adaptPaddingForText ? EdgeInsets.symmetric(horizontal: 7) : size.padding,
          child: isLoading
              ? Center(
                  child: GradientProgressIndicator(
                    radius: (size.height - 25) / 2,
                    duration: 1,
                    strokeWidth: 3.0,
                    gradientStops: const [0.0001, 1.0],
                    gradientColors: [
                      (foregroundColor ?? context.dotsTheme.colors.labelAlwaysWhite).withOpacity(0),
                      (foregroundColor ?? context.dotsTheme.colors.labelAlwaysWhite),
                    ],
                    child: const SizedBox.shrink(),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: size.spacing,
                  mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    if (iconPosition.isLeft) ...[iconWidget, text],
                    if (iconPosition.isRight) ...[text, iconWidget],
                  ],
                ),
        ),
      ),
    );
    if (buttonTheme.backgroundGradient != null && backgroundColor == null) {
      button = DotsDecoratedBox(
        styleType: buttonTheme.backgroundGradient,
        decoration: BoxDecoration(borderRadius: borderRadius),
        child: button,
      );
    }
    if (buttonTheme.blurStyle != null && shouldApplyBlur) {
      button = DotsDecoratedBox(
        styleType: buttonTheme.blurStyle,
        decoration: BoxDecoration(borderRadius: borderRadius),
        child: button,
      );
    }
    if (buttonTheme.shadow && shouldApplyBlur) {
      button = DotsDecoratedBox(
        styleType: theme.styles.defaultShadow,
        decoration: BoxDecoration(borderRadius: borderRadius),
        child: button,
      );
    }

    return button;
  }
}
