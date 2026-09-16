// ImageWithIcon — port of lib/src/components/notifications/image_with_icon.dart (Dart = source of truth)
import { useState, type CSSProperties, type SyntheticEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/**
 * ImageWithIcon — web port of ImageWithIcon (Flutter). 53×68 (or circular) thumbnail with a
 * top gradient, inner white border and a circular icon badge at the top-right corner.
 * Without image it can show an initial (aliasLabelImageText).
 */
export interface ImageWithIconProps {
  /** Image URL (Dart `image`). On load error → defaultImage (default_user_item) */
  src?: string;
  /** DotsIcon name of the badge (Dart `icon: Widget`) */
  icon?: string;
  /** CSS color of the icon (default theme/currentColor) */
  iconColor?: string;
  /** Icon size (default 18; badge = iconSize × 1.5) */
  iconSize?: number;
  /** Custom badge offset; by default it overhangs by half */
  iconOffset?: number;
  /** Width (default 53) */
  width?: number;
  /** Height (default 68) */
  height?: number;
  /** Radius (default 12; with circularImage → width/2) */
  borderRadius?: number;
  /** Inner white border width (default 2) */
  borderWidth?: number;
  /** Circular image/alias instead of a rounded rectangle */
  circularImage?: boolean;
  /** Show the badge (default true) */
  showIcon?: boolean;
  /** Initial shown when there is no src — Nunito 600 40, textTertiary */
  aliasLabelImageText?: string;
  /** Inline CSS style for the alias text (Dart aliasLabelImageTextStyle) */
  aliasLabelImageTextStyle?: CSSProperties;
  /** Image load error */
  onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
  className?: string;
}

export function ImageWithIcon(props: ImageWithIconProps) {
  const [imgError, setImgError] = useState(false);

  const width = props.width ?? 53;
  const height = props.height ?? 68;
  const borderRadius = props.borderRadius ?? 12;
  const borderWidth = props.borderWidth ?? 2;
  const iconSize = props.iconSize ?? 18;
  const circular = !!props.circularImage;
  const showIcon = props.showIcon !== false;

  const radius = circular ? width / 2 : borderRadius; // circularImage → width/2

  // Badge geometry (identical to Dart)
  const iconBorderWidth = iconSize * 0.1;
  const iconContainerSize = iconSize * 1.5;
  const iconRadius = (iconContainerSize + iconBorderWidth) / 2;
  const iconPosition = -(props.iconOffset ?? iconRadius) + iconBorderWidth;

  const hasImage = props.src != null && props.src !== '';
  const hasAliasText = !!props.aliasLabelImageText;

  let body = null;
  if (hasImage) {
    // Card + Image(fit: cover); loading/errorBuilder → defaultImage (default_user_item.webp)
    const cardStyle = { width, height, borderRadius: radius, '--ds-iwi-bw': `${borderWidth}px` } as CSSProperties;
    body = (
      <div className="ds-image-with-icon__card" style={cardStyle}>
        {imgError ? (
          <div className="ds-image-with-icon__default" />
        ) : (
          <img
            className="ds-image-with-icon__img"
            src={props.src}
            alt=""
            onError={(e) => {
              setImgError(true); // Dart: errorBuilder → defaultImage
              props.onError?.(e);
            }}
          />
        )}
        <div className="ds-image-with-icon__gradient" />
      </div>
    );
  } else if (hasAliasText) {
    // bgSecondaryBtn container with the initial — Nunito 600 40 textTertiary
    body = (
      <div className="ds-image-with-icon__alias" style={{ width, height, borderRadius: circular ? '50%' : borderRadius }}>
        <span className="ds-image-with-icon__alias-text" style={props.aliasLabelImageTextStyle}>
          {props.aliasLabelImageText}
        </span>
      </div>
    );
  }

  const badge =
    showIcon && props.icon ? (
      <div
        className="ds-image-with-icon__badge"
        style={{ top: iconPosition, right: iconPosition, width: iconRadius * 2, height: iconRadius * 2 }}
      >
        <div className="ds-image-with-icon__badge-inner" style={{ width: iconContainerSize, height: iconContainerSize, margin: iconBorderWidth }}>
          <DotsIcon name={props.icon} size={iconSize} color={props.iconColor} />
        </div>
      </div>
    ) : null;

  return (
    <div className={`ds-image-with-icon${props.className ? ` ${props.className}` : ''}`} style={{ width, height }}>
      {body}
      {badge}
    </div>
  );
}
