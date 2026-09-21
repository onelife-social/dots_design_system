import * as React from 'react';

import type { ReactNode } from 'react';
/** Dart enum DotsToolTipTailPosition */
export type DotsToolTipTailPosition = 'topAlignLeadingEdge' | 'topAlignLeading' | 'topAlignCenter' | 'topAlignTrailing' | 'topAlignTrailingEdge' | 'bottomAlignLeadingEdge' | 'bottomAlignLeading' | 'bottomAlignCenter' | 'bottomAlignTrailing' | 'bottomAlignTrailingEdge';
export interface DotsTooltipProps {
    /** Tooltip text (labelDefaultMedium) — Dart `text` */
    text: string;
    /** Tail position — Dart enum DotsToolTipTailPosition. Required. */
    tailPosition: DotsToolTipTailPosition;
    /** DotsIcon name (32px, labelHighlight) — Dart `icon` (DotsIconData) */
    icon?: string;
    /** Custom icon node; wins over `icon` — Dart `iconWidget` */
    iconNode?: ReactNode;
    /** Shows DotsCloseButton small softContrast — Dart `showCloseButton` (default true) */
    showCloseButton?: boolean;
    /** Max width in px — Dart `maxWidth` (default 288) */
    maxWidth?: number;
    /** Tap on the body — Dart `onTap` */
    onClick?: () => void;
    /** Tap on the close button — Dart `onClose` */
    onClose?: () => void;
    className?: string;
}
export declare function DotsTooltip(props: DotsTooltipProps): import("react").JSX.Element;
