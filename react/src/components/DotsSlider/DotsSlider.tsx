// DotsSlider — port of lib/src/components/slider/dots_slider.dart (Dart = source of truth).
import { useRef, useState, type KeyboardEvent, type PointerEvent, type ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface DotsSliderProps {
  /** Current value (controlled) — Dart `value` */
  value?: number;
  /** Initial value (uncontrolled, web extension) */
  defaultValue?: number;
  /** Number of discrete divisions; null/undefined → continuous — Dart `divisions` */
  divisions?: number | null;
  /** Max value — Dart `max` (default 1.0) */
  max?: number;
  /** Called with the new value on drag/tap — Dart `onChanged` */
  onChanged?: (value: number) => void;
  /** Left icon (asset ic-…) — Dart `leftIcon` (default 'ic-user') */
  leftIcon?: string;
  /** Right icon (asset ic-…) — Dart `rightIcon` (default 'ic-group') */
  rightIcon?: string;
}

function clamp(v: number, lo: number, hi: number) {
  return v < lo ? lo : v > hi ? hi : v;
}

export function DotsSlider(props: DotsSliderProps) {
  const max = props.max ?? 1.0;
  const divisions = props.divisions ?? null;
  const controlled = props.value !== undefined && props.value !== null;
  const [internal, setInternal] = useState(props.defaultValue ?? 0);
  const value = clamp(controlled ? (props.value as number) : internal, 0, max);
  // As in Flutter: without onChanged (and controlled) the slider is not interactive
  const interactive = typeof props.onChanged === 'function' || !controlled;

  const trackRef = useRef<HTMLDivElement>(null);
  const draggingRef = useRef(false);

  function valueFromPointer(e: PointerEvent<HTMLDivElement>) {
    const rect = trackRef.current?.getBoundingClientRect();
    let ratio = rect && rect.width > 0 ? (e.clientX - rect.left) / rect.width : 0;
    ratio = clamp(ratio, 0, 1);
    if (divisions) ratio = Math.round(ratio * divisions) / divisions;
    return ratio * max;
  }

  function commit(v: number) {
    if (!controlled) setInternal(v);
    props.onChanged?.(v);
  }

  function onPointerDown(e: PointerEvent<HTMLDivElement>) {
    if (!interactive) return;
    draggingRef.current = true;
    e.currentTarget.setPointerCapture?.(e.pointerId);
    commit(valueFromPointer(e));
  }
  function onPointerMove(e: PointerEvent<HTMLDivElement>) {
    if (!draggingRef.current) return;
    commit(valueFromPointer(e));
  }
  function onPointerUp() {
    draggingRef.current = false;
  }

  // Keyboard (WAI-ARIA slider pattern): arrows move one step (a division, or 1% of the range when
  // continuous), Home/End jump to the ends. Inert when the slider is not interactive.
  const step = divisions ? max / divisions : max / 100;
  function onKeyDown(e: KeyboardEvent<HTMLDivElement>) {
    if (!interactive) return;
    let next: number;
    switch (e.key) {
      case 'ArrowLeft':
      case 'ArrowDown':
        next = value - step;
        break;
      case 'ArrowRight':
      case 'ArrowUp':
        next = value + step;
        break;
      case 'Home':
        next = 0;
        break;
      case 'End':
        next = max;
        break;
      default:
        return;
    }
    e.preventDefault();
    next = clamp(next, 0, max);
    if (divisions && max > 0) next = (Math.round((next / max) * divisions) / divisions) * max;
    if (next !== value) commit(next);
  }

  const pct = max > 0 ? (value / max) * 100 : 0;

  const ticks: ReactNode[] = [];
  if (divisions) {
    for (let i = 0; i <= divisions; i++) {
      ticks.push(<span key={`t${i}`} className="ds-slider__tick" style={{ left: `${(i / divisions) * 100}%` }} />);
    }
  }

  return (
    <div className={`ds-slider${interactive ? '' : ' is-static'}`}>
      <DotsIcon name={props.leftIcon || 'ic-user'} size={20} color="var(--label-secondary)" className="ds-slider__icon" />
      <div
        className="ds-slider__track"
        ref={trackRef}
        role="slider"
        aria-valuemin={0}
        aria-valuemax={max}
        aria-valuenow={value}
        aria-disabled={interactive ? undefined : true}
        tabIndex={interactive ? 0 : undefined}
        onKeyDown={onKeyDown}
        onPointerDown={onPointerDown}
        onPointerMove={onPointerMove}
        onPointerUp={onPointerUp}
        onPointerCancel={onPointerUp}
      >
        <div className="ds-slider__fill" style={{ width: `${pct}%` }} />
        {ticks}
        <div className="ds-slider__thumb" style={{ left: `${pct}%` }} />
      </div>
      <DotsIcon name={props.rightIcon || 'ic-group'} size={20} color="var(--label-secondary)" className="ds-slider__icon" />
    </div>
  );
}
