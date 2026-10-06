import * as React from 'react';

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
export declare function DotsSpinner({ progress: rawProgress, size, strokeWidth, showPercentage, tone, indeterminate, className, }: DotsSpinnerProps): import("react").JSX.Element;
