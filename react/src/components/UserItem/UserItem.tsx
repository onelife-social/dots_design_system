// UserItem — port of lib/src/components/user_items/user_item.dart
// (+ user_info.dart → UserItem.Info, user_info_data.dart → flat props name/details/src/alias).
// Dart = source of truth.
import { useState, type SyntheticEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Dart enum UserInfoSize (avatar 26 / 40) */
export type UserInfoSize = 'small' | 'large';

/**
 * UserItem.Info — web port of UserInfo (Flutter). Circular avatar (image, alias or
 * gradient placeholder with initials) + name and optional details.
 */
export interface UserInfoProps {
  /** User name (UserInfoData.name) */
  name: string;
  /** Secondary line (UserInfoData.details) */
  details?: string;
  /** Avatar URL (UserInfoData.imageProvider) */
  src?: string;
  /** Alias circle text (UserInfoData.aliasLabelImageText) */
  alias?: string;
  /** Dart enum UserInfoSize (avatar 26 / 40). Default 'small' */
  size?: UserInfoSize;
  /** Avatar load error callback (UserInfoData.imageOnError) */
  onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
  className?: string;
}

/**
 * UserItem — web port of UserItem (Flutter). 170×45 pill (squircle24, bgStrong,
 * floating shadow) with UserInfo small + addCircle labelHighlight icon.
 */
export interface UserItemProps {
  /** User id; passed to onClick */
  id?: string;
  /** Name to display */
  name: string;
  /** Secondary line */
  details?: string;
  /** Avatar URL */
  src?: string;
  /** Alias circle text when there is no image */
  alias?: string;
  /** Tap callback, receives the id (Dart onTap(id)) */
  onClick?: (id: string | null) => void;
  /** Avatar load error callback */
  onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
  className?: string;
}

// Deterministic gradient placeholder variant (web extension of the defaultUserItem asset)
function gradVariant(seed: string | undefined) {
  const s = seed ?? '';
  let n = 0;
  for (let i = 0; i < s.length; i++) n = (n + s.charCodeAt(i)) % 997;
  return 'abcd'[n % 4];
}

function initials(name: string | undefined) {
  const parts = (name ?? '').trim().split(/\s+/).filter(Boolean);
  if (!parts.length) return '';
  let out = parts[0].charAt(0);
  if (parts.length > 1) out += parts[1].charAt(0);
  return out.toUpperCase();
}

// UserInfo — avatar 26 (small) / 40 (large) + name (+ details)
export function UserInfo(props: UserInfoProps) {
  const [hasError, setError] = useState(false);
  const size: UserInfoSize = props.size === 'large' ? 'large' : 'small'; // UserInfoSize (default small)
  const showImg = !!props.src && !hasError;

  let avatar;
  if (showImg) {
    avatar = (
      <span className="ds-user-info__avatar">
        <img
          className="ds-user-info__avatar-img"
          src={props.src}
          alt={props.name || ''}
          onError={(e) => {
            setError(true);
            props.onError?.(e);
          }}
        />
      </span>
    );
  } else if (props.alias) {
    // aliasLabelImageText — bgContainerSecondaryOnBackground circle + textTertiary
    avatar = <span className="ds-user-info__avatar ds-user-info__avatar--alias">{props.alias}</span>;
  } else {
    // No src nor alias — gradient placeholder with initials
    avatar = (
      <span className={`ds-user-info__avatar ds-user-info__avatar--ph ds-user-info__avatar--ph-${gradVariant(props.name)}`}>
        {initials(props.name)}
      </span>
    );
  }

  return (
    <span className={`ds-user-info ds-user-info--${size}${props.className ? ` ${props.className}` : ''}`}>
      {avatar}
      <span className="ds-user-info__names">
        <span className="ds-user-info__name">{props.name || ''}</span>
        {props.details ? <span className="ds-user-info__details">{props.details}</span> : null}
      </span>
    </span>
  );
}

// UserItem — 170×45, squircle24, bgStrong, floating shadow, addCircle 20 labelHighlight
export function UserItem(props: UserItemProps) {
  return (
    <button
      type="button"
      className={`ds-user-item${props.className ? ` ${props.className}` : ''}`}
      onClick={props.onClick ? () => props.onClick?.(props.id ?? null) : undefined}
    >
      <UserInfo name={props.name} details={props.details} src={props.src} alias={props.alias} onError={props.onError} size="small" />
      <DotsIcon name="ic-add-circle" size={20} color="var(--label-highlight)" />
    </button>
  );
}
UserItem.Info = UserInfo;
