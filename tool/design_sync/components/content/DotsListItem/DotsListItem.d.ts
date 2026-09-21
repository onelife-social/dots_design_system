import * as React from 'react';

import type { SyntheticEvent } from 'react';
/** Dart enum DotsListsItemVariant */
export type DotsListItemVariant = 'main' | 'selector' | 'icon' | 'check' | 'radioButton' | 'divider';
/** Dart enum DotsListsItemPicType */
export type DotsListItemPicType = 'album' | 'user';
export interface DotsListItemProps {
    /** Variant — Dart enum DotsListsItemVariant (default 'main') */
    variant?: DotsListItemVariant;
    /** Row text (or section title in variant divider) */
    label?: string;
    /** Image URL/data URI — Dart `image` (ImageProvider) */
    imageSrc?: string;
    /** Thumbnail shape when there is an image — Dart enum DotsListsItemPicType (default 'album') */
    picType?: DotsListItemPicType;
    /** Icon name (asset ic-…) for variant icon or when there is no image — Dart `iconData` (default 'ic-user') */
    iconName?: string;
    /** Tap on the whole row — Dart `onTap` */
    onClick?: () => void;
    /** Image load error of picType user — Dart `onError` */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
}
export declare function DotsListItem(props: DotsListItemProps): import("react").JSX.Element;
