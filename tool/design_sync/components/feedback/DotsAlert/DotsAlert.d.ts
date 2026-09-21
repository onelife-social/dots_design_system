import * as React from 'react';

/** Dart enum DotsAlertVariant */
export type DotsAlertVariant = 'noButtons' | 'oneButton' | 'twoHorizontalButtons' | 'twoHorizontalButtonsDestructive' | 'twoVerticalButtons' | 'twoVerticalButtonsNoActive' | 'twoVerticalButtonsDestructive' | 'input' | 'selector';
/** Dart DotsListItemModel (selector variant) */
export interface DotsAlertSelectorItem {
    /** Dart `label` */
    label: string;
    /** 40×40 thumbnail URL (placeholder when omitted) — Dart `image` */
    image?: string;
    /** Dart `onTap` */
    onClick?: () => void;
}
export interface DotsAlertProps {
    /** Dart enum DotsAlertVariant (default 'noButtons') */
    variant?: DotsAlertVariant;
    /** DotsIcon name of the 48px highlight chip — Dart `iconData` */
    icon: string;
    /** 48×48 image URL replacing the chip (falls back to the chip on error) — Dart `iconImage` */
    iconImage?: string;
    /** bodyLargeBold — Dart `title` */
    title?: string;
    /** bodyDefaultRegular; not shown by the input variant — Dart `message` */
    message?: string;
    /** Close (X button, and tap outside with `showScrim`) — Dart `onClose` */
    onClose?: () => void;
    /** With `showScrim`, tap outside runs onClose (default true) — Dart `enableCloseOnTapOutside` */
    enableCloseOnTapOutside?: boolean;
    /** (input) Text change — Dart `onInputChanged` */
    onInputChanged?: (value: string) => void;
    /** (input) Placeholder — Dart `inputHint` */
    inputHint?: string;
    /** (selector) Rows — Dart `selectorItemList` */
    selectorItems?: DotsAlertSelectorItem[];
    /** Dart `mainButtonText` */
    mainButtonText?: string;
    /** Dart `mainButtonOnTap` */
    onMainButtonClick?: () => void;
    /** Dart `secondaryButtonText` */
    secondaryButtonText?: string;
    /** Dart `secondaryButtonOnTap` */
    onSecondaryButtonClick?: () => void;
    /** Top-right DotsCloseButton (medium, softContrast) — Dart `showCloseButton` (default false) */
    showCloseButton?: boolean;
    /** Backdrop blur 50 behind the card — Dart `showBlurBackground` (default true) */
    showBlurBackground?: boolean;
    /** Fixed 50% black scrim with the card centered (always present in Dart; opt-in here) */
    showScrim?: boolean;
    className?: string;
}
export declare function DotsAlert(props: DotsAlertProps): import("react").JSX.Element;
