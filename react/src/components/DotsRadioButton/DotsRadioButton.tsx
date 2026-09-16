// DotsRadioButton — port of lib/src/components/buttons/dots_radio_button.dart (Dart = source of truth).
import { useState } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface DotsRadioButtonProps {
  /** Selected state (controlled) — Dart `isSelected` */
  isSelected?: boolean;
  /** Initial state (uncontrolled) */
  defaultSelected?: boolean;
  /** Called with `true` on tap (a radio never unselects itself) */
  onChanged?: (isSelected: boolean) => void;
  /** Diameter in px — Dart `size` (24) */
  size?: number;
  /** Disabled (web extension; the Dart widget does not expose it) */
  disabled?: boolean;
  /** Accessible name: the radio has no text of its own, so the parent names the option */
  ariaLabel?: string;
  /** Id of the element that names the option (alternative to `ariaLabel`) */
  ariaLabelledBy?: string;
}

export function DotsRadioButton(props: DotsRadioButtonProps) {
  const size = props.size ?? 24;
  const controlled = props.isSelected !== undefined && props.isSelected !== null;
  const [internal, setInternal] = useState(!!props.defaultSelected);
  const selected = controlled ? !!props.isSelected : internal;
  function handleClick() {
    if (props.disabled) return;
    if (!controlled && !selected) setInternal(true);
    props.onChanged?.(true);
  }
  return (
    <button
      type="button"
      role="radio"
      aria-checked={selected}
      aria-label={props.ariaLabel}
      aria-labelledby={props.ariaLabelledBy}
      disabled={!!props.disabled}
      className={`ds-radio${selected ? ' is-on' : ''}${props.disabled ? ' is-disabled' : ''}`}
      style={{ width: `${size}px`, height: `${size}px` }}
      onClick={handleClick}
    >
      {selected ? <DotsIcon name="ic-selector" size={15} color="var(--label-highlight)" /> : null}
    </button>
  );
}
