// BadgeProgress — port of lib/src/components/badges/badge_progress.dart (Dart = source of truth).
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface BadgeProgressProps {
  /** Number on the left — Dart `current` */
  current: number;
  /** Number on the right — Dart `max` */
  max: number;
}

export function BadgeProgress(props: BadgeProgressProps) {
  return (
    <span className="ds-badge-progress">
      <span className="ds-badge-progress__icon" aria-hidden>
        <DotsIcon name="ic-check-circle" size={20} color="var(--label-highlight)" />
      </span>
      <span className="ds-badge-progress__text">{`${props.current}/${props.max}`}</span>
    </span>
  );
}
