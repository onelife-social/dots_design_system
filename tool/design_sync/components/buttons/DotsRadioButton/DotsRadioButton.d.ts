import * as React from 'react';

export interface DotsRadioButtonProps {
    /** Selected state (controlled) — Dart `isSelected` */
    isSelected?: boolean;
    /** Initial state (uncontrolled) */
    defaultSelected?: boolean;
    /** Called with `true` on tap (a radio never unselects itself) */
    onChanged?: (isSelected: boolean) => void;
    /** Diameter in px — Dart `size` (24) */
    size?: number;
    /** Disabled (web extension; the Dart widget does not expose it) */
    disabled?: boolean;
}
export declare function DotsRadioButton(props: DotsRadioButtonProps): import("react").JSX.Element;
