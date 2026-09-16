// NotificationBanner — port of lib/src/components/notifications/notification_banner.dart (Dart = source of truth)
import { DotsCloseButton } from '../DotsCloseButton/DotsCloseButton';
import { DotsMainButton } from '../DotsMainButton/DotsMainButton';

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

export function NotificationBanner(props: NotificationBannerProps) {
  const showClose = props.showCloseButton !== false;
  const hasAction = props.actionButtonText != null && props.actionButtonText !== '';

  return (
    <div className={`ds-notif-banner${props.className ? ` ${props.className}` : ''}`}>
      <div className="ds-notif-banner__title">{props.title}</div>
      {props.body != null ? <div className="ds-notif-banner__body">{props.body}</div> : null}
      {hasAction ? (
        // DotsMainButton(content, size: medium, variant: main, expand: false)
        <div className="ds-notif-banner__action">
          <DotsMainButton label={props.actionButtonText ?? ''} size="medium" variant="main" expand={false} onClick={props.onActionClick} />
        </div>
      ) : null}
      {showClose ? (
        // DotsCloseButton(icon: cross, size: medium, variant: softContrast) — Positioned top 12 right 12
        <div className="ds-notif-banner__close">
          <DotsCloseButton icon="ic-cross" size="medium" variant="softContrast" onClick={props.onClose} />
        </div>
      ) : null}
    </div>
  );
}
