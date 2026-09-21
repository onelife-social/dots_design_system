// DotsSegmentedControl — port of lib/src/components/segmented_control/ (Dart = source of truth).
// Covers SegmentedControl (type 'text', variant main|camera), SegmentedControlIcon
// (type 'icon') and SegmentedControlSingle (type 'single').
import { useState } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Active option — Dart enum SegmentedControlOption */
export type DotsSegmentedControlOption = 'left' | 'right';
export type DotsSegmentedControlType = 'text' | 'icon' | 'single';
export type DotsSegmentedControlVariant = 'main' | 'camera';

export interface DotsSegmentedControlProps {
  /** Dart widget: 'text' → SegmentedControl, 'icon' → SegmentedControlIcon, 'single' → SegmentedControlSingle */
  type?: DotsSegmentedControlType;
  /** Only type 'text' — Dart enum SegmentedControlVariant */
  variant?: DotsSegmentedControlVariant;
  /** type 'text': left label — Dart `leftOptionName` */
  leftOptionName?: string;
  /** type 'text': right label — Dart `rightOptionName` */
  rightOptionName?: string;
  /** type 'text': badge over the right option — Dart `rightOptionTag` */
  rightOptionTag?: string;
  /** type 'icon': DotsIcon name ('ic-…') — Dart `leftOptionIcon` */
  leftOptionIcon?: string;
  /** type 'icon': DotsIcon name ('ic-…') — Dart `rightOptionIcon` */
  rightOptionIcon?: string;
  /** type 'icon': accessible name (aria-label) of the left icon button — web extension, localizable */
  leftOptionLabel?: string;
  /** type 'icon': accessible name (aria-label) of the right icon button — web extension, localizable */
  rightOptionLabel?: string;
  /** type 'single': button label — Dart `buttonName` */
  buttonName?: string;
  /** type 'single': badge — Dart `buttonTag` */
  buttonTag?: string;
  /** Active option (controlled) — Dart `selectedOption` */
  selectedOption?: DotsSegmentedControlOption;
  /** Initial option (uncontrolled) */
  defaultSelectedOption?: DotsSegmentedControlOption;
  /**
   * Called with the tapped option — Dart `onTapOption`. Types `text` and `icon` only: the `single`
   * type is purely visual (Dart `SegmentedControlSingle` has no tap handler) and never fires it.
   */
  onTapOption?: (option: DotsSegmentedControlOption) => void;
  /** type 'text'/'single': CSS color of the selected segment — Dart `selectedColor` */
  selectedColor?: string;
  /** type 'text'/'single': CSS background color — Dart `backgroundColor` */
  backgroundColor?: string;
}

function badgeTag(tag?: string) {
  // BadgeTag at (-2,-2) — rightOptionTag / buttonTag
  return tag ? <span className="ds-seg__tag">{tag}</span> : null;
}

export function DotsSegmentedControl(props: DotsSegmentedControlProps) {
  const type = props.type || 'text';
  const controlled = props.selectedOption !== undefined && props.selectedOption !== null;
  const [internal, setInternal] = useState<DotsSegmentedControlOption>(props.defaultSelectedOption || 'left');
  const selected = controlled ? props.selectedOption : internal;
  function tap(option: DotsSegmentedControlOption) {
    if (!controlled) setInternal(option);
    props.onTapOption?.(option);
  }

  if (type === 'single') {
    // SegmentedControlSingle — a single, always selected option
    return (
      <div className="ds-seg ds-seg--single" style={props.backgroundColor ? { background: props.backgroundColor } : undefined}>
        <span className="ds-seg__opt is-selected" style={props.selectedColor ? { background: props.selectedColor } : undefined}>
          {props.buttonName}
        </span>
        {badgeTag(props.buttonTag)}
      </div>
    );
  }

  if (type === 'icon') {
    // SegmentedControlIcon — 108×48, cells 48×40, sliding pill 200ms
    const cell = (side: DotsSegmentedControlOption, name?: string, label?: string) => {
      const sel = selected === side;
      return (
        <button
          type="button"
          className={`ds-seg-icon__cell${sel ? ' is-selected' : ''}`}
          aria-pressed={sel}
          aria-label={label || undefined}
          onClick={() => tap(side)}
        >
          <DotsIcon name={name ?? ''} size={24} color={sel ? 'var(--text-secondary)' : 'var(--text-disabled)'} />
        </button>
      );
    };
    return (
      <div className="ds-seg-icon">
        <span className={`ds-seg-icon__pill${selected === 'right' ? ' is-right' : ''}`} />
        {cell('left', props.leftOptionIcon, props.leftOptionLabel)}
        {cell('right', props.rightOptionIcon, props.rightOptionLabel)}
      </div>
    );
  }

  // type 'text' — SegmentedControl (variant main | camera)
  const variant = props.variant || 'main';
  const opt = (side: DotsSegmentedControlOption, label?: string) => {
    const sel = selected === side;
    return (
      <button
        type="button"
        className={`ds-seg__opt${sel ? ' is-selected' : ''}`}
        style={sel && props.selectedColor ? { background: props.selectedColor } : undefined}
        aria-pressed={sel}
        onClick={() => tap(side)}
      >
        {label}
      </button>
    );
  };
  return (
    <div
      className={`ds-seg${variant === 'camera' ? ' ds-seg--camera' : ''}`}
      style={props.backgroundColor ? { background: props.backgroundColor } : undefined}
    >
      {opt('left', props.leftOptionName)}
      {opt('right', props.rightOptionName)}
      {badgeTag(props.rightOptionTag)}
    </div>
  );
}
