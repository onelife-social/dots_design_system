import * as React from 'react';

import type { ReactNode } from 'react';
export interface ProductCardProps {
    /** Main line, always visible */
    title: string;
    /** Background image (URL). Without it a gradient placeholder is painted */
    imageSrc?: string;
    /** Second line under the title */
    subtitle?: string;
    /** Third line, usually the price ("Desde 29,99 €") */
    caption?: string;
    /** Strikethrough value after `caption`, e.g. the previous price. Ignored without `caption` */
    captionPrevious?: string;
    /** Content of the top-right badge (e.g. a BadgeLabel) */
    badge?: ReactNode;
    /** Number of dots of the PageControl. `0` hides it */
    pageCount?: number;
    /** Index of the active dot */
    activePage?: number;
    /** DotsIcon name of the action button (default `ic-arrow-right`) */
    actionIcon?: string;
    /** Width / height. Default 1 (square, like the Figma component) */
    aspectRatio?: number;
    /** Dart onTap — the whole card */
    onClick?: () => void;
    /** Dart onActionTap. Without it the button is not painted */
    onActionClick?: () => void;
    /** Accessible name of the icon-only action button (localizable; default 'Open') */
    actionLabel?: string;
    className?: string;
}
export declare function ProductCard(props: ProductCardProps): import("react").JSX.Element;
