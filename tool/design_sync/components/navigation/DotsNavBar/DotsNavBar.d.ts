import * as React from 'react';

/** Dart DotsNavBarItem */
export interface DotsNavBarItem {
    /** Real DS icon name (assets/icons) — Dart `iconData`. E.g. 'ic-home' */
    icon: string;
    /** Label below the icon */
    label: string;
    /** Numeric badge over the icon — Dart `pendingNumber` (shown up to 99) */
    badge?: number;
}
export interface DotsNavBarProps {
    /** The 3 items. Default: Crear (ic-add) / Inicio (ic-home) / Galería (ic-gallery) */
    items?: DotsNavBarItem[];
    /** Active item index (0..2). Default: 0 */
    selectedIndex?: number;
    /** Tap on an item — Dart `DotsNavBarItem.onTap` */
    onSelect?: (index: number) => void;
    className?: string;
}
export declare function DotsNavBar(props: DotsNavBarProps): import("react").JSX.Element;
