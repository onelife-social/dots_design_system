import * as React from 'react';

import type { ReactNode } from 'react';
export interface BadgeTagProps {
    /** Tag text. Empty string → empty 18×18 pill — Dart `tag` */
    tag: string;
    /**
     * Offset from the top-right corner when there is a child (right = width, top = height).
     * Default -5/-5 — Dart `size` (Size)
     */
    size?: {
        width?: number;
        height?: number;
    };
    /** Main content the tag floats over — Dart `child` */
    children?: ReactNode;
}
export declare function BadgeTag(props: BadgeTagProps): import("react").JSX.Element;
