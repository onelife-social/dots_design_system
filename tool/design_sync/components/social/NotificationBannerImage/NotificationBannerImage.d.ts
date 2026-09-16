import * as React from 'react';

import { type SyntheticEvent } from 'react';
/**
 * NotificationBannerImage — web port of NotificationBannerImage (Flutter). r24 banner with a
 * top image, title (titleH6), optional description with highlighted appendix, action button
 * (main/secondary) and close button. The home banner (HomeRecapsBanner) is this component.
 */
export interface NotificationBannerImageProps {
    /** Image URL (Dart imageProvider). Without src a gradient placeholder is shown */
    src?: string;
    /** Image side in px (square). Without it the image fills the width */
    imageSize?: number;
    /** Horizontal padding around the image (default 20) */
    imagePadding?: number;
    /** Title — typo.main.titleH6, textPrimary */
    title: string;
    /** Description — bodyDefaultRegular, textTertiary */
    description?: string;
    /** Description appendix in labelHighlight (a space is prepended) */
    appendedDescription?: string;
    /** Action button text; without it there is no button */
    actionButtonText?: string;
    /** DotsMainButton size — Dart enum DotsMainButtonSize (default 'medium'). Inlined so the
     *  generated .d.ts stays self-contained. */
    actionButtonSize?: 'mainAction' | 'large' | 'medium' | 'small';
    /** true → variant main; false → variant secondary (default true) */
    isBtnActive?: boolean;
    /** Dart onActionTap — also makes the whole banner clickable */
    onActionClick?: () => void;
    /** Dart onClose */
    onClose?: () => void;
    /** Show the close button (default true) */
    showCloseButton?: boolean;
    /** Image load error (Dart: errorBuilder → the image is hidden) */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
    className?: string;
}
export declare function NotificationBannerImage(props: NotificationBannerImageProps): import("react").JSX.Element;
