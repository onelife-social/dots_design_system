// DotsMainButton — port of lib/src/components/buttons/dots_main_button/ (Dart = source of truth).
import { useRef, type CSSProperties, type MouseEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Dart enum DotsMainButtonVariant */
export type DotsMainButtonVariant =
  | 'main'
  | 'secondary'
  | 'secondaryPremium'
  | 'secondaryPremiumPlus'
  | 'secondaryLight'
  | 'secondaryDark'
  | 'destructive'
  | 'disabled'
  | 'disabledOpaque'
  | 'ghost'
  | 'premiumPlus'
  | 'premium'
  | 'surface'
  | 'surfacePremium'
  | 'surfacePremiumPlus';

/** Dart enum DotsMainButtonSize (heights 52/44/36/28) */
export type DotsMainButtonSize = 'mainAction' | 'large' | 'medium' | 'small';

export interface DotsMainButtonProps {
  /** Button text — Dart `content` */
  label: string;
  /** DotsIcon name (e.g. 'ic-check') — Dart `icon: DotsIconData` */
  icon?: string;
  /** Secondary text; only visible in mainAction and large sizes — Dart `details` */
  details?: string;
  /** Icon size in px (default 20) */
  iconSize?: number;
  /** Size — Dart enum DotsMainButtonSize (default 'large') */
  size?: DotsMainButtonSize;
  /** Visual variant — Dart enum DotsMainButtonVariant (default 'main') */
  variant?: DotsMainButtonVariant;
  /** When false, `disabledVariant` is painted and clicks are ignored (default true) */
  enabled?: boolean;
  /** Tap callback — Dart `onTap` */
  onClick?: (e?: MouseEvent<HTMLButtonElement>) => void;
  /** Fill the available width (default true) */
  expand?: boolean;
  /** Compact 7px horizontal padding (default false) */
  adaptPaddingForText?: boolean;
  /** CSS color overriding the theme text color */
  textColor?: string;
  /** CSS color overriding the icon color */
  iconColor?: string;
  /** CSS color overriding the background (also cancels the gradient) */
  backgroundColor?: string;
  /** Extra inline style for the label — Dart `textStyle` */
  textStyle?: CSSProperties;
  /** Apply blur (and shadow on the variants that carry it) (default false) */
  shouldApplyBlur?: boolean;
  /** Icon position (default 'left') — Dart enum DotsMainButtonIconPosition */
  iconPosition?: 'left' | 'right';
  /** Show a spinner and block clicks (default false) */
  isLoading?: boolean;
  /** Variant used when enabled=false (default 'disabled') */
  disabledVariant?: DotsMainButtonVariant;
  /** Throttle onClick (default false) — Dart `useThrottle` */
  useThrottle?: boolean;
  /** Throttle window in ms (default 400) — Dart `throttleDuration` */
  throttleDuration?: number;
  className?: string;
}

const SIZE_HEIGHT: Record<DotsMainButtonSize, number> = { mainAction: 52, large: 44, medium: 36, small: 28 };

const VARIANTS: readonly DotsMainButtonVariant[] = [
  'main', 'secondary', 'secondaryPremium', 'secondaryPremiumPlus', 'secondaryLight',
  'secondaryDark', 'destructive', 'disabled', 'disabledOpaque', 'ghost',
  'premiumPlus', 'premium', 'surface', 'surfacePremium', 'surfacePremiumPlus',
];

// Variants whose foregroundGradient is cancelled by textColor (see dots_main_button_theme.dart)
const GRADIENT_CANCELLED_BY_TEXTCOLOR = new Set<DotsMainButtonVariant>([
  'secondaryPremium', 'secondaryPremiumPlus', 'surfacePremium', 'surfacePremiumPlus',
]);

const isVariant = (v: unknown): v is DotsMainButtonVariant => VARIANTS.includes(v as DotsMainButtonVariant);

export function DotsMainButton(props: DotsMainButtonProps) {
  const lastTapRef = useRef(0);

  const size: DotsMainButtonSize = props.size && SIZE_HEIGHT[props.size] ? props.size : 'large'; // DotsMainButtonSize.large
  const variant = isVariant(props.variant) ? props.variant : 'main'; // DotsMainButtonVariant.main
  const enabled = props.enabled !== false;
  const isLoading = !!props.isLoading;
  const disabledVariant = isVariant(props.disabledVariant) ? props.disabledVariant : 'disabled';
  const effVariant = enabled ? variant : disabledVariant;
  const iconPosition = props.iconPosition === 'right' ? 'right' : 'left';
  const iconSize = props.iconSize ?? 20;
  const expand = props.expand !== false;

  let className = `ds-main-btn ds-main-btn--size-${size} ds-main-btn--${effVariant}`;
  if (expand) className += ' ds-main-btn--expand';
  if (props.adaptPaddingForText) className += ' ds-main-btn--adapt-padding';
  if (props.shouldApplyBlur) className += ' ds-main-btn--blur';
  if (props.textColor && GRADIENT_CANCELLED_BY_TEXTCOLOR.has(effVariant)) className += ' ds-main-btn--custom-text';
  if (props.className) className += ` ${props.className}`;

  const rootStyle: CSSProperties = {};
  if (props.backgroundColor) rootStyle.background = props.backgroundColor; // also cancels backgroundGradient (Dart)
  if (props.textColor) rootStyle.color = props.textColor;

  function handleClick(e: MouseEvent<HTMLButtonElement>) {
    if (!props.onClick) return;
    if (props.useThrottle) {
      // EasyThrottle.throttle(…, throttleDuration): first tap passes, the rest are ignored inside the window
      const now = Date.now();
      const win = props.throttleDuration ?? 400;
      if (now - lastTapRef.current < win) return;
      lastTapRef.current = now;
    }
    props.onClick(e);
  }

  const iconEl =
    props.icon && !isLoading ? (
      <span className="ds-main-btn__icon" style={props.iconColor ? { color: props.iconColor } : undefined} aria-hidden>
        <DotsIcon name={props.icon} size={iconSize} />
      </span>
    ) : null;

  const labelEl = (
    <span className="ds-main-btn__label" style={props.textStyle}>
      {props.label}
    </span>
  );

  // details only in mainAction and large (Dart)
  const detailsEl =
    props.details != null && (size === 'mainAction' || size === 'large') ? (
      <span className="ds-main-btn__details">{props.details}</span>
    ) : null;

  let children;
  if (isLoading) {
    // GradientProgressIndicator: diameter = height - 25, stroke 3 (12px visual minimum on web)
    const d = Math.max(SIZE_HEIGHT[size] - 25, 12);
    children = <span className="ds-main-btn__spinner" style={{ width: d, height: d }} />;
  } else if (iconPosition === 'left') {
    children = (
      <>
        {iconEl}
        {labelEl}
        {detailsEl}
      </>
    );
  } else {
    children = (
      <>
        {labelEl}
        {detailsEl}
        {iconEl}
      </>
    );
  }

  return (
    <button
      type="button"
      className={className}
      style={props.backgroundColor || props.textColor ? rootStyle : undefined}
      disabled={!enabled || isLoading}
      aria-busy={isLoading || undefined}
      onClick={enabled && !isLoading ? handleClick : undefined}
    >
      {children}
    </button>
  );
}
