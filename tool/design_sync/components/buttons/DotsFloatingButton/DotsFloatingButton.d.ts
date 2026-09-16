import * as React from 'react';

export interface DotsFloatingButtonProps {
    /** Button text (labelDefaultBold 13/600, 1-line ellipsis) */
    content: string;
    /** DotsIcon name (20px), optional — e.g. 'ic-map' */
    icon?: string;
    /** Dart `onTap` */
    onClick?: () => void;
    /** Backdrop blur + 50% white layer under the background (default true) */
    blur?: boolean;
}
export declare function DotsFloatingButton(props: DotsFloatingButtonProps): import("react").JSX.Element;
