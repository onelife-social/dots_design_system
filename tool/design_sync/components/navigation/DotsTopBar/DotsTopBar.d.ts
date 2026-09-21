import * as React from 'react';

import type { ReactNode } from 'react';
export type DotsTopBarVariant = 'onlyStatusBar' | 'title' | 'widget' | 'cta';
export interface DotsTopBarProps {
    /** Dart constructor; inferred from the props when omitted */
    variant?: DotsTopBarVariant;
    /** Centered title — titleH6 (Dart `title`) */
    title?: string;
    /** Under the title — labelSmallRegular (Dart `subtitle`) */
    subtitle?: string;
    /** 20×20 DotsProfilePhoto before the title — Dart `imageTitle` */
    imageTitle?: string;
    /** Center content of the `widget` variant — Dart `child` */
    children?: ReactNode;
    /** Leading widget when there is no back button — Dart `leftIcon` */
    leftIcon?: ReactNode;
    /** Trailing widget (a DotsIconButton in Dart) — Dart `rightIcon` */
    rightIcon?: ReactNode;
    /** Shows the back button (DotsIconButton chevronLeft medium) — Dart `onTapBack` */
    onBack?: () => void;
    /** Transparent instead of bgContainerPrimary — Dart `hideBackground` */
    hideBackground?: boolean;
    /** Reserve the 50px status-bar strip above the content (default true) — Dart `bigStatusBar` */
    bigStatusBar?: boolean;
    /** Back button `solid` instead of `noBackground` — Dart `showCircleBackButton` */
    showCircleBackButton?: boolean;
    /** Explicit background color — Dart `color` */
    color?: string;
    /** 1px black @20% bottom border — Dart `showBottomBorder` */
    showBottomBorder?: boolean;
    /** `cta` variant: DotsMainButton main/small at the trailing edge — Dart `ctaLabel` */
    ctaLabel?: string;
    /** Dart `onCtaTap` */
    onCtaClick?: () => void;
    /** Dart `ctaEnabled` */
    ctaEnabled?: boolean;
    className?: string;
}
export declare function DotsTopBar(props: DotsTopBarProps): import("react").JSX.Element;
