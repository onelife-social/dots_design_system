// CreateCard — port of lib/src/components/cards/create_card/create_card.dart (Dart = source of truth).
import type { CSSProperties } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { pressable } from '../../internal/pressable';

/** Dart enum CreateCardVariant */
export type CreateCardVariant = 'label' | 'button';

export interface CreateCardProps {
  /** Card title */
  title: string;
  /** DotsIcon 32 (label variant), e.g. 'ic-pic' */
  icon?: string;
  /** Start color of the horizontal gradient (label variant). Without it falls back to the brand green gradient */
  primaryColor?: string;
  /** End color of the gradient; default = primaryColor */
  secondaryColor?: string;
  /** Width in px (Dart width; the height is fixed at 112). Default 164 */
  width?: number;
  /** Variant — Dart enum CreateCardVariant (default 'label') */
  variant?: CreateCardVariant;
  /** Tap on the card (Dart onTap) */
  onClick?: () => void;
  className?: string;
}

export function CreateCard(props: CreateCardProps) {
  const variant: CreateCardVariant = props.variant === 'button' ? 'button' : 'label'; // CreateCardVariant, default label
  const width = props.width ?? 164; // Dart: width = 164, fixed height 112

  if (variant === 'button') {
    // _PromptCardCreateContent → DotsIconButton large column: add circle + label
    return (
      <div
        className={`ds-create-card ds-create-card--button${props.className ? ` ${props.className}` : ''}`}
        style={{ width }}
        {...pressable(props.onClick)}
      >
        <span className="ds-create-card__circle">
          <DotsIcon name="ic-add" size={16} color="currentColor" />
        </span>
        <span className="ds-create-card__btn-label">{props.title ?? ''}</span>
      </div>
    );
  }

  // label variant — horizontal gradient primaryColor→secondaryColor (Dart paints no background without
  // primaryColor; here it falls back to the brand green gradient of the CSS so the card is not invisible)
  const style: CSSProperties = { width };
  if (props.primaryColor) {
    style.background = `linear-gradient(90deg, ${props.primaryColor}, ${props.secondaryColor || props.primaryColor})`;
  }
  return (
    <div
      className={`ds-create-card ds-create-card--label${props.className ? ` ${props.className}` : ''}`}
      style={style}
      {...pressable(props.onClick)}
    >
      {props.icon ? (
        <span className="ds-create-card__icon">
          <DotsIcon name={props.icon} size={32} color="currentColor" />
        </span>
      ) : null}
      <span className="ds-create-card__title">{props.title ?? ''}</span>
      {/* DotsIconButton medium (Ø28) disabled — bgBtnImage at 40%, white add icon */}
      <span className="ds-create-card__add">
        <DotsIcon name="ic-add" size={14} color="currentColor" />
      </span>
    </div>
  );
}
