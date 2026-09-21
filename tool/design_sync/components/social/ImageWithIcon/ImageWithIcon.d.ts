import * as React from 'react';

import { type CSSProperties, type SyntheticEvent } from 'react';
/**
 * ImageWithIcon — web port of ImageWithIcon (Flutter). 53×68 (or circular) thumbnail with a
 * top gradient, inner white border and a circular icon badge at the top-right corner.
 * Without image it can show an initial (aliasLabelImageText).
 */
export interface ImageWithIconProps {
    /** Image URL (Dart `image`). On load error → defaultImage (default_user_item) */
    src?: string;
    /** DotsIcon name of the badge (Dart `icon: Widget`) */
    icon?: string;
    /** CSS color of the icon (default theme/currentColor) */
    iconColor?: string;
    /** Icon size (default 18; badge = iconSize × 1.5) */
    iconSize?: number;
    /** Custom badge offset; by default it overhangs by half */
    iconOffset?: number;
    /** Width (default 53) */
    width?: number;
    /** Height (default 68) */
    height?: number;
    /** Radius (default 12; with circularImage → width/2) */
    borderRadius?: number;
    /** Inner white border width (default 2) */
    borderWidth?: number;
    /** Circular image/alias instead of a rounded rectangle */
    circularImage?: boolean;
    /** Show the badge (default true) */
    showIcon?: boolean;
    /** Initial shown when there is no src — Nunito 600 40, textTertiary */
    aliasLabelImageText?: string;
    /** Inline CSS style for the alias text (Dart aliasLabelImageTextStyle) */
    aliasLabelImageTextStyle?: CSSProperties;
    /** Image load error */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
    className?: string;
}
export declare function ImageWithIcon(props: ImageWithIconProps): import("react").JSX.Element;
