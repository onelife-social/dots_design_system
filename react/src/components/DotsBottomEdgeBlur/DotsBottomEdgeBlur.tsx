// DotsBottomEdgeBlur — port of lib/src/components/containers/dots_bottom_edge_blur.dart (Dart = source of truth).
import type { CSSProperties, ReactNode } from 'react';

export interface DotsBottomEdgeBlurProps {
  /** Content the blur band is painted over — Dart `child` */
  children?: ReactNode;
  /** Height in px of the blurred bottom band — Dart `edgeSize`. With 0 nothing is painted over the content */
  edgeSize: number;
  /**
   * Blur strength at the very bottom of the band — Dart `sigma` (default 12). Flutter's ImageFilter.blur
   * sigma and CSS `blur()` are both the Gaussian standard deviation, so it is applied 1:1 as px. With 0,
   * passthrough.
   */
  sigma?: number;
  className?: string;
}

/**
 * The Dart paints a blurred copy of the child (ImageFiltered + ShaderMask) because Flutter's
 * BackdropFilter samples in screen space and shimmers on Impeller while scrolling. On the web
 * `backdrop-filter` has no such problem, so the port is a masked band over the content: same result
 * without duplicating the DOM — which is why the Dart `blurChild` slot has no web counterpart.
 */
export function DotsBottomEdgeBlur(props: DotsBottomEdgeBlurProps) {
  const sigma = props.sigma ?? 12;

  // Dart: `if (edgeSize <= 0 || sigma <= 0) return child;` — the child is returned unwrapped so its
  // layout is untouched (margin collapsing, flex/grid…). `!(x > 0)` also covers a NaN/undefined
  // edgeSize coming from untyped callers. A className still needs a container to land on, but WITHOUT
  // the component class: `ds-bottom-edge-blur` only exists to host the absolute band, and its
  // `position: relative` would become the containing block of absolute descendants for nothing.
  if (!(props.edgeSize > 0) || !(sigma > 0)) {
    return props.className ? <div className={props.className}>{props.children}</div> : <>{props.children}</>;
  }

  return (
    <div className={`ds-bottom-edge-blur${props.className ? ` ${props.className}` : ''}`}>
      {props.children}
      <div
        className="ds-bottom-edge-blur__band"
        aria-hidden
        style={{ height: props.edgeSize, '--ds-beb-sigma': `${sigma}px` } as CSSProperties}
      />
    </div>
  );
}
