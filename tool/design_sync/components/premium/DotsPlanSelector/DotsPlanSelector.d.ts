import * as React from 'react';

/** Dart enum DotsPlanSelectorVariant */
export type DotsPlanSelectorVariant = 'basic' | 'premium' | 'premiumPlus';
export interface DotsPlanSelectorProps {
    /** Plan title (bodyDefaultBold) */
    title: string;
    /** Optional description under the title (labelSmallRegular) */
    description?: string;
    /** Visual variant — Dart enum DotsPlanSelectorVariant (required, as in Dart) */
    variant: DotsPlanSelectorVariant;
    /** Selected (with enabled, paints the plan's webp background) */
    selected: boolean;
    /** Dart `enabled` (default true). Disabled: textQuarternary text and no background */
    enabled?: boolean;
    /** Dart `onTap` */
    onClick?: () => void;
    className?: string;
}
export declare function DotsPlanSelector(props: DotsPlanSelectorProps): import("react").JSX.Element;
