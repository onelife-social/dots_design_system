import * as React from 'react';

export interface DotsCalendarProps {
    /** Selected day as ISO yyyy-mm-dd; '' or undefined = nothing selected (controlled) */
    value?: string;
    /** Called with the tapped day as ISO yyyy-mm-dd */
    onChange?: (iso: string) => void;
    /** Month shown at first (yyyy-mm); defaults to the value's month, else today's */
    initialMonth?: string;
    /** Today as ISO yyyy-mm-dd (override for previews/tests; default: the device date) */
    today?: string;
    /** BCP-47 locale for month and weekday names (default: navigator.language) */
    locale?: string;
    /** First column of the grid: 1 = Monday (default), 0 = Sunday */
    firstDayOfWeek?: 0 | 1;
    /** Days before today: 'muted' greys them but keeps them selectable (default), 'disabled' blocks them, 'normal' paints them as any other */
    pastDays?: 'normal' | 'muted' | 'disabled';
    /** Earliest / latest selectable day, ISO yyyy-mm-dd (inclusive) */
    minDate?: string;
    maxDate?: string;
    /** Years offered by the month/year picker (default: today's year - 5 … + 10) */
    yearRange?: [number, number];
    /** Start with the month/year picker open (previews) */
    initialPicking?: boolean;
    className?: string;
}
export declare function DotsCalendar(props: DotsCalendarProps): import("react").JSX.Element;
