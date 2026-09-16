import * as React from 'react';

import type { ReactNode } from 'react';
/** Dart constructors: onlyStatusBar / title / widget */
export type DotsHomeTopBarVariant = 'onlyStatusBar' | 'title' | 'widget';
export interface DotsHomeTopBarProps {
    /** Dart constructor; inferred when omitted: title→title, child→widget, else onlyStatusBar */
    variant?: DotsHomeTopBarVariant;
    /** Centered title — labelDefaultBold 13/600 textTertiary */
    title?: string;
    /** Tap on the title — Dart `DotsHomeTopBarMainSection.onTitleTap` */
    onTitleClick?: () => void;
    /** Custom center content (variant widget) — Dart `child` */
    child?: ReactNode;
    /** Left avatar (DotsProfilePhoto 32 in the home) — Dart `imgProfile` */
    imgProfile?: ReactNode;
    /** First right icon (DotsIconButton ic-heart, large, noBackground, tag in the home) */
    rightIcon?: ReactNode;
    /** Second right icon (DotsIconButton ic-chat in the home) — carries the trailing 16px margin */
    secondRightIcon?: ReactNode;
    /** Blur 50 + bgContainerPrimary background — Dart `backgroundBlur` */
    backgroundBlur?: boolean;
    /** Background fading to transparent (ShaderMask + blur 18) — Dart `showGradient` */
    showGradient?: boolean;
    /** Extra widgets below the content — Dart `children` */
    children?: ReactNode;
    className?: string;
}
export declare function DotsHomeTopBar(props: DotsHomeTopBarProps): import("react").JSX.Element;
