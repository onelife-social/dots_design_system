// ImageWithProgressAround — port of lib/src/components/progress_bar/image_with_progress_around.dart (Dart = source of truth).
import { useRef } from 'react';

/** 'standard' = 9:16 (kStandardAspectRatio) · 'small' = 3:4 (kSmallAspectRatio, isSmallScreen) */
export type ImageWithProgressAroundAspectRatio = 'standard' | 'small';

export interface ImageWithProgressAroundProps {
  /** Progress 0..1 — Dart `progress`. Values > 1 are read as a percentage (72 → 0.72). */
  progress: number;
  /** Width in px — Dart `width`. Default: 150. The height comes from the aspect ratio. */
  width?: number;
  /** Center image URL (the Dart `imageProvider`). Without it, a design placeholder. */
  src?: string;
  /** Image alt text */
  alt?: string;
  /** `standard` = 9:16 (kStandardAspectRatio) · `small` = 3:4 (kSmallAspectRatio, isSmallScreen). Default: 'standard' */
  aspectRatio?: ImageWithProgressAroundAspectRatio;
  /** Ring thickness — Dart `progressBarWidth`. Default: 6 */
  progressBarWidth?: number;
  /** Gap image↔ring — Dart `innerPadding`. Default: 8 */
  innerPadding?: number;
  /** Inner image radius — Dart `borderRadius`. Default: 45 */
  borderRadius?: number;
  /** CSS colors of the ring gradient — Dart `progressBarColors`. Default: DotsColors.recapGradientColors */
  progressBarColors?: string[];
  className?: string;
}

// DotsColors.recapGradientColors (SweepGradient of the painter → approx. SVG linearGradient)
const RECAP_GRADIENT = ['#EF5FC1', '#C982F7', '#15ABF3', '#B295B6', '#F5784D', '#EF9C5F', '#F44E69', '#EF5FC1'];
let uid = 0;

export function ImageWithProgressAround(props: ImageWithProgressAroundProps) {
  const idRef = useRef<string | null>(null);
  if (idRef.current == null) idRef.current = `ds-iwpa-grad-${++uid}`;
  const gradId = idRef.current;

  const width = props.width ?? 150;
  // kStandardAspectRatio 9/16 · kSmallAspectRatio 3/4 (isSmallScreen)
  const ratio = props.aspectRatio === 'small' ? 3 / 4 : 9 / 16;
  const height = Math.round(width / ratio);
  const stroke = props.progressBarWidth ?? 6;
  const pad = props.innerPadding ?? 8;
  const br = props.borderRadius ?? 45;
  // Dart normalisation: > 1 is treated as a percentage
  const raw = props.progress || 0;
  const progress = raw > 1 ? Math.min(1, raw / 100) : Math.max(0, Math.min(1, raw));
  const colors = props.progressBarColors && props.progressBarColors.length ? props.progressBarColors : RECAP_GRADIENT;

  const half = stroke / 2;
  // painter radius: borderRadius + padding + strokeWidth/2
  let rx = br + pad + half;
  const rw = width - stroke;
  const rh = height - stroke;
  rx = Math.min(rx, rw / 2, rh / 2);
  // The <rect> path starts at (x+rx, y); the Dart painter starts at the top
  // center going clockwise → negative dashoffset to shift the start.
  const perimeter = 2 * (rw + rh) - 8 * rx + 2 * Math.PI * rx;
  const startShift = ((rw / 2 - rx) / perimeter) * 100;

  const stops = colors.map((c, i) => <stop key={i} offset={colors.length === 1 ? 0 : i / (colors.length - 1)} stopColor={c} />);

  return (
    <span
      className={`ds-iwpa${props.className ? ` ${props.className}` : ''}`}
      style={{ width: `${width}px`, height: `${height}px` }}
      role="progressbar"
      aria-valuemin={0}
      aria-valuemax={100}
      aria-valuenow={Math.round(progress * 100)}
    >
      <span className="ds-iwpa__inner" style={{ inset: `${pad + stroke}px`, borderRadius: `${br}px` }}>
        {props.src ? <img className="ds-iwpa__img" src={props.src} alt={props.alt || ''} /> : <span className="ds-iwpa__placeholder" />}
        {/* Black 20% overlay + centered % (titleH3, labelAlwaysWhite) */}
        <span className="ds-iwpa__overlay">
          <span className="ds-iwpa__pct">{`${Math.round(progress * 100)}%`}</span>
        </span>
      </span>
      <svg className="ds-iwpa__ring" viewBox={`0 0 ${width} ${height}`} width={width} height={height}>
        <defs>
          <linearGradient id={gradId} x1="0" y1="0" x2="1" y2="1">
            {stops}
          </linearGradient>
        </defs>
        {/* Track — bgSecondaryBtn */}
        <rect className="ds-iwpa__track" x={half} y={half} width={rw} height={rh} rx={rx} fill="none" strokeWidth={stroke} />
        {/* Progress — starts at the top center, clockwise */}
        {progress > 0 ? (
          <rect
            className="ds-iwpa__progress"
            x={half}
            y={half}
            width={rw}
            height={rh}
            rx={rx}
            fill="none"
            stroke={`url(#${gradId})`}
            strokeWidth={stroke}
            strokeLinecap="round"
            pathLength={100}
            strokeDasharray={`${progress * 100} 100`}
            strokeDashoffset={-startShift}
          />
        ) : null}
      </svg>
    </span>
  );
}
