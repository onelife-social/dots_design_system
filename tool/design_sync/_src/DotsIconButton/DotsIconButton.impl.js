// DotsIconButton — port de lib/src/components/buttons/dots_icon_button/ (Dart = fuente de verdad)
__ds.DotsIconButton = (function () {
  'use strict';

  // DotsIconButtonSize: size × iconSize × spacing
  var SIZES = {
    enormous: { size: 56, iconSize: 32, spacing: 2 },
    extraLarge: { size: 52, iconSize: 32, spacing: 2 },
    large: { size: 44, iconSize: 24, spacing: 2 },
    medium: { size: 36, iconSize: 20, spacing: 2 },
    small: { size: 28, iconSize: 14, spacing: 2 },
    extraSmall: { size: 22, iconSize: 14, spacing: 0 },
  };

  // @deprecated DotsIconButtonVariant → [style, state] (getIconButtonThemeByVariant)
  var VARIANT_MAP = {
    solid: ['defaultStyle', 'defaultState'],
    photo: ['onPhoto', 'defaultState'],
    active: ['defaultStyle', 'active'],
    noBackground: ['noBackground', 'defaultState'],
    photoDisable: ['onPhoto', 'disabled'],
  };

  var STYLE_CLASS = { defaultStyle: 'default', onPhoto: 'photo', floating: 'floating', noBackground: 'nobg' };
  var STATE_CLASS = { defaultState: 'default', active: 'active', disabled: 'disabled', destructive: 'destructive' };

  // labelColor de DotsIconButtonTheme (dots_icon_button_theme.dart)
  function labelColor(style, state) {
    if (style === 'noBackground') {
      if (state === 'active') return 'var(--label-highlight)';
      if (state === 'disabled') return 'var(--text-disabled)';
      if (state === 'destructive') return 'var(--label-destructive)';
      return 'var(--text-primary)';
    }
    if (state === 'disabled' && (style === 'defaultStyle' || style === 'floating')) {
      return 'var(--text-disabled)';
    }
    return 'var(--text-primary)';
  }

  function DotsIconButton(props) {
    var sizeName = SIZES[props.size] ? props.size : 'large';
    var sz = SIZES[sizeName];
    var style = STYLE_CLASS[props.style] ? props.style : 'defaultStyle';
    var state = STATE_CLASS[props.state] ? props.state : 'defaultState';
    // Compat: variant deprecado solo cuando style/state son los defaults
    if (style === 'defaultStyle' && state === 'defaultState' && props.variant && props.variant !== 'solid' && VARIANT_MAP[props.variant]) {
      style = VARIANT_MAP[props.variant][0];
      state = VARIANT_MAP[props.variant][1];
    }
    var direction = props.direction === 'row' ? 'row' : 'column';
    var noBg = style === 'noBackground';
    var shouldApplyBlur = props.shouldApplyBlur !== false;
    var showShadow = !!props.showShadow && !noBg;
    var hasLabel = props.label != null && props.label !== '';
    var gap = hasLabel ? sz.spacing + (showShadow ? 4 : 0) : 0;
    var iconSize = props.iconSize || sz.iconSize;
    var textTappable = !!props.textTappable && hasLabel;

    var circleCls =
      'ds-icon-btn__circle ds-icon-btn__circle--' + sizeName +
      ' ds-icon-btn__circle--' + STYLE_CLASS[style] + '-' + STATE_CLASS[state] +
      (style === 'floating' ? ' ds-icon-btn__circle--floating' : '') +
      (noBg ? ' ds-icon-btn__circle--nobg' : '') +
      (!shouldApplyBlur ? ' is-no-blur' : '') +
      (showShadow ? ' has-shadow' : '');

    var circleStyle = {};
    if (props.backgroundColor) circleStyle.background = props.backgroundColor;
    if (props.color) circleStyle.color = props.color;

    var icon = h(__ds.DotsIcon, { name: props.icon, size: iconSize, color: props.color });
    var iconContent = props.tag != null
      ? h('span', { className: 'ds-icon-btn__tagwrap' }, icon, h('span', { className: 'ds-icon-btn__tag' }, props.tag))
      : icon;

    var circle = h('button', {
      type: 'button',
      className: circleCls,
      style: circleStyle,
      onClick: textTappable ? undefined : props.onClick,
    }, iconContent);

    var labelStyle = { color: props.color || labelColor(style, state) };
    if (direction === 'column' && !noBg) labelStyle.width = sz.size + 'px';
    var label = hasLabel
      ? h('span', {
          className: 'ds-icon-btn__label' + (props.overflow ? ' ds-icon-btn__label--ellipsis' : ''),
          style: labelStyle,
        }, props.label)
      : null;

    return h('span', {
      className: 'ds-icon-btn ds-icon-btn--' + direction,
      style: { gap: gap + 'px' },
      onClick: textTappable ? props.onClick : undefined,
    }, circle, label);
  }
  return DotsIconButton;
})();
