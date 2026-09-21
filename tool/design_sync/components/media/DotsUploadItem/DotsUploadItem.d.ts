import * as React from 'react';

import type { SyntheticEvent } from 'react';
/** Dart enum UploadItemVariant */
export type DotsUploadItemVariant = 'processing' | 'success' | 'error';
export interface DotsUploadItemProps {
    /** Image URL. Without `src` (or when it fails to load) a gradient placeholder is painted. */
    src?: string;
    alt?: string;
    /** Variant — Dart enum UploadItemVariant (falls back to 'processing') */
    variant: DotsUploadItemVariant;
    /** (processing) Progress 0..1 for the bar and the percentage. */
    percentage?: number;
    /** Date shown on top (bodyDefaultMedium). */
    textDate?: string;
    /** Status text next to the icon (labelDefaultRegular). */
    processText?: string;
    /**
     * Max lines of `processText` — Dart `processTextMaxLines` (default 1): 1 = one line with ellipsis,
     * n > 1 = clamped to n lines, `null` = free wrap (for messages that carry a file name). With more
     * than one line the row top-aligns and the icon drops 2px onto the first line, as in Dart.
     */
    processTextMaxLines?: number | null;
    /** (success) Elapsed time under the status. */
    timeElapsed?: string;
    /** (success/error) Text of the right button (DotsMainButton medium). Without it no button is rendered. */
    btnText?: string;
    /** (success/error) Callback of the right button (Dart btnOnTap). */
    onBtnClick?: () => void;
    /** Image load error callback (Dart onError). */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
    className?: string;
}
export declare function DotsUploadItem(props: DotsUploadItemProps): import("react").JSX.Element;
