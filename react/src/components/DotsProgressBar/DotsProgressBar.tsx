// DotsProgressBar — port of lib/src/components/progress_bar/dots_progress_bar.dart (Dart = source of truth).
// Conventional progress bar divided in parts: 5px tall rounded segments, gap `spaceBetween`.
export interface DotsProgressBarProps {
  /** Progress 0..1 — Dart `percentage` */
  percentage: number;
  /** Number of segments (> 0) — Dart `parts` (default 3) */
  parts?: number;
  /** Total width, px when a number — Dart `width` (default '100%') */
  width?: number | string;
  /** Gap between segments in px — Dart `spaceBetween` (default 5) */
  spaceBetween?: number;
  /** CSS color of the bar — Dart `barColor` (default labelHighlight) */
  barColor?: string;
  /** CSS color of the segment background — Dart `bgColor` (default labelSecondary) */
  bgColor?: string;
  className?: string;
}

export function DotsProgressBar(props: DotsProgressBarProps) {
  const percentage = Math.min(1, Math.max(0, props.percentage || 0));
  const parts = props.parts == null ? 3 : Math.max(1, props.parts);
  const spaceBetween = props.spaceBetween ?? 5;
  const width = props.width == null ? '100%' : typeof props.width === 'number' ? `${props.width}px` : props.width;
  const segs = [];
  for (let i = 0; i < parts; i++) {
    // filled fraction of each part (the Dart painter measures over the full width; gaps are negligible)
    const fill = Math.min(1, Math.max(0, percentage * parts - i));
    segs.push(
      <span key={i} className="ds-progress-bar__seg" style={props.bgColor ? { background: props.bgColor } : undefined}>
        <span className="ds-progress-bar__fill" style={{ width: `${fill * 100}%`, ...(props.barColor ? { background: props.barColor } : null) }} />
      </span>,
    );
  }
  return (
    <span
      className={`ds-progress-bar${props.className ? ` ${props.className}` : ''}`}
      style={{ width, gap: `${spaceBetween}px` }}
      role="progressbar"
      aria-valuemin={0}
      aria-valuemax={100}
      aria-valuenow={Math.round(percentage * 100)}
    >
      {segs}
    </span>
  );
}

/** Mirror of the Dart factory DotsProgressBar.byStep(stepNumber, totalSteps) */
DotsProgressBar.byStep = (stepNumber: number, totalSteps: number) => <DotsProgressBar percentage={stepNumber / totalSteps} />;
