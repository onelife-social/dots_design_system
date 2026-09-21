import * as React from 'react';

import type { ReactNode } from 'react';
export interface FeatureItemProps {
    /** Left label — Dart `feature` */
    feature: string;
    /** Optional right value (right-aligned) — Dart `value` */
    value?: string;
    /** DotsIcon name (e.g. 'ic-calendar') — Dart `icon: DotsIconData`. Ignored when `image` is set */
    icon?: string;
    /** Custom 24×24 leading — Dart `FeatureItem.image` variant */
    image?: ReactNode;
    /** Extra CSS class */
    className?: string;
}
export declare function FeatureItem(props: FeatureItemProps): import("react").JSX.Element;
