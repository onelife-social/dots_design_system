// DotsInputStepper — port of lib/src/components/buttons/dots_input_stepper.dart (Dart = source of truth).
import { useState } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface DotsInputStepperProps {
  /** Current value (controlled) — Dart `value` */
  value?: number;
  /** Initial value (uncontrolled; default minValue) */
  defaultValue?: number;
  /** Minimum allowed — Dart `minValue` (required in Dart; web default 0) */
  minValue?: number;
  /** Maximum allowed — Dart `maxValue` (required in Dart; web default 99) */
  maxValue?: number;
  /** + button callback — Dart `onIncrement` */
  onIncrement?: () => void;
  /** − button callback — Dart `onDecrement` */
  onDecrement?: () => void;
  /** Called with the new value after each press (web extension) */
  onChanged?: (value: number) => void;
}

export function DotsInputStepper(props: DotsInputStepperProps) {
  const min = props.minValue ?? 0; // Dart: required (web default: 0)
  const max = props.maxValue ?? 99; // Dart: required (web default: 99)
  const controlled = props.value !== undefined && props.value !== null;
  const [internal, setInternal] = useState(props.defaultValue ?? min);
  const value = controlled ? (props.value as number) : internal;
  const canDecrement = value > min;
  const canIncrement = value < max;

  function step(delta: number, canStep: boolean, dartCallback?: () => void) {
    if (!canStep) return;
    const next = value + delta;
    if (!controlled) setInternal(next);
    dartCallback?.();
    props.onChanged?.(next);
  }

  // Dart: DotsIconButton small (28) without background nor blur; enabled textTertiary,
  // disabled resolved by the button theme → textDisabled.
  function stepBtn(iconName: string, enabled: boolean, onClick: () => void) {
    return (
      <button type="button" className={`ds-stepper__btn${enabled ? '' : ' is-disabled'}`} disabled={!enabled} onClick={onClick}>
        <DotsIcon name={iconName} size={14} color="currentColor" />
      </button>
    );
  }

  return (
    <div className="ds-stepper">
      {stepBtn('ic-rest', canDecrement, () => step(-1, canDecrement, props.onDecrement))}
      <span className="ds-stepper__value">{String(value)}</span>
      {stepBtn('ic-add', canIncrement, () => step(1, canIncrement, props.onIncrement))}
    </div>
  );
}
