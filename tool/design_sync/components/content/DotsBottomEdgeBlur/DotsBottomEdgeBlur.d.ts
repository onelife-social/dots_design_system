import * as React from 'react';

import type { ReactNode } from 'react';
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
export declare function DotsBottomEdgeBlur(props: DotsBottomEdgeBlurProps): import("react").JSX.Element;
