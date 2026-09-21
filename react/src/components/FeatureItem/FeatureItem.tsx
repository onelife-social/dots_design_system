// FeatureItem — port of lib/src/components/feature_item/feature_item.dart (Dart = source of truth).
import type { ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface FeatureItemProps {
  /** Left label — Dart `feature` */
  feature: string;
  /** Optional right value (right-aligned) — Dart `value` */
  value?: string;
  /** DotsIcon name (e.g. 'ic-calendar') — Dart `icon: DotsIconData`. Ignored when `image` is set */
  icon?: string;
  /** Custom 24×24 leading — Dart `FeatureItem.image` variant */
  image?: ReactNode;
  /** Extra CSS class */
  className?: string;
}

export function FeatureItem(props: FeatureItemProps) {
  const hasValue = props.value != null;

  const leading =
    props.image != null ? (
      // FeatureItem.image → SizedBox.square(24) with the custom widget
      <span className="ds-feature-item__image">{props.image}</span>
    ) : (
      // Default → DotsIcon(size 16, textQuarternary via CSS currentColor)
      <span className="ds-feature-item__icon" aria-hidden>
        <DotsIcon name={props.icon ?? ''} size={16} />
      </span>
    );

  let className = 'ds-feature-item';
  if (hasValue) className += ' ds-feature-item--with-value';
  if (props.className) className += ` ${props.className}`;

  return (
    <div className={className}>
      {leading}
      <span className="ds-feature-item__feature">{props.feature}</span>
      {hasValue ? <span className="ds-feature-item__value">{props.value}</span> : null}
    </div>
  );
}
