import * as React from 'react';

export interface PageControlProps {
    /** Total number of dots — Dart `count` */
    count: number;
    /** Active index, clamped to [0, count-1] — Dart `activeIndex`. Default: 0 */
    activeIndex?: number;
    /** Variant — Dart enum PageControlVariant. Default: 'main' */
    variant?: 'main' | 'background';
    /** Color of inactive dots — Dart `dotColor`. Default: labelSecondary */
    dotColor?: string;
    /** Color of the active dot — Dart `activeColor`. Default: labelPrimary (main) / labelActive (background) */
    activeColor?: string;
    className?: string;
}
export declare function PageControl({ count, activeIndex: rawIndex, variant: rawVariant, dotColor, activeColor, className }: PageControlProps): import("react").JSX.Element;
