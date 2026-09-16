import * as React from 'react';

import type { MouseEvent } from 'react';
/** Dart enum DotsSystemButtonVariant */
export type DotsSystemButtonVariant = 'active' | 'disabled' | 'destructive';
/** Dart enum DotsSystemButtonSize (single value: medium, height 44) */
export type DotsSystemButtonSize = 'medium';
export interface DotsSystemButtonProps {
    /** Button text — Dart `content` */
    label: string;
    /** DotsIcon name (e.g. 'ic-add') — Dart `icon: DotsIconData` */
    icon?: string;
    /** Size — Dart enum DotsSystemButtonSize (default and only value: 'medium') */
    size?: DotsSystemButtonSize;
    /**
     * Variant — Dart enum DotsSystemButtonVariant (default 'active').
     * Note: 'disabled' is only visual, the button still emits onClick (as in Dart).
     */
    variant?: DotsSystemButtonVariant;
    /** Tap callback — Dart `onTap`. Receives the native click event (a `() => void` is also accepted) */
    onClick?: (e?: MouseEvent<HTMLButtonElement>) => void;
    /** Full width (the Flutter Row mainAxisSize.max filling the parent) */
    expand?: boolean;
    /** Extra CSS class */
    className?: string;
}
export declare function DotsSystemButton(props: DotsSystemButtonProps): import("react").JSX.Element;
