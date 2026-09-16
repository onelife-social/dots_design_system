import * as React from 'react';

import type { ReactNode } from 'react';
/** Flutter Alignment (subset of 9 positions) */
export type BlurAlignment = 'topLeft' | 'topCenter' | 'topRight' | 'centerLeft' | 'center' | 'centerRight' | 'bottomLeft' | 'bottomCenter' | 'bottomRight';
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
/** DotsLinearGradientBlur — progressive blur defined by values/stops/start/end + tint. */
export declare function GradientBlur(props: GradientBlurProps): import("react").JSX.Element;
/** BlurContainer(sigma 0–5, child) — blurs ALL its content (BlurPainter). */
export declare function BlurContainer(props: BlurContainerProps): import("react").JSX.Element;
export declare namespace BlurContainer {
    var GradientBlur: typeof import("./BlurContainer").GradientBlur;
}
