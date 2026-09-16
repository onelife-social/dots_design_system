import * as React from 'react';

/** Mirror of the Dart enum MilestoneBadgeType */
export type MilestoneBadgeType = 'video' | 'description' | 'audio';
export interface MilestoneCardProps {
    /** Width in px — Dart `width`. > 150 ⇒ big (r32); otherwise small (r24). Height = 4/3 of the width. Default 170 */
    width?: number;
    /** Photo URL — Dart `imageProvider`. Without src the placeholder (defaultImage) is painted */
    src?: string;
    /** Title centered over the top blur — Dart `title` */
    title?: string;
    /** Limit the title to 1 line with ellipsis — Dart `limitTitle` (default false) */
    limitTitle?: boolean;
    /** Date under the title — Dart `date` */
    date?: string;
    /** Dart `onTap` (tap on the photo/card) */
    onClick?: () => void;
    /** Show the badge-milestone-1.svg badge top-right — Dart `showBadge` (default false) */
    showBadge?: boolean;
    /** Show the edit button (DotsIconButton pencil) — Dart `showEdit` (default false) */
    showEdit?: boolean;
    /** Dart `onTapEdit` */
    onClickEdit?: () => void;
    /** Selection mark (Flutter uses it for the list auto-scroll) */
    isSelected?: boolean;
    /** Content badges, max 3 — Dart `badgeTypes` (default []) */
    badgeTypes?: MilestoneBadgeType[];
    /** Dart `onBadgesTap` */
    onBadgesClick?: () => void;
    className?: string;
}
export declare function MilestoneCard(props: MilestoneCardProps): import("react").JSX.Element;
export declare namespace MilestoneCard {
    var badgeTypes: Record<MilestoneBadgeType, {
        icon: string;
        color: string;
    }>;
}
