// DotsSpinner — port of lib/src/components/spinner/spinner_round.dart (SpinnerRound).
export type DotsSpinnerTone = 'onPhoto' | 'accent';

export interface DotsSpinnerProps {
  /** Progress 0..1 — Dart `progress` */
  progress?: number;
  /** Side in px — Dart `size`. Default: 43 */
  size?: number;
  /** Stroke width — Dart `strokeWidth`. Default: 4 */
  strokeWidth?: number;
  /** Show the centered percentage — Dart `showPercentage`. Default: true */
  showPercentage?: boolean;
  /** Color set — Dart `tone`. 'onPhoto' (white, over photos) or 'accent' (blue, light backgrounds). Default: 'onPhoto' */
  tone?: DotsSpinnerTone;
  /** Web extension: spins forever (ignores `progress`, hides the %) */
  indeterminate?: boolean;
  className?: string;
}

export function DotsSpinner({
  progress: rawProgress = 0,
  size = 43,
  strokeWidth = 4,
  showPercentage = true,
  tone = 'onPhoto',
  indeterminate = false,
  className,
}: DotsSpinnerProps) {
  const progress = Math.min(1, Math.max(0, rawProgress));
  const half = size / 2;
  const r = (size - strokeWidth) / 2;
  const c = 2 * Math.PI * r;
  const arc = indeterminate ? 0.25 * c : progress * c;
  // accent + indeterminate: the arc is a conic gradient with a fading tail (Figma "Spinner Gradient")
  const gradientArc = indeterminate && tone === 'accent';
  const cls = [
    'ds-spinner',
    tone === 'accent' && 'ds-spinner--accent',
    indeterminate && 'ds-spinner--indeterminate',
    className,
  ].filter(Boolean).join(' ');
  return (
    <span
      className={cls}
      style={{ width: size, height: size, ['--ds-spinner-stroke' as string]: `${strokeWidth}px` }}
      role="progressbar"
      aria-valuemin={0}
      aria-valuemax={100}
      aria-valuenow={indeterminate ? undefined : Math.floor(progress * 100)}
    >
      <svg className="ds-spinner__svg" viewBox={`0 0 ${size} ${size}`} width={size} height={size}>
        {/* Track — onPhoto: bgBtnImage · accent: bgContainerSecondaryOnBackground */}
        <circle className="ds-spinner__track" cx={half} cy={half} r={r} fill="none" strokeWidth={strokeWidth} />
        {/* Progress arc — onPhoto: labelAlwaysWhite · accent: labelHighlight; starts at the top (startAngle 270°) */}
        {gradientArc ? null : (
          <circle
            className="ds-spinner__arc"
            cx={half}
            cy={half}
            r={r}
            fill="none"
            strokeWidth={strokeWidth}
            // A zero-length dash with a round cap still paints a dot, so use butt at 0%
            strokeLinecap={arc === 0 ? 'butt' : 'round'}
            strokeDasharray={`${arc} ${c}`}
            transform={`rotate(-90 ${half} ${half})`}
          />
        )}
      </svg>
      {gradientArc ? <span className="ds-spinner__gradient" /> : null}
      {showPercentage && !indeterminate ? (
        <span className="ds-spinner__pct">{Math.floor(progress * 100)}%</span>
      ) : null}
    </span>
  );
}
