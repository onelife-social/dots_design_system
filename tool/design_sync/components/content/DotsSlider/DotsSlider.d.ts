import * as React from 'react';

export interface DotsSliderProps {
    /** Current value (controlled) — Dart `value` */
    value?: number;
    /** Initial value (uncontrolled, web extension) */
    defaultValue?: number;
    /** Number of discrete divisions; null/undefined → continuous — Dart `divisions` */
    divisions?: number | null;
    /** Max value — Dart `max` (default 1.0) */
    max?: number;
    /** Called with the new value on drag/tap — Dart `onChanged` */
    onChanged?: (value: number) => void;
    /** Left icon (asset ic-…) — Dart `leftIcon` (default 'ic-user') */
    leftIcon?: string;
    /** Right icon (asset ic-…) — Dart `rightIcon` (default 'ic-group') */
    rightIcon?: string;
    /** Accessible name of the slider (web extension, localizable) */
    ariaLabel?: string;
    /** Id of the element that names the slider (alternative to `ariaLabel`) */
    ariaLabelledBy?: string;
}
export declare function DotsSlider(props: DotsSliderProps): import("react").JSX.Element;
