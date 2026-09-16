import * as React from 'react';

import type { ReactNode } from 'react';
/** Dart enum DotsToastVariant */
export type DotsToastVariant = 'success' | 'error' | 'info' | 'progress' | 'connectionResumed' | 'connectionLost' | 'widget';
export interface DotsToastProps {
    /** Toast text, bodyDefaultMedium textPrimary — Dart `title` */
    title: string;
    /** Variant — Dart enum DotsToastVariant (default 'info') */
    variant: DotsToastVariant;
    /** true → DotsToastAction (160px column); false/omitted → DotsToastInfo (358px row) — Dart `isAction` */
    isAction?: boolean;
    /** DotsIcon name overriding the variant icon — Dart `customIconData` */
    customIcon?: string;
    /** CSS color overriding the variant tint — Dart `customIconColor` */
    customIconColor?: string;
    /** Ghost button text — only variant progress with isAction: false — Dart `btnTitle` */
    btnTitle?: string;
    /** Node shown instead of the icon — only variant widget with isAction: true — Dart `customWidget` */
    customWidget?: ReactNode;
    /** Tap on the toast (and on the ghost button) — Dart `onTap` */
    onClick?: () => void;
    className?: string;
}
export declare function DotsToast(props: DotsToastProps): import("react").JSX.Element;
