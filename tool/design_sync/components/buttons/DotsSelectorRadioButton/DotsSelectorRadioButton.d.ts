import * as React from 'react';

export interface DotsSelectorRadioButtonProps {
    /** Selected (1.5px labelHighlight border) — Dart `isSelected` */
    isSelected: boolean;
    /** Title — bodyDefaultBold */
    title: string;
    /** Icon of the first detail row — Dart `icon1` (default DotsIconData.clockFilled) */
    icon1?: string;
    /** Size of icon 1 — Dart `icon1Size` (default 16) */
    icon1Size?: number;
    /** Text of the first detail row */
    details1: string;
    /** Icon of the second detail row — Dart `icon2` (default DotsIconData.calendar) */
    icon2?: string;
    /** Size of icon 2 — Dart `icon2Size` (default 16) */
    icon2Size?: number;
    /** Text of the second detail row */
    details2: string;
    /** Tap — Dart `onTap` */
    onClick?: () => void;
}
/** Label variant — Dart enum SelectorRadioButtonLabelVariant */
export type SelectorRadioButtonLabelVariant = 'free' | 'acquired' | 'premium' | 'premiumPlus';
export interface DotsSelectorRadioButtonLabelProps {
    /** Selected (only when `isSelectable`) — Dart `isSelected` */
    isSelected: boolean;
    /** Title — title02H6 (P22 Mackinac) */
    title: string;
    /** Text of the top BadgeLabel — Dart `tagText` */
    tagText: string;
    details1: string;
    details2: string;
    /** When false hides the radio and disables selection — Dart `isSelectable` (default true) */
    isSelectable?: boolean;
    /** free → badge main · acquired → green · premium → premium · premiumPlus → premiumPlus */
    variant: SelectorRadioButtonLabelVariant;
    onClick?: () => void;
}
export interface DotsSettingItemRadioBtnProps {
    isSelected: boolean;
    /** Main label (left) — Dart `leadingLabel` */
    leadingLabel: string;
    /** Secondary label (right) — Dart `trailingLabel` */
    trailingLabel?: string;
    onClick?: () => void;
}
export declare function DotsSelectorRadioButton(props: DotsSelectorRadioButtonProps): import("react").JSX.Element;
export declare function DotsSelectorRadioButtonLabel(props: DotsSelectorRadioButtonLabelProps): import("react").JSX.Element;
export declare function DotsSettingItemRadioBtn(props: DotsSettingItemRadioBtnProps): import("react").JSX.Element;
