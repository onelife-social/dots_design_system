// DotsItemInput — port of lib/src/components/text_fields/dots_item_input.dart (Dart = source of truth).
import type { KeyboardEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

export type DotsItemInputPosition = 'onlyOne' | 'first' | 'middle' | 'last';

export interface DotsItemInputProps {
  /** Row text. Dart: label */
  label?: string;
  /** Value shown in the right box (120×r7). Dart: value */
  value?: string;
  /** Real Dots icon name. Dart: icon (default DotsIconData.calendar → 'ic-calendar') */
  icon?: string;
  /** Position in the group — Dart enum DotsItemInputPosition (default onlyOne) */
  position?: DotsItemInputPosition;
  /** Row tap. Dart: onTap */
  onClick?: () => void;
}

// DotsItemInputPosition → class suffix (radius 16 per position)
const POSITIONS: Record<DotsItemInputPosition, string> = { onlyOne: 'only-one', first: 'first', middle: 'middle', last: 'last' };

export function DotsItemInput(props: DotsItemInputProps) {
  const pos = (props.position && POSITIONS[props.position]) || 'only-one'; // Dart: default → full r16
  const clickable = typeof props.onClick === 'function';

  function handleKeyDown(e: KeyboardEvent<HTMLDivElement>) {
    if ((e.key === 'Enter' || e.key === ' ') && clickable) {
      e.preventDefault();
      props.onClick?.();
    }
  }

  return (
    <div
      className={`ds-item-input ds-item-input--${pos}${clickable ? ' ds-item-input--clickable' : ''}`}
      role={clickable ? 'button' : undefined}
      tabIndex={clickable ? 0 : undefined}
      onClick={props.onClick} // Dart: onTap
      onKeyDown={clickable ? handleKeyDown : undefined}
    >
      <span className="ds-item-input__icon" aria-hidden>
        {/* Dart: icon ?? calendar */}
        <DotsIcon name={props.icon || 'ic-calendar'} size={20} color="currentColor" />
      </span>
      <span className="ds-item-input__label">{props.label || ''}</span>
      <span className="ds-item-input__value">{props.value || ''}</span>
    </div>
  );
}
