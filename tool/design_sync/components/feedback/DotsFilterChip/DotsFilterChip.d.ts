import * as React from 'react';

export interface DotsFilterChipProps {
    /** Filter text, labelDefaultBold textSecondary — Dart `label` */
    label?: string;
    /** Fired when the chip (including the cross) is tapped — Dart `onTap` */
    onClick?: () => void;
}
export declare function DotsFilterChip(props: DotsFilterChipProps): import("react").JSX.Element;
