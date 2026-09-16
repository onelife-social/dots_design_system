// DotsFilterChip — port of lib/src/components/dots_filter_chip/dots_filter_chip.dart (Dart = source of truth).
import type { KeyboardEvent } from 'react';
import { DotsCloseButton } from '../DotsCloseButton/DotsCloseButton';

export interface DotsFilterChipProps {
  /** Filter text, labelDefaultBold textSecondary — Dart `label` */
  label?: string;
  /** Fired when the chip (including the cross) is tapped — Dart `onTap` */
  onClick?: () => void;
}

export function DotsFilterChip(props: DotsFilterChipProps) {
  // Dart: GestureDetector around the whole chip; the inner DotsCloseButton has no onTap of its own,
  // so its click bubbles up to the chip (a div, not a button: buttons cannot nest).
  function handleKeyDown(e: KeyboardEvent<HTMLDivElement>) {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      props.onClick?.();
    }
  }
  return (
    <div className="ds-filter-chip" role="button" tabIndex={0} onClick={props.onClick} onKeyDown={handleKeyDown}>
      <span className="ds-filter-chip__label">{props.label ?? ''}</span>
      {/* DotsCloseButton extraSmall (16, icon 10) variant highContrast, no blur */}
      <span className="ds-filter-chip__close">
        <DotsCloseButton size="extraSmall" variant="highContrast" addBlur={false} ariaLabel="Remove filter" />
      </span>
    </div>
  );
}
