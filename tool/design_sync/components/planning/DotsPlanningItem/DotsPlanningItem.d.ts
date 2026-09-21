import * as React from 'react';

/** Mirror of the Dart class DotsPlanningInfoItem */
export interface DotsPlanningInfoItem {
    /** Real icon name (assets/icons) — Dart DotsIconData */
    icon?: string;
    /** Row text. Rows without icon or without text are not painted */
    text?: string;
    /** Underline (only the location row) — Dart `underline` (default false) */
    underline?: boolean;
}
export interface DotsPlanningItemProps {
    /** Section image URL — Dart `sectionImage`. Default: default_section_planning.webp (data URI) */
    sectionImage?: string;
    /** Section title (bodyLargeMedium) — Dart `mainText` */
    mainText: string;
    /** Collapsed icon — Dart `mainIcon` (default 'ic-chevron-down') */
    mainIcon?: string;
    /** Expanded icon — Dart `mainIconActive` (default 'ic-chevron-up') */
    mainIconActive?: string;
    /** Main row, always visible — Dart `mainItem` */
    mainItem?: DotsPlanningInfoItem;
    /** Rows visible only when expanded — Dart `subItems` (default []) */
    subItems?: DotsPlanningInfoItem[];
    /** Initial state (uncontrolled). Tap toggles. Default false */
    defaultExpanded?: boolean;
    /** Controlled state: when given, the component does not manage the toggle internally */
    expanded?: boolean;
    /** Toggle notification with the next state (useful in controlled mode) */
    onToggle?: (expanded: boolean) => void;
    className?: string;
}
export declare function DotsPlanningItem(props: DotsPlanningItemProps): import("react").JSX.Element;
