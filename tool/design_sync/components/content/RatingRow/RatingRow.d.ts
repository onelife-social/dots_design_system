import * as React from 'react';

/** Dart enum RatingIconVariant */
export type RatingStarVariant = 'disabled' | 'detractor' | 'neutral' | 'promoter';
export interface RatingRowProps {
    /** Star labels — Dart requires length 5 or 10 */
    starLabels: string[];
    /** Bottom-left text (default layout only) */
    leftText?: string;
    /** Bottom-right text (default layout only) */
    rightText?: string;
    /** Selected star index; null/undefined → all disabled */
    selectedIndex?: number | null;
    /** Called when a star is tapped */
    onStarTap?: (index: number) => void;
    /** Compact layout: centered rows of 6+4 (with 10 stars) */
    compact?: boolean;
    /** Show the label above each star (default true) */
    showStarText?: boolean;
    /** Star icon size in px — default 28 */
    iconSize?: number;
}
export declare function RatingRow(props: RatingRowProps): import("react").JSX.Element;
