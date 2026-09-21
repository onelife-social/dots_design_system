// AlbumGroupCard — port of lib/src/components/cards/group_cards/album_group_card.dart (Dart = source of truth).
import type { CSSProperties } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { pressable } from '../../internal/pressable';

/** Dart enum AlbumGroupCardVariant */
export type AlbumGroupCardVariant = 'small' | 'large';

export interface AlbumGroupCardProps {
  /** Background photo URL (Dart imageProvider). Without it a gradient placeholder is painted */
  imageSrc?: string;
  /** Title centered at the bottom (required in Dart) */
  title: string;
  /** Variant — Dart enum AlbumGroupCardVariant (default 'small') */
  variant?: AlbumGroupCardVariant;
  /** Icon of the top-left CardTag (Dart tagIconData), e.g. 'ic-prime-1' */
  tagIcon?: string;
  /** Blocked group: centered lock and no tag */
  isBlocked?: boolean;
  /** Height of the bottom fade (Dart edgeSize; default 60 small / 110 large) */
  edgeSize?: number;
  /**
   * Gaussian sigma of the bottom-edge blur — Dart `blurSigma` (SoftEdgeBlur `sigma: blurSigma ?? 12`).
   * Flutter's ImageFilter.blur sigma and CSS `blur()` are both the standard deviation of the Gaussian,
   * so the value is applied 1:1 as px (`--ds-agc-blur` on the fade) with no conversion. Default 12.
   */
  blurSigma?: number;
  /** Side in px (the card is 1:1; Dart clamps 135–160 small / 288–340 large). Default 148 / 288 */
  size?: number;
  /** Tap on the card (Dart onTap) */
  onClick?: () => void;
  className?: string;
}

export function AlbumGroupCard(props: AlbumGroupCardProps) {
  const variant: AlbumGroupCardVariant = props.variant === 'large' ? 'large' : 'small'; // Dart: default small
  const isSmall = variant === 'small';
  // Dart: AspectRatio 1:1 with constraints 135–160 (small) / 288–340 (large)
  const size = props.size ?? (isSmall ? 148 : 288);
  const edge = props.edgeSize ?? (isSmall ? 60 : 110);
  const blurSigma = props.blurSigma ?? 12; // Dart: sigma: blurSigma ?? 12
  const isBlocked = !!props.isBlocked;

  return (
    <div
      className={`ds-album-card ds-album-card--${variant}${props.className ? ` ${props.className}` : ''}`}
      style={{ width: size, height: size }}
      {...pressable(props.onClick)}
    >
      <div
        className={`ds-album-card__img${props.imageSrc ? '' : ' ds-album-card__img--ph'}`}
        style={props.imageSrc ? { backgroundImage: `url("${props.imageSrc}")` } : undefined}
      />
      <div className="ds-album-card__fade" style={{ height: edge, '--ds-agc-blur': `${blurSigma}px` } as CSSProperties} />
      <div className={`ds-album-card__title ds-album-card__title--${variant}`}>{props.title ?? ''}</div>
      {!isBlocked && props.tagIcon ? (
        <span className={`ds-album-card__tag ${isSmall ? 'ds-album-card__tag--small' : 'ds-album-card__tag--large'}`}>
          <DotsIcon name={props.tagIcon} size={20} color="currentColor" />
        </span>
      ) : null}
      {isBlocked ? (
        <div className="ds-album-card__lock">
          <DotsIcon name="ic-lock" size={32} color="currentColor" />
        </div>
      ) : null}
    </div>
  );
}
