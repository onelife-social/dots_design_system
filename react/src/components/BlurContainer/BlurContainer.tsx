// BlurContainer — port of lib/src/components/containers/blur_container.dart and
// dots_linear_gradient_blur.dart (Dart = source of truth).
// Web approximation: blur shader → CSS filter; progressive blur →
// backdrop-filter + gradient mask-image (same technique as screens/home.html).
import type { CSSProperties, ReactNode } from 'react';

/** Flutter Alignment (subset of 9 positions) */
export type BlurAlignment =
  | 'topLeft'
  | 'topCenter'
  | 'topRight'
  | 'centerLeft'
  | 'center'
  | 'centerRight'
  | 'bottomLeft'
  | 'bottomCenter'
  | 'bottomRight';

export interface BlurContainerProps {
  /** Blur amount in px (Dart sigma, clamped 0–5) */
  sigma: number;
  /** Content to blur — Dart `child` */
  children?: ReactNode;
  /** Extra CSS class */
  className?: string;
}

export interface GradientBlurProps {
  /** Blur deviation in px — Dart `sigma` (default 8) */
  sigma?: number;
  /** Blur strength at each stop, 0 (none) to 1 (full) — Dart LinearGradientBlur.values (default [0, 1]) */
  values?: number[];
  /** 0–1 positions of each value — Dart LinearGradientBlur.stops (default evenly spaced) */
  stops?: number[];
  /** Gradient start (default 'topCenter') — Dart LinearGradientBlur.start */
  start?: BlurAlignment;
  /** Gradient end (default 'bottomCenter') — Dart LinearGradientBlur.end */
  end?: BlurAlignment;
  /** CSS tint color over the blurred area — Dart `tintColor` (default transparent) */
  tintColor?: string;
  /** Content — Dart `child` */
  children?: ReactNode;
  /** Extra CSS class */
  className?: string;
}

// Flutter Alignment → coordinates (x→, y↓)
const ALIGN: Record<BlurAlignment, [number, number]> = {
  topLeft: [-1, -1],
  topCenter: [0, -1],
  topRight: [1, -1],
  centerLeft: [-1, 0],
  center: [0, 0],
  centerRight: [1, 0],
  bottomLeft: [-1, 1],
  bottomCenter: [0, 1],
  bottomRight: [1, 1],
};

function clamp01(v: number) {
  v = +v;
  if (!(v >= 0)) return 0;
  return v > 1 ? 1 : v;
}

/** DotsLinearGradientBlur — progressive blur defined by values/stops/start/end + tint. */
function GradientBlur(props: GradientBlurProps) {
  const sigma = props.sigma == null ? 8 : +props.sigma; // Dart requires it; 8 = typical home usage
  const values = Array.isArray(props.values) && props.values.length ? props.values : [0, 1];
  const stops =
    Array.isArray(props.stops) && props.stops.length === values.length
      ? props.stops
      : values.map((_, i) => (values.length === 1 ? 0 : i / (values.length - 1)));
  const s = (props.start && ALIGN[props.start]) || ALIGN.topCenter;
  const e = (props.end && ALIGN[props.end]) || ALIGN.bottomCenter;
  const dx = e[0] - s[0];
  const dy = e[1] - s[1];
  // CSS angle: 0deg = up, clockwise. Vector start→end with y pointing down.
  const angle = dx === 0 && dy === 0 ? 180 : (Math.atan2(dx, -dy) * 180) / Math.PI;

  // The mask replicates the shader texture: alpha = blur strength at each point
  const parts = values.map((v, i) => `rgba(0,0,0,${clamp01(v)}) ${clamp01(stops[i]) * 100}%`);
  const grad = `linear-gradient(${angle.toFixed(2)}deg, ${parts.join(', ')})`;

  const overlayStyle: CSSProperties = {
    backdropFilter: `blur(${sigma}px)`,
    WebkitBackdropFilter: `blur(${sigma}px)`,
    maskImage: grad,
    WebkitMaskImage: grad,
  };
  if (props.tintColor) overlayStyle.background = props.tintColor; // Dart: tintColor (default transparent)

  return (
    <div className={`ds-gradient-blur${props.className ? ` ${props.className}` : ''}`}>
      {props.children}
      <div className="ds-gradient-blur__overlay" aria-hidden style={overlayStyle} />
    </div>
  );
}

/** BlurContainer(sigma 0–5, child) — blurs ALL its content (BlurPainter). */
export function BlurContainer(props: BlurContainerProps) {
  let sigma = +props.sigma;
  if (!(sigma >= 0)) sigma = 0;
  if (sigma > 5) sigma = 5; // Dart assert: 0.0–5.0
  const style: CSSProperties | undefined = sigma > 0 ? { filter: `blur(${sigma}px)`, WebkitFilter: `blur(${sigma}px)` } : undefined;
  return (
    <div className={`ds-blur-container${props.className ? ` ${props.className}` : ''}`} style={style}>
      {props.children}
    </div>
  );
}

/** Port of DotsLinearGradientBlur (progressive blur) */
BlurContainer.GradientBlur = GradientBlur;
