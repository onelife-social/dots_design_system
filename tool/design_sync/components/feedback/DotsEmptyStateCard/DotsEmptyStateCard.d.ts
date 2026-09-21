import * as React from 'react';

import type { ReactNode } from 'react';
/** Dart enum DotsEmptyStateCardVariant */
export type DotsEmptyStateCardVariant = 'image' | 'icon';
export interface DotsEmptyStateCardProps {
    /** Variant — Dart enum DotsEmptyStateCardVariant */
    variant: DotsEmptyStateCardVariant;
    /** Image URL (variant image) — Dart `imageProvider` */
    image?: string;
    /** Variant icon: DotsIcon name (48px textQuarternary) or a prebuilt node — Dart `icon` (a DotsIcon) */
    icon?: string | ReactNode;
    /** Title, title02H5 (P22 Mackinac 20/500) — Dart `title` */
    title: string;
    /** Description, bodyDefaultRegular textQuarternary — Dart `description` */
    description: string;
    /** CSS color of the title — Dart `titleColor` */
    titleColor?: string;
    /** CSS color of the description — Dart `descriptionColor` */
    descriptionColor?: string;
    /** Optional button (usually a DotsMainButton) — Dart `button` */
    button?: ReactNode;
    /** Extra space (px) after the image — Dart `extraSpaceAfterImage` */
    extraSpaceAfterImage?: number;
    /** Image width (px) — Dart `imageWidth` */
    imageWidth?: number;
    /** Rich description rendered instead of `description` (kept as aria-label) — Dart `descriptionSpans` */
    descriptionSpans?: ReactNode;
    className?: string;
}
export declare function DotsEmptyStateCard(props: DotsEmptyStateCardProps): import("react").JSX.Element;
