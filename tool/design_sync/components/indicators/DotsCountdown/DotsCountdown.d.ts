import * as React from 'react';

/** 'recap' = CountdownRecap; 'small' | 'big' = Dart enum CountdownEventFinishedVariant */
export type DotsCountdownVariant = 'recap' | 'small' | 'big';
export interface DotsCountdownProps {
    /**
     * `recap` = CountdownRecap (countdown with lock icon);
     * `small` | `big` = Dart enum CountdownEventFinishedVariant.
     * Default: 'recap'
     */
    variant?: DotsCountdownVariant;
    /** Title — Dart `title` (recap and big) */
    title?: string;
    /** Target date — Dart `countdownDate`. With it the counter ticks every 1s. */
    targetDate?: Date | string | number;
    /** Fixed values for static design (alternative to `targetDate`) */
    days?: number | string;
    hours?: number;
    minutes?: number;
    seconds?: number;
    /** Forces the finished state (shows `description`) */
    finished?: boolean;
    /** Text when finished — Dart `description` */
    description?: string;
    /** textDisabled background — Dart `isDotbook`. Default: false */
    isDotbook?: boolean;
    hoursLabel?: string;
    minutesLabel?: string;
    secondsLabel?: string;
    years?: string;
    months?: string;
    yearsLabel?: string;
    monthsLabel?: string;
    /** Days label — shared with recap */
    daysLabel?: string;
    /** Conjunction between months and days (small) — Dart `conjunctionText` */
    conjunctionText?: string;
    /** Small variant icon — DotsIcon name. Default: 'ic-wedding-rings' */
    icon?: string;
    className?: string;
}
export declare function DotsCountdown(props: DotsCountdownProps): import("react").JSX.Element;
