import * as React from 'react';

export interface DotsTextFieldDateProps {
    /** Real Dots icon name (e.g. 'ic-calendar'). Dart: iconData */
    icon?: string;
    /** Text on the left. Dart: label */
    label?: string;
    /** Date shown as a chip. Dart: date (required) */
    date: string;
    /** Time shown as a second chip. Dart: time */
    time?: string;
    /** Tap on the field (open the date picker). Dart: onTap (required) */
    onClick: () => void;
    /** Error state: paints the chip text in labelDestructive. Dart: isError (default false) */
    isError?: boolean;
    /** Error text under the field (only with background). Dart: errorText */
    errorText?: string;
    /** Pill background bgContainerSecondaryOnBackground. Dart: background (default true) */
    background?: boolean;
}
export declare function DotsTextFieldDate(props: DotsTextFieldDateProps): import("react").JSX.Element;
