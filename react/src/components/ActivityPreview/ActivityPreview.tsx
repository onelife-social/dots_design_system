// ActivityPreview — port of lib/src/components/notifications/activity_preview.dart
// + ActivityPreview.OverviewItem — port of activity_overview_item.dart (Dart = source of truth)
import { useState, type CSSProperties, type SyntheticEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { pressable } from '../../internal/pressable';

/** Dart enum ActivityPreviewVariant */
export type ActivityPreviewVariant = 'reactions' | 'views' | 'favs';

const VARIANTS: Record<ActivityPreviewVariant, true> = { reactions: true, views: true, favs: true };

// OverviewItem badge color per variant — friends001 / hobby002 / couple001
// (category colors without token in tokens.css; same in light and dark — dots_colors.dart)
const BADGE_COLORS: Record<ActivityPreviewVariant, string> = { reactions: '#FAA25E', views: '#9297EF', favs: '#F43C51' };

// ActivityOverviewItem.formatCount (k / M / B)
function formatCount(count: number) {
  if (count >= 1000000000) return (count / 1000000000).toFixed(1) + 'B';
  if (count >= 1000000) return (count / 1000000).toFixed(1) + 'M';
  if (count >= 1000) return (count / 1000).toFixed(1) + 'k';
  return String(count);
}

/**
 * ActivityPreview — web port of ActivityPreview (Flutter). 3:4 card (r24, shadow, border)
 * with a background image and a bottom blur pill: reaction emojis or icon (eye/heart)
 * + already-formatted number.
 */
export interface ActivityPreviewProps {
  /** Dart enum ActivityPreviewVariant (default 'reactions') */
  variant?: ActivityPreviewVariant;
  /** Background image URL (Dart `image`). Without src → gradient placeholder */
  src?: string;
  /** Reaction emojis (variant reactions only) */
  reactions?: string[];
  /** ALREADY formatted number ('123', '1.2K'…) — as in Dart */
  number?: string;
  /** Dart onCardTap */
  onCardClick?: () => void;
  /** Dart onError (image load error) */
  onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
  className?: string;
}

/**
 * ActivityPreview.OverviewItem — web port of ActivityOverviewItem (Flutter). 53×68 photo
 * stack (second photo rotated -5°) with a variant badge in the corner, counter, title and
 * a "+N" row with overlapping avatars.
 */
export interface ActivityOverviewItemProps {
  /** Photo URLs; the first in front, the last behind rotated (Dart `images`) */
  images?: string[];
  /** DotsIcon name of the badge (Dart `icon: Widget`) */
  icon: string;
  /** CSS color of the badge icon (default labelAlwaysWhite) */
  iconColor?: string;
  /** Variant — colors the badge: reactions→friends001, views→hobby002, favs→couple001 */
  variant: ActivityPreviewVariant;
  /** Counter under the stack (formatted with k/M/B) */
  count: number;
  /** Title under the counter */
  title: string;
  /** Total reactions; > 0 shows the "+N" row */
  reactionsCount: number;
  /** User avatar URLs (overlapping 10px, 17px circles) */
  userImages: string[];
  /** Photo width (default 53) */
  width?: number;
  /** Photo height (default 68) */
  height?: number;
  /** Photo radius (default 12) */
  borderRadius?: number;
  /** Inner white border width (default 1) */
  borderWidth?: number;
  /** Max avatars shown (default 2) */
  maxUserImages?: number;
  /** Load error of any photo */
  onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
  className?: string;
}

/* ── ActivityPreview — 3:4 card with blur pill ─────────────────────────── */
export function ActivityPreview(props: ActivityPreviewProps) {
  const [imgError, setImgError] = useState(false);
  const variant: ActivityPreviewVariant = props.variant && VARIANTS[props.variant] ? props.variant : 'reactions';
  const isReactions = variant === 'reactions';
  const showImg = !!props.src && !imgError;

  return (
    <div
      className={
        'ds-activity-preview' +
        (showImg ? '' : ' ds-activity-preview--placeholder') +
        (props.onCardClick ? ' ds-activity-preview--clickable' : '') +
        (props.className ? ` ${props.className}` : '')
      }
      {...pressable(props.onCardClick)}
    >
      {showImg ? (
        <img
          className="ds-activity-preview__img"
          src={props.src}
          alt=""
          onError={(e) => {
            setImgError(true);
            props.onError?.(e);
          }}
        />
      ) : null}
      <div className="ds-activity-preview__pill">
        {isReactions && props.reactions?.length
          ? props.reactions.map((reaction, i) => (
              // typo.number.numLabelDefault (Nunito 13/800) — reactions (emojis)
              <span key={`r${i}`} className="ds-activity-preview__reaction">
                {reaction}
              </span>
            ))
          : null}
        {!isReactions ? (
          <span className="ds-activity-preview__pill-icon">
            <DotsIcon name={variant === 'views' ? 'ic-eye' : 'ic-heart'} size={14} color="var(--label-always-white)" />
          </span>
        ) : null}
        {/* typo.number.numBodyDefault (Nunito 14/800) labelAlwaysWhite */}
        <span className={`ds-activity-preview__number${isReactions ? '' : ' ds-activity-preview__number--after-icon'}`}>
          {props.number || ''}
        </span>
      </div>
    </div>
  );
}

/* ── ActivityPreview.OverviewItem — 53×68 photo stack + counters ────────── */
export function ActivityOverviewItem(props: ActivityOverviewItemProps) {
  const variant: ActivityPreviewVariant = VARIANTS[props.variant] ? props.variant : 'reactions';
  const width = props.width ?? 53;
  const height = props.height ?? 68;
  const borderRadius = props.borderRadius ?? 12;
  const borderWidth = props.borderWidth ?? 1;
  const maxUserImages = props.maxUserImages ?? 2;
  const images = props.images || [];
  const userImages = props.userImages || [];
  const count = props.count ?? 0;
  const reactionsCount = props.reactionsCount ?? 0;

  function hideOnError(e: SyntheticEvent<HTMLImageElement>) {
    e.currentTarget.style.display = 'none'; // keeps the card's gradient placeholder visible
    props.onError?.(e);
  }

  // white30 inside border → ::after with inset shadow (var --ds-ov-bw); shadows without token (#00000026)
  const cardStyle = {
    width,
    height,
    borderRadius,
    boxShadow: '0 6px 6px #00000026',
    '--ds-ov-bw': `${borderWidth}px`,
  } as CSSProperties;
  const backStyle = {
    width,
    height,
    borderRadius,
    boxShadow: '-6px 5px 10px #00000026',
    '--ds-ov-bw': `${borderWidth}px`,
  } as CSSProperties;

  // Back photo rotated -0.087 rad ≈ -5deg, anchored bottom-right (only with >1 image)
  const backSrc = images.length > 1 ? images[images.length - 1] : undefined;
  const backCard =
    images.length > 1 ? (
      <div className="ds-activity-overview__card ds-activity-overview__card--back" style={backStyle}>
        {backSrc ? <img className="ds-activity-overview__photo" src={backSrc} alt="" onError={hideOnError} /> : null}
      </div>
    ) : null;

  const mainCard = (
    <div className="ds-activity-overview__card ds-activity-overview__card--main" style={cardStyle}>
      {images[0] ? <img className="ds-activity-overview__photo" src={images[0]} alt="" onError={hideOnError} /> : null}
      <div className="ds-activity-overview__gradient" style={{ borderRadius }} />
    </div>
  );

  // Corner badge: CircleAvatar r10 bgBase → inner circle in the variant color + icon 14
  const badge = (
    <div className="ds-activity-overview__badge">
      <div className="ds-activity-overview__badge-inner" style={{ background: BADGE_COLORS[variant] }}>
        {props.icon ? <DotsIcon name={props.icon} size={14} color={props.iconColor || 'var(--label-always-white)'} /> : null}
      </div>
    </div>
  );

  // Overlapping 17px avatars (10px offset per avatar)
  const shownUsers = userImages.slice(0, maxUserImages);
  const avatars =
    reactionsCount > 0 && shownUsers.length > 0 ? (
      <div className="ds-activity-overview__avatars" style={{ width: 17 + (shownUsers.length - 1) * 10 }}>
        {shownUsers.map((src, i) => (
          <div key={i} className="ds-activity-overview__avatar" style={{ left: i * 10, zIndex: shownUsers.length - i }}>
            {/* fallback underneath; the photo covers it once loaded (Dart: imageErrorBuilder → Icons.person) */}
            <span className="ds-activity-overview__avatar-fallback">
              <DotsIcon name="ic-user" size={12} color="var(--text-tertiary)" />
            </span>
            {src ? (
              <img
                className="ds-activity-overview__avatar-img"
                src={src}
                alt=""
                onError={(e) => {
                  e.currentTarget.style.display = 'none'; // → ic-user fallback
                }}
              />
            ) : null}
          </div>
        ))}
      </div>
    ) : null;

  return (
    <div className={`ds-activity-overview${props.className ? ` ${props.className}` : ''}`}>
      <div className="ds-activity-overview__stack" style={{ width, height }}>
        {backCard}
        {mainCard}
        {badge}
      </div>
      <div className="ds-activity-overview__info">
        <div className="ds-activity-overview__count">{formatCount(count)}</div>
        <div className="ds-activity-overview__title">{props.title}</div>
        {reactionsCount > 0 ? (
          <div className="ds-activity-overview__reactions">
            <span className="ds-activity-overview__reactions-count">{`+${formatCount(reactionsCount)}`}</span>
            {avatars}
          </div>
        ) : null}
      </div>
    </div>
  );
}
ActivityPreview.OverviewItem = ActivityOverviewItem;
