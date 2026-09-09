import * as React from 'react';

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
export declare function DotsProgressBar(props: DotsProgressBarProps): import("react").JSX.Element;
export declare namespace DotsProgressBar {
    var byStep: (stepNumber: number, totalSteps: number) => import("react").JSX.Element;
}
