import * as React from 'react';

import { type SyntheticEvent } from 'react';
/** Dart enum ActivityPreviewVariant */
export type ActivityPreviewVariant = 'reactions' | 'views' | 'favs';
/**
 * ActivityPreview — web port of ActivityPreview (Flutter). 3:4 card (r24, shadow, border)
 * with a background image and a bottom blur pill: reaction emojis or icon (eye/heart)
 * + already-formatted number.
 */
export interface ActivityPreviewProps {
    /** Dart enum ActivityPreviewVariant (default 'reactions') */
    variant?: ActivityPreviewVariant;
    /** Background image URL (Dart `image`). Without src → gradient placeholder */
    src?: string;
    /** Reaction emojis (variant reactions only) */
    reactions?: string[];
    /** ALREADY formatted number ('123', '1.2K'…) — as in Dart */
    number?: string;
    /** Dart onCardTap */
    onCardClick?: () => void;
    /** Dart onError (image load error) */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
    className?: string;
}
/**
 * ActivityPreview.OverviewItem — web port of ActivityOverviewItem (Flutter). 53×68 photo
 * stack (second photo rotated -5°) with a variant badge in the corner, counter, title and
 * a "+N" row with overlapping avatars.
 */
export interface ActivityOverviewItemProps {
    /** Photo URLs; the first in front, the last behind rotated (Dart `images`) */
    images?: string[];
    /** DotsIcon name of the badge (Dart `icon: Widget`) */
    icon: string;
    /** CSS color of the badge icon (default labelAlwaysWhite) */
    iconColor?: string;
    /** Variant — colors the badge: reactions→friends001, views→hobby002, favs→couple001 */
    variant: ActivityPreviewVariant;
    /** Counter under the stack (formatted with k/M/B) */
    count: number;
    /** Title under the counter */
    title: string;
    /** Total reactions; > 0 shows the "+N" row */
    reactionsCount: number;
    /** User avatar URLs (overlapping 10px, 17px circles) */
    userImages: string[];
    /** Photo width (default 53) */
    width?: number;
    /** Photo height (default 68) */
    height?: number;
    /** Photo radius (default 12) */
    borderRadius?: number;
    /** Inner white border width (default 1) */
    borderWidth?: number;
    /** Max avatars shown (default 2) */
    maxUserImages?: number;
    /** Load error of any photo */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
    className?: string;
}
export declare function ActivityPreview(props: ActivityPreviewProps): import("react").JSX.Element;
export declare namespace ActivityPreview {
    var OverviewItem: typeof ActivityOverviewItem;
}
export declare function ActivityOverviewItem(props: ActivityOverviewItemProps): import("react").JSX.Element;
