import * as React from 'react';

export type DotsIconButtonSize = 'enormous' | 'extraLarge' | 'large' | 'medium' | 'small' | 'extraSmall';
export type DotsIconButtonStyle = 'defaultStyle' | 'onPhoto' | 'floating' | 'noBackground';
export type DotsIconButtonState = 'defaultState' | 'active' | 'disabled' | 'destructive';
export interface DotsIconButtonProps {
    /** DotsIcon name (real asset, e.g. 'ic-heart') */
    icon: string;
    /** Icon size in px — defaults to the size's own */
    iconSize?: number;
    /** Optional label below/next to the button */
    label?: string;
    /** Notification badge text (BadgeTag) */
    tag?: string;
    /** Dart enum DotsIconButtonSize (diameter 56/52/44/36/28/22) */
    size?: DotsIconButtonSize;
    /** @deprecated use style + state — Dart enum DotsIconButtonVariant */
    variant?: 'solid' | 'photo' | 'active' | 'noBackground' | 'photoDisable';
    /** Dart enum DotsIconButtonStyle */
    style?: DotsIconButtonStyle;
    /** Dart enum DotsIconButtonState */
    state?: DotsIconButtonState;
    /** Dart enum DotsIconButtonDirection — label placement */
    direction?: 'column' | 'row';
    /** Dart onTap */
    onClick?: () => void;
    /** CSS color forcing icon and label */
    color?: string;
    /** CSS color forcing the circle background */
    backgroundColor?: string;
    /** When true, the label also triggers onClick */
    textTappable?: boolean;
    /** Apply backdrop blur (default true) */
    shouldApplyBlur?: boolean;
    /** shadowFolder shadow around the circle */
    showShadow?: boolean;
    /** 'ellipsis' → 1 line with ellipsis; undefined → 2 lines */
    overflow?: 'ellipsis';
}
export declare function DotsIconButton(props: DotsIconButtonProps): import("react").JSX.Element;
