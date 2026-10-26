import * as React from 'react';

export interface DotsTimePickerProps {
    /** Selected time as HH:mm, 24 h (controlled); '' or undefined shows the device's current time without reporting it */
    value?: string;
    /** Called with the new time as HH:mm when a column settles, a row is tapped or an arrow key moves it */
    onChange?: (time: string) => void;
    /** Step of the minutes column, a divisor of 60 (default 1); a value off the step shows the step below it */
    minuteInterval?: number;
    /** Accessible names of the columns (default 'Hours' / 'Minutes') */
    hoursLabel?: string;
    minutesLabel?: string;
    className?: string;
}
export declare function DotsTimePicker(props: DotsTimePickerProps): import("react").JSX.Element;
