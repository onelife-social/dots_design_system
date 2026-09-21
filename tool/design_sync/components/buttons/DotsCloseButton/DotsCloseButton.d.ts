import * as React from 'react';

export type DotsCloseButtonSize = 'large' | 'medium' | 'small' | 'extraSmall';
export type DotsCloseButtonVariant = 'softContrast' | 'highContrast' | 'onBackground' | 'inverted';
export interface DotsCloseButtonProps {
    /** DotsIcon name — Dart `iconData` (default 'ic-cross') */
    icon?: string;
    /** Dart enum DotsCloseButtonSize (diameter 44/30/24/16, icon 20/16/16/10) */
    size?: DotsCloseButtonSize;
    /** Dart enum DotsCloseButtonVariant (default softContrast) */
    variant?: DotsCloseButtonVariant;
    /** Dart `onTap` */
    onClick?: () => void;
    /** CSS color forcing the icon color */
    color?: string;
    /** Backdrop blur behind the circle (default true) — Dart `addBlur` */
    addBlur?: boolean;
    /** Accessible name (default 'Close') */
    ariaLabel?: string;
}
export declare function DotsCloseButton(props: DotsCloseButtonProps): import("react").JSX.Element;
