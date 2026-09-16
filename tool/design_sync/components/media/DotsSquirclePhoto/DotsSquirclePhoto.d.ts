import * as React from 'react';

import { type SyntheticEvent } from 'react';
export interface DotsSquirclePhotoProps {
    /** Image URL. Without `src` (or when it fails to load) a gradient placeholder is painted. */
    src?: string;
    /** Alt text; also seeds the gradient placeholder. */
    alt?: string;
    /** Side in px (square). Default 52. */
    size?: number;
    /** Radius (number → px). Default 16 (DotsBorderRadius.r16). */
    borderRadius?: number | string;
    /** Hide the border. Default true. */
    hideBorder?: boolean;
    /** Border width in px. Default 1. */
    borderSize?: number;
    /** CSS color of the border. Default `var(--bg-btn-image)` (bgBtnImage at 60%). */
    borderColor?: string;
    /** Upload-error overlay (black 20% + centered white icon). Default false. */
    uploadError?: boolean;
    /** Icon of the error overlay. Default 'ic-cloud-fail' (DotsIconData.cloudFail). */
    uploadErrorIcon?: string;
    /** Tap callback (Dart onTap). */
    onClick?: () => void;
    /** Image load error callback (Dart onError). */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
    className?: string;
}
export interface DotsSquirclePhotoTagProps {
    /** Image URL. Without `src` (or when it fails to load) a gradient placeholder is painted. */
    src?: string;
    /** Alt text; also seeds the gradient placeholder. */
    alt?: string;
    /** Image side in px (canvas = size + 10). Default 100. */
    size?: number;
    /** Radius. Default 24 (DotsBorderRadius.r24). */
    borderRadius?: number | string;
    /** Border color. Default `var(--label-always-white)`. */
    borderColor?: string;
    /** Border width. Default 2. */
    borderSize?: number;
    /** Tag icon. Default 'ic-calendar--check' (DotsIconData.calendarCheck). */
    icon?: string;
    /** Icon size. Default 24. */
    iconSize?: number;
    /** Icon color. Default `var(--label-always-white)`. */
    iconColor?: string;
    /** Tag circle diameter. Default 40. */
    tagCircleSize?: number;
    /** Tap callback (Dart onTap). */
    onClick?: () => void;
    /** Image load error callback (Dart onError). */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
    className?: string;
}
export declare function DotsSquirclePhoto(props: DotsSquirclePhotoProps): import("react").JSX.Element;
export declare namespace DotsSquirclePhoto {
    var Tag: typeof DotsSquirclePhotoTag;
}
/** Mirror of the Dart DotsSquircleImageTag — (size+10)² canvas, bordered image + 40px tag circle bottom-right */
export declare function DotsSquirclePhotoTag(props: DotsSquirclePhotoTagProps): import("react").JSX.Element;
