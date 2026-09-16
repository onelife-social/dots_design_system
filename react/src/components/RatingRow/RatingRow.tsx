// RatingRow — port of lib/src/components/rating/rating_row.dart + rating_star.dart (Dart = source of truth, widgets DotsRatingStarRow / DotsRatingStar).
import type { ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Dart enum RatingIconVariant */
export type RatingStarVariant = 'disabled' | 'detractor' | 'neutral' | 'promoter';

export interface RatingRowProps {
  /** Star labels — Dart requires length 5 or 10 */
  starLabels: string[];
  /** Bottom-left text (default layout only) */
  leftText?: string;
  /** Bottom-right text (default layout only) */
  rightText?: string;
  /** Selected star index; null/undefined → all disabled */
  selectedIndex?: number | null;
  /** Called when a star is tapped */
  onStarTap?: (index: number) => void;
  /** Compact layout: centered rows of 6+4 (with 10 stars) */
  compact?: boolean;
  /** Show the label above each star (default true) */
  showStarText?: boolean;
  /** Star icon size in px — default 28 */
  iconSize?: number;
}

// Real vertical gradients of rating_star.dart (accent colors without CSS token):
// detractor friends001→friends003, neutral class008→friends005, promoter family008→team007
const GRADIENTS: Array<[RatingStarVariant, string, string]> = [
  ['detractor', '#FAA25E', '#FA5B3D'],
  ['neutral', '#FCD12A', '#F7954A'],
  ['promoter', '#4FC976', '#01AF94'],
];

function GradientDefs() {
  return (
    <svg width={0} height={0} style={{ position: 'absolute' }} aria-hidden>
      <defs>
        {GRADIENTS.map((g) => (
          <linearGradient key={g[0]} id={`ds-rating-g-${g[0]}`} x1="0" y1="0" x2="0" y2="1">
            <stop offset="0" stopColor={g[1]} />
            <stop offset="1" stopColor={g[2]} />
          </linearGradient>
        ))}
      </defs>
    </svg>
  );
}

interface StarProps {
  label?: string;
  variant?: RatingStarVariant;
  showText: boolean;
  iconSize?: number;
  onTap?: () => void;
}

function Star(props: StarProps) {
  const variant = props.variant || 'disabled';
  const size = props.iconSize ?? 28;
  return (
    <span className={`ds-rating-star ds-rating-star--${variant}${props.onTap ? ' is-tappable' : ''}`} onClick={props.onTap}>
      {props.showText ? <span className="ds-rating-star__label">{props.label}</span> : null}
      <span className="ds-rating-star__icon">
        <DotsIcon name="ic-star" size={size} />
      </span>
    </span>
  );
}

// Port of _buildVariants (rating_row.dart)
function buildVariants(starLabels: string[], selectedIndex: number | null): RatingStarVariant[] {
  const n = starLabels.length;
  const out: RatingStarVariant[] = [];
  for (let i = 0; i < n; i++) {
    if (selectedIndex == null) {
      out.push('disabled');
      continue;
    }
    if (n === 5) {
      out.push(i <= selectedIndex ? 'neutral' : 'disabled');
      continue;
    }
    if (selectedIndex <= 5) out.push(i <= selectedIndex ? 'detractor' : 'disabled');
    else if (selectedIndex <= 7) out.push(i <= selectedIndex ? 'neutral' : 'disabled');
    else out.push(i <= selectedIndex ? 'promoter' : 'disabled');
  }
  return out;
}

export function RatingRow(props: RatingRowProps) {
  const starLabels = props.starLabels || [];
  const variants = buildVariants(starLabels, props.selectedIndex ?? null);

  const makeStar = (index: number) => (
    <Star
      key={index}
      label={starLabels[index]}
      variant={variants[index]}
      showText={props.showStarText !== false}
      iconSize={props.iconSize}
      onTap={typeof props.onStarTap === 'function' ? () => props.onStarTap?.(index) : undefined}
    />
  );

  let body: ReactNode;
  if (props.compact) {
    // _CompactLayout — first row of 6 (if >5) and second of 4, centered, gap 5
    const firstCount = starLabels.length > 5 ? 6 : starLabels.length;
    const first: ReactNode[] = [];
    for (let i = 0; i < firstCount; i++) first.push(makeStar(i));
    const rows: ReactNode[] = [
      <div key="r1" className="ds-rating-row__stars ds-rating-row__stars--compact">
        {first}
      </div>,
    ];
    if (starLabels.length > 5) {
      const second: ReactNode[] = [];
      for (let j = 6; j < starLabels.length; j++) second.push(makeStar(j));
      rows.push(
        <div key="r2" className="ds-rating-row__stars ds-rating-row__stars--compact">
          {second}
        </div>,
      );
    }
    body = rows;
  } else {
    // _DefaultLayout — spaceBetween + texts below (labelSmallMedium textQuarternary)
    const stars: ReactNode[] = [];
    for (let i = 0; i < starLabels.length; i++) stars.push(makeStar(i));
    body = (
      <>
        <div className="ds-rating-row__stars">{stars}</div>
        <div className="ds-rating-row__ends">
          <span>{props.leftText || ''}</span>
          <span>{props.rightText || ''}</span>
        </div>
      </>
    );
  }

  return (
    <div className={`ds-rating-row${props.compact ? ' ds-rating-row--compact' : ''}`}>
      <GradientDefs />
      {body}
    </div>
  );
}
