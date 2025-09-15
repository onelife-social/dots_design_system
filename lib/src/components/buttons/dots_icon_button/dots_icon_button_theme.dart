import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DotsIconButtonTheme {
  final Color? backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;

  final Color labelColor;
  final DotsStyleType? style;

  const DotsIconButtonTheme({
    this.backgroundColor,
    this.borderColor,
    required this.foregroundColor,
    required this.labelColor,
    this.style,
  });
}

@Deprecated('Use getIconButtonThemeByStyleAndState instead')
DotsIconButtonTheme getIconButtonThemeByVariant(
  DotsTheme theme,
  DotsIconButtonVariant variant,
) {
  switch (variant) {
    case DotsIconButtonVariant.solid:
      return getIconButtonThemeByStyleAndState(
          theme, DotsIconButtonStyle.defaultStyle, DotsIconButtonState.defaultState);
    case DotsIconButtonVariant.photo:
      return getIconButtonThemeByStyleAndState(
          theme, DotsIconButtonStyle.onPhoto, DotsIconButtonState.defaultState);
    case DotsIconButtonVariant.active:
      return getIconButtonThemeByStyleAndState(
          theme, DotsIconButtonStyle.defaultStyle, DotsIconButtonState.active);
    case DotsIconButtonVariant.noBackground:
      return getIconButtonThemeByStyleAndState(
          theme, DotsIconButtonStyle.noBackground, DotsIconButtonState.defaultState);
    case DotsIconButtonVariant.photoDisable:
      return getIconButtonThemeByStyleAndState(
          theme, DotsIconButtonStyle.onPhoto, DotsIconButtonState.disabled);
  }
}

DotsIconButtonTheme getIconButtonThemeByStyleAndState(
  DotsTheme theme,
  DotsIconButtonStyle style,
  DotsIconButtonState state,
) {
  switch (style) {
    case DotsIconButtonStyle.defaultStyle:
      switch (state) {
        case DotsIconButtonState.defaultState:
          return DotsIconButtonTheme(
            backgroundColor: theme.colors.bgContainerSecondaryOnBackground,
            foregroundColor: theme.colors.textPrimary,
            labelColor: theme.colors.textPrimary,
            style: theme.styles.blur50,
          );
        case DotsIconButtonState.active:
          return DotsIconButtonTheme(
            backgroundColor: theme.colors.labelHighlight,
            foregroundColor: theme.colors.labelAlwaysWhite,
            labelColor: theme.colors.textPrimary,
          );
        case DotsIconButtonState.disabled:
          return DotsIconButtonTheme(
            backgroundColor: theme.colors.bgBtnDisabled,
            foregroundColor: theme.colors.textDisabled,
            labelColor: theme.colors.textDisabled,
            style: theme.styles.blur50,
          );
        case DotsIconButtonState.destructive:
          return DotsIconButtonTheme(
            backgroundColor: theme.colors.bgDestructive,
            foregroundColor: theme.colors.labelDestructive,
            labelColor: theme.colors.textPrimary,
          );
      }
    case DotsIconButtonStyle.onPhoto:
      switch (state) {
        case DotsIconButtonState.defaultState:
        case DotsIconButtonState.active:
          return DotsIconButtonTheme(
            backgroundColor: theme.colors.bgFloatingBtn,
            foregroundColor: theme.colors.labelAlwaysWhite,
            labelColor: theme.colors.textPrimary,
            style: theme.styles.blur50,
          );
        case DotsIconButtonState.disabled:
          return DotsIconButtonTheme(
            backgroundColor: theme.colors.bgBtnDisabled,
            foregroundColor: theme.colors.labelAlwaysWhite,
            labelColor: theme.colors.textPrimary,
            style: theme.styles.blur50,
          );
        case DotsIconButtonState.destructive:
          return DotsIconButtonTheme(
            backgroundColor: theme.colors.bgDestructive,
            foregroundColor: theme.colors.labelDestructive,
            labelColor: theme.colors.textPrimary,
            style: theme.styles.blur50,
          );
      }
    case DotsIconButtonStyle.floating:
      switch (state) {
        case DotsIconButtonState.defaultState:
          return DotsIconButtonTheme(
            backgroundColor: theme.colors.bgBtnImage,
            foregroundColor: theme.colors.textPrimary,
            borderColor: theme.colors.borderAlert,
            labelColor: theme.colors.textPrimary,
            style: theme.styles.blur10,
          );
        case DotsIconButtonState.active:
          return DotsIconButtonTheme(
            backgroundColor: theme.colors.labelHighlight,
            foregroundColor: theme.colors.labelAlwaysWhite,
            borderColor: theme.colors.borderAlert,
            labelColor: theme.colors.textPrimary,
            style: theme.styles.blur10,
          );
        case DotsIconButtonState.disabled:
          return DotsIconButtonTheme(
            foregroundColor: theme.colors.bgBtnDisabled,
            borderColor: theme.colors.borderAlert,
            labelColor: theme.colors.textDisabled,
            style: theme.styles.blur10,
          );
        case DotsIconButtonState.destructive:
          return DotsIconButtonTheme(
            backgroundColor: theme.colors.bgDestructive,
            foregroundColor: theme.colors.labelDestructive,
            labelColor: theme.colors.textPrimary,
            style: theme.styles.blur10,
          );
      }
    case DotsIconButtonStyle.noBackground:
      switch (state) {
        case DotsIconButtonState.defaultState:
          return DotsIconButtonTheme(
            foregroundColor: theme.colors.textPrimary,
            labelColor: theme.colors.textPrimary,
          );
        case DotsIconButtonState.active:
          return DotsIconButtonTheme(
            foregroundColor: theme.colors.labelHighlight,
            labelColor: theme.colors.labelHighlight,
          );
        case DotsIconButtonState.disabled:
          return DotsIconButtonTheme(
            foregroundColor: theme.colors.textDisabled,
            labelColor: theme.colors.textDisabled,
          );
        case DotsIconButtonState.destructive:
          return DotsIconButtonTheme(
            foregroundColor: theme.colors.labelDestructive,
            labelColor: theme.colors.labelDestructive,
          );
      }
  }
}
