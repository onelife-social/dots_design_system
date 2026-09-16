import * as React from 'react';

import { type ReactNode } from 'react';
/** Dart enum DropdownListSize */
export type DropdownMenuSize = 'small' | 'medium';
/** Dart enum DropdownListVariant (defaultVariant → 'default', onBackgroundVariant → 'onBackground') */
export type DropdownMenuVariant = 'default' | 'onBackground';
export interface DropdownMenuItemProps {
    /** Main text (bodyDefaultMedium) — Dart `DropdownItem.text` */
    text: string;
    /** Inline subtitle in textSecondary — Dart `subtitle` */
    subtitle?: string;
    /** Optional leading node — Dart `leading` */
    leading?: ReactNode;
    /** Trailing DotsIcon name (16px) — Dart `icon` (DotsIconData) */
    icon?: string;
    /** CSS color tinting text and icon — Dart `itemColor` */
    itemColor?: string;
    /** Shortcut for itemColor = labelDestructive */
    destructive?: boolean;
    /** The item shrinks to its content — Dart `minSize` (default false) */
    minSize?: boolean;
    /** Dart `onTap` */
    onClick?: () => void;
}
export interface DropdownMenuProps {
    /** Menu items — Dart `DropdownMenu.items` / `DropdownList.items` */
    items: DropdownMenuItemProps[];
    /** Panel width in px — Dart `DropdownMenu.width` (default 250) */
    width?: number;
    /** Max panel height, scrolls beyond it — Dart `maxHeight` */
    maxHeight?: number;
    /** Dropdown button text. Omitted → only the panel is painted — Dart `DropdownList.label` */
    label?: string;
    /** Button subtitle in textTertiary — Dart `subtitle` */
    subtitle?: string;
    /** Button size — Dart enum DropdownListSize (default 'small') */
    size?: DropdownMenuSize;
    /** Variant — Dart enum DropdownListVariant (default 'default') */
    variant?: DropdownMenuVariant;
    /** Open menu (controlled) — Dart `isActive` */
    isActive?: boolean;
    /** Initial open state in uncontrolled mode */
    defaultActive?: boolean;
    /** The button shrinks to its content — Dart `minSize` (default true) */
    minSize?: boolean;
    /** Max width of the dropped menu — Dart `menuMaxWidth` */
    menuMaxWidth?: number;
    /** Max height of the dropped menu — Dart `menuMaxHeight` */
    menuMaxHeight?: number;
    /** Notifies the next open/closed state after a button tap */
    onToggle?: (active: boolean) => void;
    /** Tap on the button — Dart `DropdownList.onTap` */
    onClick?: () => void;
    className?: string;
}
export declare function DropdownMenuItem(props: DropdownMenuItemProps): import("react").JSX.Element;
export declare function DropdownMenu(props: DropdownMenuProps): import("react").JSX.Element;
export declare namespace DropdownMenu {
    var Item: typeof DropdownMenuItem;
}
