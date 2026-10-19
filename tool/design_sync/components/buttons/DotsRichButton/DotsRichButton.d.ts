import * as React from 'react';

export interface DotsRichButtonProps {
    /** Size — Dart enum DotsRichButtonSize (large 358×75 r100 · medium 358×60 r32 · small 248×60 r32) */
    size?: 'large' | 'medium' | 'small';
    /** Center text size — Dart enum DotsRichButtonTextSize */
    textSize?: 'large' | 'medium';
    /** Leading DotsIcon name (e.g. 'ic-pics') — Dart `icon` */
    icon?: string;
    /** CSS color of the leading icon — Dart `iconColor` (default textSecondary) */
    iconColor?: string;
    /** Leading 32×32 image URL (takes precedence over `icon`) — Dart `image` */
    image?: string;
    /** Main text — Dart `content` */
    content: string;
    /** Secondary text under the main one — Dart `details` */
    details?: string;
    /** Trailing text; without it a chevron is shown. Also enables the red dot — Dart `trailingText` */
    trailingText?: string;
    /** Tap — Dart `onTap` */
    onClick?: () => void;
    /** When false, DotsMainButton's disabled colors are painted and clicks are ignored (default true) — Dart `enabled` */
    enabled?: boolean;
    /** Replaces leading, content and trailing with a centered spinner and blocks clicks (default false) — Dart `isLoading` */
    isLoading?: boolean;
}
export declare function DotsRichButton(props: DotsRichButtonProps): import("react").JSX.Element;
