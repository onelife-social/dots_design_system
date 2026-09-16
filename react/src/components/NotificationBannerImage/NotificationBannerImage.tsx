// NotificationBannerImage — port of lib/src/components/notifications/notification_banner_image.dart (Dart = source of truth)
import { useState, type SyntheticEvent } from 'react';
import { DotsCloseButton } from '../DotsCloseButton/DotsCloseButton';
import { DotsMainButton, type DotsMainButtonSize } from '../DotsMainButton/DotsMainButton';

const BTN_SIZES: Record<DotsMainButtonSize, true> = { mainAction: true, large: true, medium: true, small: true };

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

export function NotificationBannerImage(props: NotificationBannerImageProps) {
  const [imgError, setImgError] = useState(false);

  const imagePadding = props.imagePadding ?? 20;
  const showClose = props.showCloseButton !== false;
  const isBtnActive = props.isBtnActive !== false;
  const btnSize: DotsMainButtonSize = props.actionButtonSize && BTN_SIZES[props.actionButtonSize] ? props.actionButtonSize : 'medium';
  const clickable = typeof props.onActionClick === 'function';
  const sized = props.imageSize != null ? { width: props.imageSize, height: props.imageSize } : undefined;

  // Image(fit: cover) — optional imageSize (square); errorBuilder → SizedBox.shrink
  let imageEl = null;
  if (props.src && !imgError) {
    imageEl = (
      <img
        className={`ds-notif-banner-img__img${sized ? ' ds-notif-banner-img__img--sized' : ''}`}
        src={props.src}
        alt=""
        style={sized}
        onError={(e) => {
          setImgError(true); // Dart: errorBuilder → SizedBox.shrink()
          props.onError?.(e);
        }}
      />
    );
  } else if (!props.src) {
    // Without src (in Dart imageProvider is required): gradient placeholder as in screens/home.html
    imageEl = <div className="ds-notif-banner-img__placeholder" style={sized} />;
  }

  // RichText: description (textTertiary) + ' appendedDescription' (labelHighlight)
  const descEl = props.description ? (
    <div className="ds-notif-banner-img__desc">
      {props.description}
      {props.appendedDescription ? <span className="ds-notif-banner-img__desc-appended">{` ${props.appendedDescription}`}</span> : null}
    </div>
  ) : null;

  // stopPropagation: in Dart the button's inner GestureDetector wins over the banner's (a single tap)
  const actionEl = props.actionButtonText ? (
    <div className="ds-notif-banner-img__action" onClick={(e) => e.stopPropagation()}>
      <DotsMainButton
        label={props.actionButtonText}
        size={btnSize}
        variant={isBtnActive ? 'main' : 'secondary'}
        expand={false}
        onClick={props.onActionClick}
      />
    </div>
  ) : null;

  // stopPropagation so that closing does not fire the banner's onActionClick
  const closeEl = showClose ? (
    <div className="ds-notif-banner-img__close" onClick={(e) => e.stopPropagation()}>
      <DotsCloseButton icon="ic-cross" size="medium" variant="softContrast" onClick={props.onClose} />
    </div>
  ) : null;

  // Dart: with onActionTap != null the whole banner is GestureDetector(onTap: onActionTap)
  return (
    <div
      className={`ds-notif-banner-img${clickable ? ' ds-notif-banner-img--clickable' : ''}${props.className ? ` ${props.className}` : ''}`}
      onClick={clickable ? props.onActionClick : undefined}
    >
      {imageEl ? (
        <div className="ds-notif-banner-img__img-wrap" style={{ paddingLeft: imagePadding, paddingRight: imagePadding }}>
          {imageEl}
        </div>
      ) : null}
      <div className="ds-notif-banner-img__content">
        <div className="ds-notif-banner-img__title">{props.title}</div>
        {descEl}
        {actionEl}
      </div>
      {closeEl}
    </div>
  );
}
