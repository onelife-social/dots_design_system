import * as React from 'react';

/** Dart DotsMenuItemModel */
export interface DotsMenuItemModel {
    /** Unique id — Dart `id` */
    id: string | number;
    /** Main text (bodyDefaultMedium) — Dart `label` */
    label: string;
    /** Second line in textTertiary — Dart `details` */
    details?: string;
    /** Trailing DotsIcon name (16px, labelPrimary) — Dart `icon` */
    icon?: string;
    /** Shows a 14px labelHighlight check on the left — Dart `selected` */
    selected?: boolean;
    /** Tints label and icons with labelDestructive — Dart `isDelete` */
    isDelete?: boolean;
    /** Sub items — tapping navigates into this level — Dart `subItems` */
    subItems?: DotsMenuItemModel[];
    /** 0.5px divider after the item — Dart `addDivider` */
    addDivider?: boolean;
    /** Dart `onTap` */
    onClick?: () => void;
}
export interface DotsMenuProps {
    /** Header item of the menu — Dart `mainItem` */
    mainItem: DotsMenuItemModel;
    /** First-level sub items — Dart `subitems` */
    subitems: DotsMenuItemModel[];
    /** Opens the menu directly at the level containing this id — Dart `defaultSelectedItemId` */
    defaultSelectedItemId?: string | number;
    className?: string;
}
/** Dart enum SettingsItemVariant */
export type DotsMenuSettingsItemVariant = 'icon' | 'toggle';
export interface DotsMenuSettingsItemProps {
    /** Row with trailing icon or with toggle — Dart enum SettingsItemVariant */
    variant: DotsMenuSettingsItemVariant;
    /** Text (bodyDefaultMedium) — Dart `label` */
    label: string;
    /** Leading icon 20px textTertiary — Dart `startIcon` */
    startIcon?: string;
    /** Trailing icon 16px textTertiary (variant 'icon' only) — Dart `endIcon` */
    endIcon?: string;
    /** Toggle state (variant 'toggle' only) — Dart `toggleValue` */
    toggleValue?: boolean;
    /** Tap on the toggle — Dart `onToggleTap` */
    onToggleTap?: () => void;
    /** Tap on the row — Dart `onTap` */
    onClick?: () => void;
    /** CSS color of the label — Dart `textColor` */
    textColor?: string;
    /** Label alignment — Dart `textAlignment` (default 'left') */
    textAlignment?: 'left' | 'center' | 'right';
}
export interface DotsMenuSettingsListProps {
    /** Uppercased title above the list — Dart `title` */
    title?: string;
    /** Description below the list — Dart `description` */
    description?: string;
    /** Settings rows — Dart `items` */
    items: DotsMenuSettingsItemProps[];
    /** Horizontal padding of title/description — Dart `textPadding` (default 15) */
    textPadding?: number;
    className?: string;
}
export declare function DotsMenu(props: DotsMenuProps): import("react").JSX.Element;
export declare namespace DotsMenu {
    var SettingsList: typeof DotsMenuSettingsList;
    var SettingsItem: typeof DotsMenuSettingsItem;
}
export declare function DotsMenuSettingsItem(p: DotsMenuSettingsItemProps): import("react").JSX.Element;
export declare function DotsMenuSettingsList(props: DotsMenuSettingsListProps): import("react").JSX.Element;
