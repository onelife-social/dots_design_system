// DotsListItem — port of lib/src/components/dots_list_items/dots_list_items.dart (Dart = source of truth, widget DotsListsItem).
import type { SyntheticEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsRadioButton } from '../DotsRadioButton/DotsRadioButton';

/** Dart enum DotsListsItemVariant */
export type DotsListItemVariant = 'main' | 'selector' | 'icon' | 'check' | 'radioButton' | 'divider';
/** Dart enum DotsListsItemPicType */
export type DotsListItemPicType = 'album' | 'user';

export interface DotsListItemProps {
  /** Variant — Dart enum DotsListsItemVariant (default 'main') */
  variant?: DotsListItemVariant;
  /** Row text (or section title in variant divider) */
  label?: string;
  /** Image URL/data URI — Dart `image` (ImageProvider) */
  imageSrc?: string;
  /** Thumbnail shape when there is an image — Dart enum DotsListsItemPicType (default 'album') */
  picType?: DotsListItemPicType;
  /** Icon name (asset ic-…) for variant icon or when there is no image — Dart `iconData` (default 'ic-user') */
  iconName?: string;
  /** Tap on the whole row — Dart `onTap` */
  onClick?: () => void;
  /** Image load error of picType user — Dart `onError` */
  onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
}

function renderThumb(props: DotsListItemProps) {
  const variant = props.variant ?? 'main';
  const picType = props.picType ?? 'album';
  if (props.imageSrc && variant !== 'icon' && picType === 'album') {
    // DotsImageThumbnail variant image — 40×40, radius 12, cover
    return <span className="ds-list-item__thumb ds-list-item__thumb--album" style={{ backgroundImage: `url("${props.imageSrc}")` }} />;
  }
  if (props.imageSrc && variant !== 'icon' && picType === 'user') {
    // 40 circle, bgBaseContrast background, image clipped in an oval
    return (
      <span className="ds-list-item__thumb ds-list-item__thumb--user">
        <img src={props.imageSrc} alt="" onError={props.onError} />
      </span>
    );
  }
  // DotsImageThumbnail variant icon — bg bgContainerSecondaryOnBackground, icon 20 textPrimary
  return (
    <span className="ds-list-item__thumb ds-list-item__thumb--icon">
      <DotsIcon name={props.iconName ?? 'ic-user'} size={20} color="var(--text-primary)" />
    </span>
  );
}

function renderTrailing(variant: DotsListItemVariant) {
  if (variant === 'selector' || variant === 'radioButton') {
    return <DotsRadioButton isSelected={variant === 'radioButton'} size={22} />;
  }
  if (variant === 'check') {
    // DotsSelector.check(size: small(22), isSelected: true) — labelHighlight pill, 14 white check
    return (
      <span className="ds-list-item__check">
        <DotsIcon name="ic-check" size={14} color="var(--label-always-white)" />
      </span>
    );
  }
  return null;
}

export function DotsListItem(props: DotsListItemProps) {
  const variant: DotsListItemVariant = props.variant ?? 'main';

  if (variant === 'divider') {
    return (
      <div className="ds-list-item ds-list-item--divider">
        <div className="ds-list-item__divider-label">{props.label ?? ''}</div>
        <div className="ds-list-item__hairline" />
      </div>
    );
  }

  return (
    <div className={`ds-list-item${props.onClick ? ' is-tappable' : ''}`} onClick={props.onClick} role={props.onClick ? 'button' : undefined}>
      {renderThumb(props)}
      {props.label != null ? <span className="ds-list-item__label">{props.label}</span> : null}
      {renderTrailing(variant)}
    </div>
  );
}
