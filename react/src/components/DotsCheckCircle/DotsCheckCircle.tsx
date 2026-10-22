// DotsCheckCircle — port of lib/src/components/buttons/dots_check_circle.dart (Dart = source of truth).
import { useState } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface DotsCheckCircleProps {
  /** Selected state (controlled) — Dart `isSelected` */
  isSelected?: boolean;
  /** Initial state (uncontrolled) */
  defaultSelected?: boolean;
  /** Called with the new state on tap (toggles, unlike DotsRadioButton). Without it, a controlled check is
   * display-only: a span hidden from assistive tech, for a parent such as a clickable card that owns the toggle */
  onChanged?: (isSelected: boolean) => void;
  /** Diameter in px — Dart `size` (24) */
  size?: number;
  /** Disabled (web extension; the Dart widget does not expose it) */
  disabled?: boolean;
  /** Accessible name: the check has no text of its own, so the parent names the option */
  ariaLabel?: string;
  /** Id of the element that names the option (alternative to `ariaLabel`) */
  ariaLabelledBy?: string;
}

export function DotsCheckCircle(props: DotsCheckCircleProps) {
  const size = props.size ?? 24;
  const controlled = props.isSelected !== undefined && props.isSelected !== null;
  const [internal, setInternal] = useState(!!props.defaultSelected);
  const selected = controlled ? !!props.isSelected : internal;
  const interactive = !controlled || props.onChanged !== undefined;
  const className = `ds-check-circle${selected ? ' is-on' : ''}${props.disabled ? ' is-disabled' : ''}`;
  const style = { width: `${size}px`, height: `${size}px` };
  const check = selected ? <DotsIcon name="ic-check" size={14} color="var(--label-always-white)" /> : null;
  function handleClick() {
    if (props.disabled) return;
    if (!controlled) setInternal(!selected);
    props.onChanged?.(!selected);
  }
  if (!interactive) {
    return (
      <span aria-hidden="true" className={className} style={style}>
        {check}
      </span>
    );
  }
  return (
    <button
      type="button"
      role="checkbox"
      aria-checked={selected}
      aria-label={props.ariaLabel}
      aria-labelledby={props.ariaLabelledBy}
      disabled={!!props.disabled}
      className={className}
      style={style}
      onClick={handleClick}
    >
      {check}
    </button>
  );
}
