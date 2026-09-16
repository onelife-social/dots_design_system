import * as React from 'react';

/** Dart enum DotsColorOption (the hex values live in dots_colors.dart) */
export type DotsColorOption = 'textQuarternary' | 'couple005' | 'couple007' | 'friends001' | 'friends002' | 'friends005' | 'friends008' | 'friends010' | 'class005' | 'class009' | 'wedding002' | 'family001' | 'family004' | 'family006' | 'child001' | 'child002' | 'child006' | 'birthday003' | 'birthday007' | 'celebration002' | 'hobby001' | 'hobby002' | 'hobby004' | 'hobby005' | 'hobby009' | 'work005';
export type ColorSelectorVariant = 'options' | 'selector';
export interface ColorSelectorProps {
    /** 'options' = DotsColorOptionsRow (check when selected) · 'selector' = DotsColorSelectorRow (highlight ring). Default 'options' */
    variant?: ColorSelectorVariant;
    /**
     * Colors to show. In 'options': DotsColorOption names (default: the 15-color Dart
     * `colorOptions` palette). In 'selector': CSS colors (required).
     */
    colors?: Array<DotsColorOption | string>;
    /** Selected color (same value as in `colors`) */
    selected?: DotsColorOption | string;
    /** Called when a color is tapped — Dart `onColorSelected` */
    onColorSelected?: (color: string) => void;
    /** Diameter of each circle in px (default 32) */
    size?: number;
    /** Gap between circles in px (default: 18 in 'options', 12 in 'selector') */
    spacing?: number;
    /** Extra CSS class */
    className?: string;
}
export declare function ColorSelector(props: ColorSelectorProps): import("react").JSX.Element;
export declare namespace ColorSelector {
    var OPTION_COLORS: Record<DotsColorOption, string>;
    var DEFAULT_OPTIONS: DotsColorOption[];
}
