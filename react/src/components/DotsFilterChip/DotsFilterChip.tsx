// DotsFilterChip — port of lib/src/components/dots_filter_chip/dots_filter_chip.dart (Dart = source of truth).
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface DotsFilterChipProps {
  /** Filter text, labelDefaultBold textSecondary — Dart `label` */
  label?: string;
  /** Fired when the chip (including the cross) is tapped — Dart `onTap` */
  onClick?: () => void;
}

export function DotsFilterChip(props: DotsFilterChipProps) {
  // Dart: GestureDetector around the whole chip; the inner DotsCloseButton has no onTap of its own.
  // Web: the chip is the single control (a native button). The cross is decorative — it reuses the
  // DotsCloseButton extraSmall/highContrast classes on a span so no second control nests inside.
  return (
    <button type="button" className="ds-filter-chip" onClick={props.onClick}>
      <span className="ds-filter-chip__label">{props.label ?? ''}</span>
      {/* DotsCloseButton extraSmall (16, icon 10) variant highContrast, no blur — presentational */}
      <span className="ds-filter-chip__close" aria-hidden="true">
        <span className="ds-close-btn ds-close-btn--extraSmall ds-close-btn--highContrast">
          <DotsIcon name="ic-cross" size={10} />
        </span>
      </span>
    </button>
  );
}
