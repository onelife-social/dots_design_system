import * as React from 'react';

import type { CSSProperties, ReactNode } from 'react';
/** Dart enum DotsMainContainerVariant */
export type DotsMainContainerVariant = 'main' | 'secondary' | 'onBackground' | 'tertiary';
export interface DotsMainContainerProps {
    /** Background variant (default 'main') — Dart enum DotsMainContainerVariant */
    variant?: DotsMainContainerVariant;
    /** CSS width or px (default 100%; Dart: screen width) */
    width?: number | string;
    /** CSS height or px; only applied with forceHeight (Dart: screen height) */
    height?: number | string;
    /** Content padding in px; only applied when there are children (default 16) */
    padding?: number | string;
    /** Radius in px (default: 24 when height ≤ 100, else 32) */
    radius?: number | string;
    /** CSS color overriding the variant background */
    backgroundColor?: string;
    /** Background image: URL/data URI or any CSS background-image value */
    backgroundImage?: string;
    /** Tap callback — Dart `onTap` (GestureDetector) */
    onClick?: () => void;
    /** Apply `height` when defined (default true) — Dart `forceHeight` */
    forceHeight?: boolean;
    /** Content — Dart `child` */
    children?: ReactNode;
    /** Extra inline style */
    style?: CSSProperties;
    className?: string;
}
export declare function DotsMainContainer(props: DotsMainContainerProps): import("react").JSX.Element;
