import * as React from 'react';

import type { SyntheticEvent } from 'react';
/** Dart enum DotsListsItemVariant */
export type DotsListItemVariant = 'main' | 'selector' | 'icon' | 'check' | 'radioButton' | 'chevron' | 'divider';
/** Dart enum DotsListsItemPicType */
export type DotsListItemPicType = 'album' | 'user';
/** Dart enum DotsListsItemLabelStyle */
export type DotsListItemLabelStyle = 'regular' | 'bold';
export interface DotsListItemProps {
    /** Variant — Dart enum DotsListsItemVariant (default 'main') */
    variant?: DotsListItemVariant;
    /** Row text (or section title in variant divider) */
    label?: string;
    /** Second line under the label — Dart `subtitle`. Empty counts as absent; ignored in variant divider */
    subtitle?: string;
    /** Image URL/data URI — Dart `image` (ImageProvider) */
    imageSrc?: string;
    /** Thumbnail shape when there is an image — Dart enum DotsListsItemPicType (default 'album') */
    picType?: DotsListItemPicType;
    /** Label style — Dart enum DotsListsItemLabelStyle (default 'regular' = bodyDefaultMedium; 'bold' = bodyLargeBold). Ignored in variant divider */
    labelStyle?: DotsListItemLabelStyle;
    /** Icon name (asset ic-…) for variant icon or when there is no image — Dart `iconData` (default 'ic-user') */
    iconName?: string;
    /** Tap on the whole row — Dart `onTap` */
    onClick?: () => void;
    /** Image load error of picType user — Dart `onError` */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
}
export declare function DotsListItem(props: DotsListItemProps): import("react").JSX.Element;
