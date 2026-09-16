import * as React from 'react';

/** Dart enum BadgeMilestoneVariant */
export type BadgeMilestoneVariant = 'main' | 'ghost';
export interface BadgeMilestoneProps {
    /** Milestone text — Dart `content` */
    content: string;
    /** Variant — Dart enum BadgeMilestoneVariant. main: 1px bgSecondaryBtn border, v-pad 9 · ghost: no border, v-pad 6 */
    variant?: BadgeMilestoneVariant;
}
export declare function BadgeMilestone(props: BadgeMilestoneProps): import("react").JSX.Element;
