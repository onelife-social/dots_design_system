// DotsSystemButton — port of lib/src/components/buttons/dots_system_button/ (Dart = source of truth).
import type { MouseEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Dart enum DotsSystemButtonVariant */
export type DotsSystemButtonVariant = 'active' | 'disabled' | 'destructive';
/** Dart enum DotsSystemButtonSize (single value: medium, height 44) */
export type DotsSystemButtonSize = 'medium';

export interface DotsSystemButtonProps {
  /** Button text — Dart `content` */
  label: string;
  /** DotsIcon name (e.g. 'ic-add') — Dart `icon: DotsIconData` */
  icon?: string;
  /** Size — Dart enum DotsSystemButtonSize (default and only value: 'medium') */
  size?: DotsSystemButtonSize;
  /**
   * Variant — Dart enum DotsSystemButtonVariant (default 'active').
   * 'disabled' is visual-only, as in Dart (InkWell.onTap is wired regardless of the variant): the
   * button stays enabled, exposes no `disabled`/`aria-disabled`, and still emits onClick.
   */
  variant?: DotsSystemButtonVariant;
  /** Tap callback — Dart `onTap`. Receives the native click event (a `() => void` is also accepted) */
  onClick?: (e?: MouseEvent<HTMLButtonElement>) => void;
  /** Full width (the Flutter Row mainAxisSize.max filling the parent) */
  expand?: boolean;
  /** Extra CSS class */
  className?: string;
}

const VARIANTS: DotsSystemButtonVariant[] = ['active', 'disabled', 'destructive'];
// DotsSystemButtonSize.medium.iconSize
const ICON_SIZE: Record<DotsSystemButtonSize, number> = { medium: 20 };

export function DotsSystemButton(props: DotsSystemButtonProps) {
  const size: DotsSystemButtonSize = props.size && ICON_SIZE[props.size] ? props.size : 'medium';
  const variant: DotsSystemButtonVariant = props.variant && VARIANTS.includes(props.variant) ? props.variant : 'active';

  let className = `ds-system-btn ds-system-btn--size-${size} ds-system-btn--${variant}`;
  if (props.expand) className += ' ds-system-btn--expand';
  if (props.className) className += ` ${props.className}`;

  // The 'disabled' variant is ONLY visual in Dart (InkWell still receives onTap): no disabled/aria-disabled
  return (
    <button type="button" className={className} onClick={props.onClick}>
      {props.icon ? (
        <span className="ds-system-btn__icon" aria-hidden>
          <DotsIcon name={props.icon} size={ICON_SIZE[size]} />
        </span>
      ) : null}
      <span className="ds-system-btn__label">{props.label}</span>
    </button>
  );
}
