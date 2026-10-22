import * as React from 'react';

export interface DotsCheckCircleProps {
    /** Selected state (controlled) — Dart `isSelected` */
    isSelected?: boolean;
    /** Initial state (uncontrolled) */
    defaultSelected?: boolean;
    /** Called with the new state on tap (toggles, unlike DotsRadioButton). Without it, a controlled check is
     * display-only: a span hidden from assistive tech, for a parent such as a clickable card that owns the toggle */
    onChanged?: (isSelected: boolean) => void;
    /** Diameter in px — Dart `size` (24) */
    size?: number;
    /** Disabled (web extension; the Dart widget does not expose it) */
    disabled?: boolean;
    /** Accessible name: the check has no text of its own, so the parent names the option */
    ariaLabel?: string;
    /** Id of the element that names the option (alternative to `ariaLabel`) */
    ariaLabelledBy?: string;
}
export declare function DotsCheckCircle(props: DotsCheckCircleProps): import("react").JSX.Element;
