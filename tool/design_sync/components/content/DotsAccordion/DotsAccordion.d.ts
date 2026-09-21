import * as React from 'react';

import { type ReactNode } from 'react';
export interface DotsAccordionSection {
    /** Header title — bodyLargeMedium textPrimary */
    title: string;
    /** Expanded content — Dart `content` (Widget) */
    content?: ReactNode;
    /** Icon name (asset ic-…) left of the title — Dart `leadingIcon` */
    leadingIcon?: string;
    /** Initially open */
    expanded?: boolean;
}
export interface DotsAccordionProps {
    /** Accordion sections */
    sections: DotsAccordionSection[];
    /** Only one section open at a time (default true) */
    singleOpen?: boolean;
    /** Expand animation duration in ms — Dart `animationDuration` (default 180) */
    animationDuration?: number;
    /** 16px horizontal padding on headers and content (default true) */
    addHorizontalPadding?: boolean;
    /** Web extension: notifies the toggle of a section */
    onToggle?: (index: number, expanded: boolean) => void;
}
export declare function DotsAccordion(props: DotsAccordionProps): import("react").JSX.Element;
