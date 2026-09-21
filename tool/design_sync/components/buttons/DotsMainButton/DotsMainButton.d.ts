import * as React from 'react';

import { type CSSProperties, type MouseEvent } from 'react';
/** Dart enum DotsMainButtonVariant */
export type DotsMainButtonVariant = 'main' | 'secondary' | 'secondaryPremium' | 'secondaryPremiumPlus' | 'secondaryLight' | 'secondaryDark' | 'destructive' | 'disabled' | 'disabledOpaque' | 'ghost' | 'premiumPlus' | 'premium' | 'surface' | 'surfacePremium' | 'surfacePremiumPlus';
/** Dart enum DotsMainButtonSize (heights 52/44/36/28) */
export type DotsMainButtonSize = 'mainAction' | 'large' | 'medium' | 'small';
export interface DotsMainButtonProps {
    /** Button text — Dart `content` */
    label: string;
    /** DotsIcon name (e.g. 'ic-check') — Dart `icon: DotsIconData` */
    icon?: string;
    /** Secondary text; only visible in mainAction and large sizes — Dart `details` */
    details?: string;
    /** Icon size in px (default 20) */
    iconSize?: number;
    /** Size — Dart enum DotsMainButtonSize (default 'large') */
    size?: DotsMainButtonSize;
    /** Visual variant — Dart enum DotsMainButtonVariant (default 'main') */
    variant?: DotsMainButtonVariant;
    /** When false, `disabledVariant` is painted and clicks are ignored (default true) */
    enabled?: boolean;
    /** Tap callback — Dart `onTap` */
    onClick?: (e?: MouseEvent<HTMLButtonElement>) => void;
    /** Fill the available width (default true) */
    expand?: boolean;
    /** Compact 7px horizontal padding (default false) */
    adaptPaddingForText?: boolean;
    /** CSS color overriding the theme text color */
    textColor?: string;
    /** CSS color overriding the icon color */
    iconColor?: string;
    /** CSS color overriding the background (also cancels the gradient) */
    backgroundColor?: string;
    /** Extra inline style for the label — Dart `textStyle` */
    textStyle?: CSSProperties;
    /** Apply blur (and shadow on the variants that carry it) (default false) */
    shouldApplyBlur?: boolean;
    /** Icon position (default 'left') — Dart enum DotsMainButtonIconPosition */
    iconPosition?: 'left' | 'right';
    /** Show a spinner and block clicks (default false) */
    isLoading?: boolean;
    /** Variant used when enabled=false (default 'disabled') */
    disabledVariant?: DotsMainButtonVariant;
    /** Throttle onClick (default false) — Dart `useThrottle` */
    useThrottle?: boolean;
    /** Throttle window in ms (default 400) — Dart `throttleDuration` */
    throttleDuration?: number;
    className?: string;
}
export declare function DotsMainButton(props: DotsMainButtonProps): import("react").JSX.Element;
