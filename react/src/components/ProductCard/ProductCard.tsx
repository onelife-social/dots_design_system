// ProductCard — port of lib/src/components/cards/product_card/product_card.dart (Dart = source of truth).
import type { KeyboardEvent, MouseEvent, ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { pressable } from '../../internal/pressable';

export interface ProductCardProps {
  /** Main line, always visible */
  title: string;
  /** Background image (URL). Without it a gradient placeholder is painted */
  imageSrc?: string;
  /** Second line under the title */
  subtitle?: string;
  /** Third line, usually the price ("Desde 29,99 €") */
  caption?: string;
  /** Strikethrough value after `caption`, e.g. the previous price. Ignored without `caption` */
  captionPrevious?: string;
  /** Content of the top-right badge (e.g. a BadgeLabel) */
  badge?: ReactNode;
  /** Number of dots of the PageControl. `0` hides it */
  pageCount?: number;
  /** Index of the active dot */
  activePage?: number;
  /** DotsIcon name of the action button (default `ic-arrow-right`) */
  actionIcon?: string;
  /** Width / height. Default 1 (square, like the Figma component) */
  aspectRatio?: number;
  /** Dart onTap — the whole card */
  onClick?: () => void;
  /** Dart onActionTap. Without it the button is not painted */
  onActionClick?: () => void;
  className?: string;
}

// PageControl dots (count × 8px, gap 8) — the active one in solid white
function Dots({ count, active }: { count: number; active: number }) {
  const items = [];
  for (let i = 0; i < count; i++) {
    items.push(<span key={i} className={`ds-product-card__dot${i === active ? ' is-active' : ''}`} />);
  }
  return <div className="ds-product-card__dots">{items}</div>;
}

export function ProductCard(props: ProductCardProps) {
  // Dart: AspectRatio(aspectRatio) over the available width; square by default.
  const ratio = props.aspectRatio || 1;
  const pageCount = props.pageCount || 0;
  const onActionClick = props.onActionClick;

  return (
    <div
      className={`ds-product-card${props.className ? ` ${props.className}` : ''}`}
      style={{ aspectRatio: String(ratio) }}
      {...pressable(props.onClick)}
    >
      <div
        className={`ds-product-card__bg${props.imageSrc ? '' : ' ds-product-card__bg--ph'}`}
        style={props.imageSrc ? { backgroundImage: `url("${props.imageSrc}")` } : undefined}
      />
      <div className="ds-product-card__scrim" />
      {props.badge ? <div className="ds-product-card__badge">{props.badge}</div> : null}
      {pageCount > 0 ? (
        <div className="ds-product-card__pagecontrol">
          <Dots count={pageCount} active={props.activePage || 0} />
        </div>
      ) : null}
      <div className="ds-product-card__bottom">
        <div className="ds-product-card__copy">
          <div className="ds-product-card__title">{props.title ?? ''}</div>
          {props.subtitle ? <div className="ds-product-card__subtitle">{props.subtitle}</div> : null}
          {props.caption ? (
            <div className="ds-product-card__caption">
              <span>{props.caption}</span>
              {props.captionPrevious ? <span className="ds-product-card__caption-prev">{props.captionPrevious}</span> : null}
            </div>
          ) : null}
        </div>
        {onActionClick ? (
          // Native button: its own click/keys must not bubble into the card's pressable handlers
          <button
            type="button"
            className="ds-product-card__action"
            onClick={(e: MouseEvent<HTMLButtonElement>) => {
              e.stopPropagation();
              onActionClick();
            }}
            onKeyDown={(e: KeyboardEvent<HTMLButtonElement>) => e.stopPropagation()}
          >
            <DotsIcon name={props.actionIcon || 'ic-arrow-right'} size={20} color="currentColor" />
          </button>
        ) : null}
      </div>
    </div>
  );
}
