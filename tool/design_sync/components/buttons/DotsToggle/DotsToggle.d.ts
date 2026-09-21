import * as React from 'react';

export interface DotsToggleProps {
    /** Selected state (controlled) — Dart `isSelected` */
    isSelected?: boolean;
    /** Initial state (uncontrolled) */
    defaultSelected?: boolean;
    /** Called with the new value on tap — Dart `onChanged(bool)` */
    onChanged?: (isSelected: boolean) => void;
    /** Disabled (web extension; the Dart widget does not expose it) */
    disabled?: boolean;
    /** Accessible name: the switch has no text of its own (web extension, localizable) */
    ariaLabel?: string;
    /** Id of the element that names the switch (alternative to `ariaLabel`) */
    ariaLabelledBy?: string;
}
export declare function DotsToggle(props: DotsToggleProps): import("react").JSX.Element;
