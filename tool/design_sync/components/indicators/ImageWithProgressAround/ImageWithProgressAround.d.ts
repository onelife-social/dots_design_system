import * as React from 'react';

/** 'standard' = 9:16 (kStandardAspectRatio) · 'small' = 3:4 (kSmallAspectRatio, isSmallScreen) */
export type ImageWithProgressAroundAspectRatio = 'standard' | 'small';
export interface ImageWithProgressAroundProps {
    /** Progress 0..1 — Dart `progress`. Values > 1 are read as a percentage (72 → 0.72). */
    progress: number;
    /** Width in px — Dart `width`. Default: 150. The height comes from the aspect ratio. */
    width?: number;
    /** Center image URL (the Dart `imageProvider`). Without it, a design placeholder. */
    src?: string;
    /** Image alt text */
    alt?: string;
    /** `standard` = 9:16 (kStandardAspectRatio) · `small` = 3:4 (kSmallAspectRatio, isSmallScreen). Default: 'standard' */
    aspectRatio?: ImageWithProgressAroundAspectRatio;
    /** Ring thickness — Dart `progressBarWidth`. Default: 6 */
    progressBarWidth?: number;
    /** Gap image↔ring — Dart `innerPadding`. Default: 8 */
    innerPadding?: number;
    /** Inner image radius — Dart `borderRadius`. Default: 45 */
    borderRadius?: number;
    /** CSS colors of the ring gradient — Dart `progressBarColors`. Default: DotsColors.recapGradientColors */
    progressBarColors?: string[];
    className?: string;
}
export declare function ImageWithProgressAround(props: ImageWithProgressAroundProps): import("react").JSX.Element;
