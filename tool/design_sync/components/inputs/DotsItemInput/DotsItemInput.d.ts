import * as React from 'react';

export type DotsItemInputPosition = 'onlyOne' | 'first' | 'middle' | 'last';
export interface DotsItemInputProps {
    /** Row text. Dart: label */
    label?: string;
    /** Value shown in the right box (120×r7). Dart: value */
    value?: string;
    /** Real Dots icon name. Dart: icon (default DotsIconData.calendar → 'ic-calendar') */
    icon?: string;
    /** Position in the group — Dart enum DotsItemInputPosition (default onlyOne) */
    position?: DotsItemInputPosition;
    /** Row tap. Dart: onTap */
    onClick?: () => void;
}
export declare function DotsItemInput(props: DotsItemInputProps): import("react").JSX.Element;
