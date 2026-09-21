import * as React from 'react';

export interface BadgeProgressProps {
    /** Number on the left — Dart `current` */
    current: number;
    /** Number on the right — Dart `max` */
    max: number;
}
export declare function BadgeProgress(props: BadgeProgressProps): import("react").JSX.Element;
