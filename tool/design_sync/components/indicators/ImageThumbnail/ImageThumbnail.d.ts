import * as React from 'react';

import type { ReactEventHandler } from 'react';
/** Dart enum DotsImageThumbnailVariant */
export type ImageThumbnailVariant = 'image' | 'icon';
export interface ImageThumbnailProps {
    /** Variant — Dart enum DotsImageThumbnailVariant. Default: 'image' */
    variant?: ImageThumbnailVariant;
    /** Image URL (variant image) — the Dart `image` (ImageProvider) */
    src?: string;
    /** Image alt text */
    alt?: string;
    /** Side in px — Dart `size`. Default: 40 */
    size?: number;
    /** DotsIcon name (variant icon) — Dart `iconData`. Default: 'ic-user' */
    icon?: string;
    /** Icon size — Dart `iconSize`. Default: 20 */
    iconSize?: number;
    /** CSS color of the icon — Dart `iconColor`. Default: text-secondary */
    iconColor?: string;
    /** Black 30% overlay over the image — Dart `coverImage`. Default: false */
    coverImage?: boolean;
    /** Image load error — Dart `onError` */
    onError?: ReactEventHandler<HTMLImageElement>;
    className?: string;
}
export declare function ImageThumbnail(props: ImageThumbnailProps): import("react").JSX.Element;
