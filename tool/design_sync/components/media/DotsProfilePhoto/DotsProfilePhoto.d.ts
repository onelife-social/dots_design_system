import * as React from 'react';

import { type SyntheticEvent } from 'react';
export interface DotsProfilePhotoProps {
    /** Image URL. Without `src` (or when it fails to load) a gradient placeholder is painted. */
    src?: string;
    /** Alt text; also seeds the gradient placeholder. */
    alt?: string;
    /** Width in px. Default 32 (44 with `bited`). */
    width?: number;
    /** Height in px. Default 32 (44 with `bited`). */
    height?: number;
    /** DotsProfilePhotoBited variant: bite at the bottom-right. */
    bited?: boolean;
    /** (bited only) Emoji/text of the reaction centered in the bite. */
    reaction?: string;
    /** (bited only) Bite size as a fraction of the diameter. Default 0.25. */
    biteSize?: number;
    /** (bited only) Bite offset (fractions of the diameter). Default { x: 0.85, y: 0.85 }. */
    biteOffset?: {
        x: number;
        y: number;
    };
    /** Tap callback (Dart onTap). */
    onClick?: () => void;
    /** Image load error callback (Dart onError). */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
    className?: string;
}
export declare function DotsProfilePhoto(props: DotsProfilePhotoProps): import("react").JSX.Element;
