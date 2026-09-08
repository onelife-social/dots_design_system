// DotsIconButton — port of lib/src/components/buttons/dots_icon_button/ (Dart = source of truth).
import type { CSSProperties } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

export type DotsIconButtonSize = 'enormous' | 'extraLarge' | 'large' | 'medium' | 'small' | 'extraSmall';
export type DotsIconButtonStyle = 'defaultStyle' | 'onPhoto' | 'floating' | 'noBackground';
export type DotsIconButtonState = 'defaultState' | 'active' | 'disabled' | 'destructive';

export interface DotsIconButtonProps {
  /** DotsIcon name (real asset, e.g. 'ic-heart') */
  icon: string;
  /** Icon size in px — defaults to the size's own */
  iconSize?: number;
  /** Optional label below/next to the button */
  label?: string;
  /** Notification badge text (BadgeTag) */
  tag?: string;
  /** Dart enum DotsIconButtonSize (diameter 56/52/44/36/28/22) */
  size?: DotsIconButtonSize;
  /** @deprecated use style + state — Dart enum DotsIconButtonVariant */
  variant?: 'solid' | 'photo' | 'active' | 'noBackground' | 'photoDisable';
  /** Dart enum DotsIconButtonStyle */
  style?: DotsIconButtonStyle;
  /** Dart enum DotsIconButtonState */
  state?: DotsIconButtonState;
  /** Dart enum DotsIconButtonDirection — label placement */
  direction?: 'column' | 'row';
  /** Dart onTap */
  onClick?: () => void;
  /** CSS color forcing icon and label */
  color?: string;
  /** CSS color forcing the circle background */
  backgroundColor?: string;
  /** When true, the label also triggers onClick */
  textTappable?: boolean;
  /** Apply backdrop blur (default true) */
  shouldApplyBlur?: boolean;
  /** shadowFolder shadow around the circle */
  showShadow?: boolean;
  /** 'ellipsis' → 1 line with ellipsis; undefined → 2 lines */
  overflow?: 'ellipsis';
}

// DotsIconButtonSize: size × iconSize × spacing
const SIZES: Record<DotsIconButtonSize, { size: number; iconSize: number; spacing: number }> = {
  enormous: { size: 56, iconSize: 32, spacing: 2 },
  extraLarge: { size: 52, iconSize: 32, spacing: 2 },
  large: { size: 44, iconSize: 24, spacing: 2 },
  medium: { size: 36, iconSize: 20, spacing: 2 },
  small: { size: 28, iconSize: 14, spacing: 2 },
  extraSmall: { size: 22, iconSize: 14, spacing: 0 },
};

// @deprecated DotsIconButtonVariant → [style, state] (getIconButtonThemeByVariant)
const VARIANT_MAP: Record<NonNullable<DotsIconButtonProps['variant']>, [DotsIconButtonStyle, DotsIconButtonState]> = {
  solid: ['defaultStyle', 'defaultState'],
  photo: ['onPhoto', 'defaultState'],
  active: ['defaultStyle', 'active'],
  noBackground: ['noBackground', 'defaultState'],
  photoDisable: ['onPhoto', 'disabled'],
};

const STYLE_CLASS: Record<DotsIconButtonStyle, string> = { defaultStyle: 'default', onPhoto: 'photo', floating: 'floating', noBackground: 'nobg' };
const STATE_CLASS: Record<DotsIconButtonState, string> = { defaultState: 'default', active: 'active', disabled: 'disabled', destructive: 'destructive' };

// labelColor of DotsIconButtonTheme (dots_icon_button_theme.dart)
function labelColor(style: DotsIconButtonStyle, state: DotsIconButtonState) {
  if (style === 'noBackground') {
    if (state === 'active') return 'var(--label-highlight)';
    if (state === 'disabled') return 'var(--text-disabled)';
    if (state === 'destructive') return 'var(--label-destructive)';
    return 'var(--text-primary)';
  }
  if (state === 'disabled' && (style === 'defaultStyle' || style === 'floating')) return 'var(--text-disabled)';
  return 'var(--text-primary)';
}

export function DotsIconButton(props: DotsIconButtonProps) {
  const sizeName: DotsIconButtonSize = props.size && SIZES[props.size] ? props.size : 'large';
  const sz = SIZES[sizeName];
  let style: DotsIconButtonStyle = props.style && STYLE_CLASS[props.style] ? props.style : 'defaultStyle';
  let state: DotsIconButtonState = props.state && STATE_CLASS[props.state] ? props.state : 'defaultState';
  // Compat: deprecated variant only when style/state are the defaults
  if (style === 'defaultStyle' && state === 'defaultState' && props.variant && props.variant !== 'solid' && VARIANT_MAP[props.variant]) {
    [style, state] = VARIANT_MAP[props.variant];
  }
  const direction = props.direction === 'row' ? 'row' : 'column';
  const noBg = style === 'noBackground';
  const shouldApplyBlur = props.shouldApplyBlur !== false;
  const showShadow = !!props.showShadow && !noBg;
  const hasLabel = props.label != null && props.label !== '';
  const gap = hasLabel ? sz.spacing + (showShadow ? 4 : 0) : 0;
  const iconSize = props.iconSize || sz.iconSize;
  const textTappable = !!props.textTappable && hasLabel;

  const circleCls =
    `ds-icon-btn__circle ds-icon-btn__circle--${sizeName} ds-icon-btn__circle--${STYLE_CLASS[style]}-${STATE_CLASS[state]}` +
    (style === 'floating' ? ' ds-icon-btn__circle--floating' : '') +
    (noBg ? ' ds-icon-btn__circle--nobg' : '') +
    (!shouldApplyBlur ? ' is-no-blur' : '') +
    (showShadow ? ' has-shadow' : '');

  const circleStyle: CSSProperties = {};
  if (props.backgroundColor) circleStyle.background = props.backgroundColor;
  if (props.color) circleStyle.color = props.color;

  const icon = <DotsIcon name={props.icon} size={iconSize} color={props.color} />;
  const iconContent =
    props.tag != null ? (
      <span className="ds-icon-btn__tagwrap">
        {icon}
        <span className="ds-icon-btn__tag">{props.tag}</span>
      </span>
    ) : (
      icon
    );

  const labelStyle: CSSProperties = { color: props.color || labelColor(style, state) };
  if (direction === 'column' && !noBg) labelStyle.width = sz.size;

  return (
    <span className={`ds-icon-btn ds-icon-btn--${direction}`} style={{ gap }} onClick={textTappable ? props.onClick : undefined}>
      <button type="button" className={circleCls} style={circleStyle} onClick={textTappable ? undefined : props.onClick}>
        {iconContent}
      </button>
      {hasLabel ? (
        <span className={`ds-icon-btn__label${props.overflow ? ' ds-icon-btn__label--ellipsis' : ''}`} style={labelStyle}>
          {props.label}
        </span>
      ) : null}
    </span>
  );
}
