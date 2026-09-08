// DotsToggle — port of lib/src/components/buttons/dots_toggle.dart (Dart = source of truth).
import { useState } from 'react';

export interface DotsToggleProps {
  /** Selected state (controlled) — Dart `isSelected` */
  isSelected?: boolean;
  /** Initial state (uncontrolled) */
  defaultSelected?: boolean;
  /** Called with the new value on tap — Dart `onChanged(bool)` */
  onChanged?: (isSelected: boolean) => void;
  /** Disabled (web extension; the Dart widget does not expose it) */
  disabled?: boolean;
}

export function DotsToggle(props: DotsToggleProps) {
  const controlled = props.isSelected !== undefined && props.isSelected !== null;
  const [internal, setInternal] = useState(!!props.defaultSelected);
  const selected = controlled ? !!props.isSelected : internal;
  function handleClick() {
    if (props.disabled) return;
    if (!controlled) setInternal(!selected);
    props.onChanged?.(!selected);
  }
  return (
    <button
      type="button"
      role="switch"
      aria-checked={selected}
      disabled={!!props.disabled}
      className={`ds-toggle${selected ? ' is-on' : ''}${props.disabled ? ' is-disabled' : ''}`}
      onClick={handleClick}
    >
      <span className="ds-toggle__knob" />
    </button>
  );
}
