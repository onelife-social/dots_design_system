// DotsSelector — port of lib/src/components/buttons/dots_selector.dart (Dart = source of truth).
import { useState, type ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

export type DotsSelectorSize = 'small' | 'medium';
export type DotsSelectorVariant = 'check' | 'num';

export interface DotsSelectorProps {
  /** Visual variant — Dart enum DotsSelectorVariant (default 'check') */
  variant?: DotsSelectorVariant;
  /** Size — Dart enum DotsSelectorSize (height small 22 / medium 24; default medium) */
  size?: DotsSelectorSize;
  /** Selected state (controlled) — Dart `isSelected` */
  isSelected?: boolean;
  /** Initial state (uncontrolled; click toggles) */
  defaultSelected?: boolean;
  /** Called with the new state on tap (web extension; the Dart widget is only visual) */
  onChanged?: (isSelected: boolean) => void;
  /** (variant num only) Number shown when selected — Dart `number` (default 1) */
  number?: number;
}

// DotsSelectorSize.height
const SIZES: Record<DotsSelectorSize, number> = { small: 22, medium: 24 };

export function DotsSelector(props: DotsSelectorProps) {
  const sizeName: DotsSelectorSize = props.size && SIZES[props.size] ? props.size : 'medium';
  const variant: DotsSelectorVariant = props.variant === 'num' ? 'num' : 'check';
  const controlled = props.isSelected !== undefined && props.isSelected !== null;
  const [internal, setInternal] = useState(!!props.defaultSelected);
  const selected = controlled ? !!props.isSelected : internal;

  function handleClick() {
    const next = !selected;
    if (!controlled) setInternal(next);
    props.onChanged?.(next);
  }

  let content: ReactNode = null;
  if (selected) {
    content =
      variant === 'check' ? (
        <DotsIcon name="ic-check" size={14} color="var(--label-always-white)" />
      ) : (
        String(props.number ?? 1)
      );
  }

  return (
    <button
      type="button"
      role="checkbox"
      aria-checked={selected}
      className={`ds-selector ds-selector--${sizeName}${selected ? ' is-on' : ''}`}
      onClick={handleClick}
    >
      {content}
    </button>
  );
}
