import * as React from 'react';

/** Dart enum BadgeIconSize (circle 44/36/28 · icon 24/20/16) */
export type BadgeIconSize = 'large' | 'medium' | 'small';
/** Dart enum BadgeIconStyle (only white for now) */
export type BadgeIconStyle = 'white';
export interface BadgeIconProps {
    /** Real Dots icon name (e.g. 'ic-heart') — Dart `icon` (DotsIconData). Required in single mode */
    icon?: string;
    /** Size — Dart enum BadgeIconSize (large 44/24 · medium 36/20 · small 28/16) */
    size?: BadgeIconSize;
    /** Visual style — Dart enum BadgeIconStyle (only 'white') */
    style?: BadgeIconStyle;
    /** Optional CSS color for the icon — Dart `iconColor` */
    iconColor?: string;
    /** Dart `onTap` */
    onClick?: () => void;
    /** Accessible name of the clickable badge (the control is icon-only); applied only with `onClick` */
    ariaLabel?: string;
    /**
     * Group mode (Dart BadgeIconGroup): 1-3 icon names stacked on a 63×70 canvas.
     * icons[0] medium bottom-left; icons[1]/icons[2] small. Ignores `icon`/`size`.
     */
    icons?: string[];
    /** Group mode: color per icon (null = style default) — Dart `iconColors` */
    iconColors?: Array<string | null | undefined>;
}
export declare function BadgeIcon(props: BadgeIconProps): import("react").JSX.Element | null;
