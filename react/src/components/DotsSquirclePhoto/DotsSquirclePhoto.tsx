// DotsSquirclePhoto — port of lib/src/components/photos_components/dots_squircle_photo.dart
// (Dart: DotsSquircleImage) + dots_squircle_photo_tag.dart (Dart: DotsSquircleImageTag), exposed as
// DotsSquirclePhoto.Tag. Dart = source of truth.
import { useState, type SyntheticEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { pressable } from '../../internal/pressable';

export interface DotsSquirclePhotoProps {
  /** Image URL. Without `src` (or when it fails to load) a gradient placeholder is painted. */
  src?: string;
  /** Alt text; also seeds the gradient placeholder. */
  alt?: string;
  /** Side in px (square). Default 52. */
  size?: number;
  /** Radius (number → px). Default 16 (DotsBorderRadius.r16). */
  borderRadius?: number | string;
  /** Hide the border. Default true. */
  hideBorder?: boolean;
  /** Border width in px. Default 1. */
  borderSize?: number;
  /** CSS color of the border. Default `var(--bg-btn-image)` (bgBtnImage at 60%). */
  borderColor?: string;
  /** Upload-error overlay (black 20% + centered white icon). Default false. */
  uploadError?: boolean;
  /** Icon of the error overlay. Default 'ic-cloud-fail' (DotsIconData.cloudFail). */
  uploadErrorIcon?: string;
  /** Tap callback (Dart onTap). */
  onClick?: () => void;
  /** Image load error callback (Dart onError). */
  onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
  className?: string;
}

export interface DotsSquirclePhotoTagProps {
  /** Image URL. Without `src` (or when it fails to load) a gradient placeholder is painted. */
  src?: string;
  /** Alt text; also seeds the gradient placeholder. */
  alt?: string;
  /** Image side in px (canvas = size + 10). Default 100. */
  size?: number;
  /** Radius. Default 24 (DotsBorderRadius.r24). */
  borderRadius?: number | string;
  /** Border color. Default `var(--label-always-white)`. */
  borderColor?: string;
  /** Border width. Default 2. */
  borderSize?: number;
  /** Tag icon. Default 'ic-calendar--check' (DotsIconData.calendarCheck). */
  icon?: string;
  /** Icon size. Default 24. */
  iconSize?: number;
  /** Icon color. Default `var(--label-always-white)`. */
  iconColor?: string;
  /** Tag circle diameter. Default 40. */
  tagCircleSize?: number;
  /** Tap callback (Dart onTap). */
  onClick?: () => void;
  /** Image load error callback (Dart onError). */
  onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
  className?: string;
}

// Deterministic gradient placeholder when there is no `src` (or it fails to load)
function gradVariant(seed: string | undefined) {
  const s = seed ?? '';
  let n = 0;
  for (let i = 0; i < s.length; i++) n = (n + s.charCodeAt(i)) % 997;
  return 'abcd'[n % 4];
}

function radiusPx(borderRadius: number | string | undefined, fallback: number) {
  if (borderRadius == null) return `${fallback}px`;
  return typeof borderRadius === 'number' ? `${borderRadius}px` : borderRadius;
}

export function DotsSquirclePhoto(props: DotsSquirclePhotoProps) {
  // Keep the failed URL (not a boolean) so a new `src` is attempted after a broken one
  const [failedSrc, setFailedSrc] = useState<string | null>(null);
  const hasError = !!props.src && failedSrc === props.src;

  const size = props.size ?? 52; // Dart default 52
  const br = radiusPx(props.borderRadius, 16); // DotsBorderRadius.r16
  const hideBorder = props.hideBorder !== false; // Dart default true
  const borderSize = props.borderSize ?? 1;
  const showImg = !!props.src && !hasError;

  return (
    <span
      className={`ds-squircle-photo${props.className ? ` ${props.className}` : ''}`}
      style={{ width: size, height: size, borderRadius: br }}
      {...pressable(props.onClick)}
    >
      {showImg ? (
        <img
          className="ds-squircle-photo__img"
          src={props.src}
          alt={props.alt ?? ''}
          onError={(e) => {
            setFailedSrc(props.src ?? null);
            props.onError?.(e);
          }}
        />
      ) : (
        <span className={`ds-squircle-photo__ph ds-squircle-photo__ph--${gradVariant(props.src || props.alt)}`} />
      )}
      {/* hideBorder: false → bgBtnImage border (the Dart 0.6 opacity already comes in the token) */}
      {!hideBorder ? (
        <span
          className="ds-squircle-photo__border"
          style={{ borderRadius: br, borderWidth: borderSize, borderColor: props.borderColor || undefined }}
        />
      ) : null}
      {/* uploadError → black 20% overlay + cloudFail 24 labelAlwaysWhite */}
      {props.uploadError ? (
        <span className="ds-squircle-photo__error">
          <DotsIcon name={props.uploadErrorIcon || 'ic-cloud-fail'} size={24} color="var(--label-always-white)" />
        </span>
      ) : null}
    </span>
  );
}

// DotsSquircleImageTag — (size+10)² canvas, bordered image + 40px tag circle bottom-right
function DotsSquirclePhotoTag(props: DotsSquirclePhotoTagProps) {
  const size = props.size ?? 100; // Dart default 100
  const tagCircleSize = props.tagCircleSize ?? 40;
  const iconSize = props.iconSize ?? 24;

  return (
    <span
      className={`ds-squircle-photo-tag${props.className ? ` ${props.className}` : ''}`}
      style={{ width: size + 10, height: size + 10 }}
      {...pressable(props.onClick)}
    >
      <DotsSquirclePhoto
        src={props.src}
        alt={props.alt}
        onError={props.onError}
        size={size}
        borderRadius={props.borderRadius ?? 24} // r24
        hideBorder={false}
        borderSize={props.borderSize ?? 2}
        borderColor={props.borderColor || 'var(--label-always-white)'}
      />
      <span className="ds-squircle-photo-tag__circle" style={{ width: tagCircleSize, height: tagCircleSize }}>
        <DotsIcon
          name={props.icon || 'ic-calendar--check'} // DotsIconData.calendarCheck
          size={iconSize}
          color={props.iconColor || 'var(--label-always-white)'}
        />
      </span>
    </span>
  );
}

/** Mirror of the Dart DotsSquircleImageTag */
DotsSquirclePhoto.Tag = DotsSquirclePhotoTag;
