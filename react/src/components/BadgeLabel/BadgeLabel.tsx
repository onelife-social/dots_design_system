// BadgeLabel — port of lib/src/components/badges/badge_label/ (Dart = source of truth).
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Dart enum BadgeLabelSize (large h34 / medium h22 / small h18) */
export type BadgeLabelSize = 'large' | 'medium' | 'small';
/** Dart enum BadgeLabelVariant */
export type BadgeLabelVariant =
  | 'main'
  | 'secondary'
  | 'green'
  | 'white'
  | 'greenMaterial'
  | 'warning'
  | 'warningMaterial'
  | 'red'
  | 'premiumPlus'
  | 'premium';

export interface BadgeLabelProps {
  /** Badge text — Dart `content` */
  content: string;
  /** Size — Dart enum BadgeLabelSize (large h34 / medium h22 / small h18) */
  size?: BadgeLabelSize;
  /** Visual variant — Dart enum BadgeLabelVariant (default 'main') */
  variant?: BadgeLabelVariant;
  /** Real Dots icon name (e.g. 'ic-check-circle'), 16px on the left — Dart `badgeIcon` */
  badgeIcon?: string;
}

// BadgeLabelVariant (Dart) → class suffix
const VARIANTS: Record<BadgeLabelVariant, string> = {
  main: 'main',
  secondary: 'secondary',
  green: 'green',
  white: 'white',
  greenMaterial: 'green-material',
  warning: 'warning',
  warningMaterial: 'warning-material',
  red: 'red',
  premiumPlus: 'premium-plus',
  premium: 'premium',
};
const SIZES: Record<BadgeLabelSize, true> = { large: true, medium: true, small: true };

export function BadgeLabel(props: BadgeLabelProps) {
  const size: BadgeLabelSize = props.size && SIZES[props.size] ? props.size : 'medium'; // Dart: default medium
  const variant = (props.variant && VARIANTS[props.variant]) || VARIANTS.main; // Dart: default main
  return (
    <span className={`ds-badge-label ds-badge-label--${size} ds-badge-label--${variant}`}>
      {props.badgeIcon ? (
        <span className="ds-badge-label__icon" aria-hidden>
          <DotsIcon name={props.badgeIcon} size={16} color="currentColor" />
        </span>
      ) : null}
      <span className="ds-badge-label__text">{props.content}</span>
    </span>
  );
}
