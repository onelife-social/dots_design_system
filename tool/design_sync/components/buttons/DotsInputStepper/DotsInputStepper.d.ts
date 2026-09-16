import * as React from 'react';

export interface DotsInputStepperProps {
    /** Current value (controlled) — Dart `value` */
    value?: number;
    /** Initial value (uncontrolled; default minValue) */
    defaultValue?: number;
    /** Minimum allowed — Dart `minValue` (required in Dart; web default 0) */
    minValue?: number;
    /** Maximum allowed — Dart `maxValue` (required in Dart; web default 99) */
    maxValue?: number;
    /** + button callback — Dart `onIncrement` */
    onIncrement?: () => void;
    /** − button callback — Dart `onDecrement` */
    onDecrement?: () => void;
    /** Called with the new value after each press (web extension) */
    onChanged?: (value: number) => void;
    /** Accessible name of the − button (default 'Decrement'; localize from the app) */
    decrementLabel?: string;
    /** Accessible name of the + button (default 'Increment'; localize from the app) */
    incrementLabel?: string;
}
export declare function DotsInputStepper(props: DotsInputStepperProps): import("react").JSX.Element;
