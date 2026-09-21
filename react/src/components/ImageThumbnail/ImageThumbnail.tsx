// ImageThumbnail — port of lib/src/components/image_thumbnail/image_thumbnail.dart (DotsImageThumbnail; Dart = source of truth).
import type { ReactEventHandler } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Dart enum DotsImageThumbnailVariant */
export type ImageThumbnailVariant = 'image' | 'icon';

export interface ImageThumbnailProps {
  /** Variant — Dart enum DotsImageThumbnailVariant. Default: 'image' */
  variant?: ImageThumbnailVariant;
  /** Image URL (variant image) — the Dart `image` (ImageProvider) */
  src?: string;
  /** Image alt text */
  alt?: string;
  /** Side in px — Dart `size`. Default: 40 */
  size?: number;
  /** DotsIcon name (variant icon) — Dart `iconData`. Default: 'ic-user' */
  icon?: string;
  /** Icon size — Dart `iconSize`. Default: 20 */
  iconSize?: number;
  /** CSS color of the icon — Dart `iconColor`. Default: text-secondary */
  iconColor?: string;
  /** Black 30% overlay over the image — Dart `coverImage`. Default: false */
  coverImage?: boolean;
  /** Image load error — Dart `onError` */
  onError?: ReactEventHandler<HTMLImageElement>;
  className?: string;
}

export function ImageThumbnail(props: ImageThumbnailProps) {
  const variant: ImageThumbnailVariant = props.variant || 'image';
  const isIcon = variant === 'icon';
  const size = props.size ?? 40;
  const iconSize = props.iconSize ?? 20;
  return (
    <span
      className={`ds-image-thumbnail${isIcon ? ' ds-image-thumbnail--icon' : ''}${props.className ? ` ${props.className}` : ''}`}
      style={{ width: `${size}px`, height: `${size}px` }}
    >
      {!isIcon && props.src ? <img className="ds-image-thumbnail__img" src={props.src} alt={props.alt || ''} onError={props.onError} /> : null}
      {props.coverImage ? <span className="ds-image-thumbnail__cover" /> : null}
      {isIcon ? (
        <span className="ds-image-thumbnail__icon">
          <DotsIcon name={props.icon || 'ic-user'} size={iconSize} color={props.iconColor} />
        </span>
      ) : null}
    </span>
  );
}
