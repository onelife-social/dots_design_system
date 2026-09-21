import * as React from 'react';

/** Dart enum BadgeLabelSize (large h34 / medium h22 / small h18) */
export type BadgeLabelSize = 'large' | 'medium' | 'small';
/** Dart enum BadgeLabelVariant */
export type BadgeLabelVariant = 'main' | 'secondary' | 'green' | 'white' | 'greenMaterial' | 'warning' | 'warningMaterial' | 'red' | 'premiumPlus' | 'premium';
export interface BadgeLabelProps {
    /** Badge text — Dart `content` */
    content: string;
    /** Size — Dart enum BadgeLabelSize (large h34 / medium h22 / small h18) */
    size?: BadgeLabelSize;
    /** Visual variant — Dart enum BadgeLabelVariant (default 'main') */
    variant?: BadgeLabelVariant;
    /** Real Dots icon name (e.g. 'ic-check-circle'), 16px on the left — Dart `badgeIcon` */
    badgeIcon?: string;
}
export declare function BadgeLabel(props: BadgeLabelProps): import("react").JSX.Element;
