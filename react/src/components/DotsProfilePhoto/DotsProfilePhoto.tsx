// DotsProfilePhoto — port of lib/src/components/photos_components/dots_profile_photo.dart
// (+ dots_profile_photo_bited.dart as the `bited` variant). Dart = source of truth.
import { useState, type SyntheticEvent } from 'react';

export interface DotsProfilePhotoProps {
  /** Image URL. Without `src` (or when it fails to load) a gradient placeholder is painted. */
  src?: string;
  /** Alt text; also seeds the gradient placeholder. */
  alt?: string;
  /** Width in px. Default 32 (44 with `bited`). */
  width?: number;
  /** Height in px. Default 32 (44 with `bited`). */
  height?: number;
  /** DotsProfilePhotoBited variant: bite at the bottom-right. */
  bited?: boolean;
  /** (bited only) Emoji/text of the reaction centered in the bite. */
  reaction?: string;
  /** (bited only) Bite size as a fraction of the diameter. Default 0.25. */
  biteSize?: number;
  /** (bited only) Bite offset (fractions of the diameter). Default { x: 0.85, y: 0.85 }. */
  biteOffset?: { x: number; y: number };
  /** Tap callback (Dart onTap). */
  onClick?: () => void;
  /** Image load error callback (Dart onError). */
  onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
  className?: string;
}

// Deterministic gradient placeholder when there is no `src` (or it fails to load)
function gradVariant(seed: string | undefined) {
  const s = seed ?? '';
  let n = 0;
  for (let i = 0; i < s.length; i++) n = (n + s.charCodeAt(i)) % 997;
  return 'abcd'[n % 4];
}

export function DotsProfilePhoto(props: DotsProfilePhotoProps) {
  const [hasError, setError] = useState(false);
  const bited = !!props.bited; // DotsProfilePhotoBited
  const width = props.width ?? (bited ? 44 : 32); // Dart defaults 32 / 44
  const height = props.height ?? (bited ? 44 : 32);
  const showImg = !!props.src && !hasError;

  const inner = showImg ? (
    <img
      className="ds-profile-photo__img"
      src={props.src}
      alt={props.alt ?? ''}
      onError={(e) => {
        setError(true);
        props.onError?.(e);
      }}
    />
  ) : (
    <span className={`ds-profile-photo__ph ds-profile-photo__ph--${gradVariant(props.src || props.alt)}`} />
  );

  const rootProps = {
    className: `ds-profile-photo${props.className ? ` ${props.className}` : ''}`,
    style: { width, height },
    onClick: props.onClick,
    role: props.onClick ? 'button' : undefined,
  };

  if (!bited) {
    return (
      <span {...rootProps}>
        <span className="ds-profile-photo__circle">{inner}</span>
      </span>
    );
  }

  // _BiteCircleClipper: circle of diameter min(w,h) minus a bite r = d*biteSize
  // centered at (d*biteOffset.x, d*biteOffset.y) — approximated with a radial mask.
  const biteSize = props.biteSize ?? 0.25;
  const off = props.biteOffset ?? { x: 0.85, y: 0.85 };
  const d = Math.min(width, height);
  const left = (width - d) / 2;
  const top = (height - d) / 2;
  const r = d * biteSize;
  const cx = left + d * off.x;
  const cy = top + d * off.y;
  const mask = `radial-gradient(circle ${r}px at ${cx}px ${cy}px, transparent ${r - 0.5}px, #000 ${r + 0.5}px)`;

  return (
    <span {...rootProps}>
      <span className="ds-profile-photo__circle" style={{ WebkitMask: mask, mask }}>
        {inner}
      </span>
      {/* Reaction — 2r×2r box centered on the bite (Dart: Positioned + Align.center) */}
      {props.reaction ? (
        <span className="ds-profile-photo__reaction" style={{ left: cx - r, top: cy - r, width: 2 * r, height: 2 * r }}>
          {props.reaction}
        </span>
      ) : null}
    </span>
  );
}
