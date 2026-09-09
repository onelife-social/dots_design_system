// DotsCloseButton — port of lib/src/components/buttons/dots_close_button/ (Dart = source of truth).
import { DotsIcon } from '../DotsIcon/DotsIcon';

export type DotsCloseButtonSize = 'large' | 'medium' | 'small' | 'extraSmall';
export type DotsCloseButtonVariant = 'softContrast' | 'highContrast' | 'onBackground' | 'inverted';

export interface DotsCloseButtonProps {
  /** DotsIcon name — Dart `iconData` (default 'ic-cross') */
  icon?: string;
  /** Dart enum DotsCloseButtonSize (diameter 44/30/24/16, icon 20/16/16/10) */
  size?: DotsCloseButtonSize;
  /** Dart enum DotsCloseButtonVariant (default softContrast) */
  variant?: DotsCloseButtonVariant;
  /** Dart `onTap` */
  onClick?: () => void;
  /** CSS color forcing the icon color */
  color?: string;
  /** Backdrop blur behind the circle (default true) — Dart `addBlur` */
  addBlur?: boolean;
  /** Accessible name (default 'Close') */
  ariaLabel?: string;
}

// DotsCloseButtonSize: size × iconSize
const SIZES: Record<DotsCloseButtonSize, { size: number; iconSize: number }> = {
  large: { size: 44, iconSize: 20 },
  medium: { size: 30, iconSize: 16 },
  small: { size: 24, iconSize: 16 },
  extraSmall: { size: 16, iconSize: 10 },
};

export function DotsCloseButton(props: DotsCloseButtonProps) {
  const size: DotsCloseButtonSize = props.size && SIZES[props.size] ? props.size : 'large';
  const variant: DotsCloseButtonVariant = props.variant ?? 'softContrast';
  const addBlur = props.addBlur !== false;
  return (
    <button
      type="button"
      className={`ds-close-btn ds-close-btn--${size} ds-close-btn--${variant}${addBlur ? ' ds-close-btn--blur' : ''}`}
      onClick={props.onClick}
      aria-label={props.ariaLabel ?? 'Close'}
    >
      <DotsIcon name={props.icon ?? 'ic-cross'} size={SIZES[size].iconSize} color={props.color} />
    </button>
  );
}
