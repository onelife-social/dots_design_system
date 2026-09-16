import * as React from 'react';

export type DotsSelectorSize = 'small' | 'medium';
export type DotsSelectorVariant = 'check' | 'num';
export interface DotsSelectorProps {
    /** Visual variant — Dart enum DotsSelectorVariant (default 'check') */
    variant?: DotsSelectorVariant;
    /** Size — Dart enum DotsSelectorSize (height small 22 / medium 24; default medium) */
    size?: DotsSelectorSize;
    /** Selected state (controlled) — Dart `isSelected` */
    isSelected?: boolean;
    /** Initial state (uncontrolled; click toggles) */
    defaultSelected?: boolean;
    /** Called with the new state on tap (web extension; the Dart widget is only visual) */
    onChanged?: (isSelected: boolean) => void;
    /** (variant num only) Number shown when selected — Dart `number` (default 1) */
    number?: number;
}
export declare function DotsSelector(props: DotsSelectorProps): import("react").JSX.Element;
