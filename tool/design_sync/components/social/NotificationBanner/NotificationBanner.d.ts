import * as React from 'react';

/**
 * NotificationBanner — web port of NotificationBanner (Flutter). Centered informative banner
 * (r24, bgContainerSecondaryOnBackground) with title, optional body, optional action button
 * (DotsMainButton main·medium) and close button.
 */
export interface NotificationBannerProps {
    /** Title — typo.main.bodyLargeBold, textPrimary */
    title: string;
    /** Body under the title — bodyDefaultRegular, textSecondary */
    body?: string;
    /** Action button text; without it there is no button */
    actionButtonText?: string;
    /** Dart onActionTap */
    onActionClick?: () => void;
    /** Dart onClose (DotsCloseButton softContrast·medium, top 12 right 12) */
    onClose?: () => void;
    /** Show the close button (default true) */
    showCloseButton?: boolean;
    className?: string;
}
export declare function NotificationBanner(props: NotificationBannerProps): import("react").JSX.Element;
