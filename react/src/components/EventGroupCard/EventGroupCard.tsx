// EventGroupCard — port of lib/src/components/cards/group_cards/event_group_card.dart (Dart = source of truth).
import type { MouseEvent, ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsMainButton } from '../DotsMainButton/DotsMainButton';

export interface EventGroupCardAction {
  /** DotsIcon name, e.g. 'ic-camera' */
  icon: string;
  /** Text under the icon */
  text: string;
  onClick?: () => void;
}

export type EventGroupCardVariant = 'small' | 'active' | 'passed';

export interface EventGroupCardProps {
  /** Variant — Dart enum EventGroupCardVariant */
  variant?: EventGroupCardVariant;
  /** Background photo URL (Dart imageProvider). Without it a gradient placeholder is painted */
  imageSrc?: string;
  /** Title (small: bottom · active/passed: top) */
  title?: string;
  /** Secondary text (active: "· N participantes" · passed: label of the secondary button) */
  secondaryText?: string;
  /** Icon of the top-left CardTag (Dart tagIconData), e.g. 'ic-prime-1' */
  tagIcon?: string;
  /** Bottom blurred menu actions (active/passed only) — Dart GroupEventCardModel */
  actions?: EventGroupCardAction[];
  /** Blocked group: centered lock and no tag */
  isBlocked?: boolean;
  /** Height of the bottom fade (Dart edgeSize; default 60 small / 110 others) */
  edgeSize?: number;
  /** Side in px (the card is 1:1; Dart clamps 135–160 small / 288–340 others). Default 148 / 288 */
  size?: number;
  /** Tap on the card (Dart onTap) */
  onClick?: () => void;
  /** Tap on the secondary text/button (Dart onSecondaryTap) */
  onSecondaryClick?: () => void;
  className?: string;
}

// Keeps inner taps from also firing the card's onClick
const stopWrap = (fn?: () => void) => (fn ? (e?: MouseEvent) => { e?.stopPropagation(); fn(); } : undefined);

export function EventGroupCard(props: EventGroupCardProps) {
  const variant: EventGroupCardVariant = props.variant === 'active' || props.variant === 'passed' ? props.variant : 'small'; // Dart: default small
  const isSmall = variant === 'small';
  // Dart: AspectRatio 1:1 with constraints 135–160 (small) / 288–340 (others)
  const size = props.size ?? (isSmall ? 148 : 288);
  const edge = props.edgeSize ?? (isSmall ? 60 : 110);
  const actions = props.actions ?? [];
  const isBlocked = !!props.isBlocked;

  let secondary: ReactNode = null;
  if (!isSmall) {
    secondary =
      variant === 'active' ? (
        // 3×3 dot + labelSmallRegular white 70% (web: hidden while there is no text, so no lone dot)
        !props.secondaryText ? null : (
        <div className="ds-event-card__sec" onClick={stopWrap(props.onSecondaryClick)}>
          <span className="ds-event-card__sec-dot" />
          {props.secondaryText}
        </div>
        )
      ) : (
        // passed → DotsMainButton secondary small with ic-exit-fullscreen (iconSize 14, white text)
        <div className="ds-event-card__sec-wrap">
          <DotsMainButton
            label={props.secondaryText ?? ''}
            variant="secondary"
            size="small"
            icon="ic-exit-fullscreen"
            iconSize={14}
            textColor="#FFFFFF" // labelAlwaysWhite
            iconColor="#FFFFFF"
            expand={false}
            onClick={stopWrap(props.onSecondaryClick)}
          />
        </div>
      );
  }

  return (
    <div
      className={`ds-event-card ds-event-card--${variant}${props.className ? ` ${props.className}` : ''}`}
      style={{ width: size, height: size }}
      onClick={props.onClick}
      role={props.onClick ? 'button' : undefined}
    >
      <div
        className={`ds-event-card__img${props.imageSrc ? '' : ' ds-event-card__img--ph'}`}
        style={props.imageSrc ? { backgroundImage: `url("${props.imageSrc}")` } : undefined}
      />
      <div
        className={`ds-event-card__blur${props.imageSrc ? '' : ' ds-event-card__img--ph'}`}
        style={{
          ...(props.imageSrc ? { backgroundImage: `url("${props.imageSrc}")` } : {}),
          maskImage: `linear-gradient(180deg, transparent calc(100% - ${edge}px), #000 100%)`,
          WebkitMaskImage: `linear-gradient(180deg, transparent calc(100% - ${edge}px), #000 100%)`,
        }}
      />
      <div className="ds-event-card__fade" style={{ height: edge }} />
      {!isSmall ? <div className="ds-event-card__top-grad" /> : null}
      {isSmall ? <div className="ds-event-card__title--small">{props.title ?? ''}</div> : null}
      {!isBlocked && props.tagIcon ? (
        <span className={`ds-event-card__tag ${isSmall ? 'ds-event-card__tag--small' : 'ds-event-card__tag--big'}`}>
          <DotsIcon name={props.tagIcon} size={20} color="currentColor" />
        </span>
      ) : null}
      {isBlocked ? (
        <div className="ds-event-card__lock">
          <DotsIcon name="ic-lock" size={32} color="currentColor" />
        </div>
      ) : null}
      {!isSmall ? (
        <div className="ds-event-card__head">
          <div className="ds-event-card__head-title">{props.title ?? ''}</div>
          {secondary}
        </div>
      ) : null}
      {/* _MenuEvent — blur50 pill on bgBtnDisabled with the actions (omitted without actions) */}
      {!isSmall && actions.length ? (
        <div className="ds-event-card__menu">
          {actions.map((a, i) => (
            <span key={i} style={{ display: 'contents' }}>
              {i > 0 ? <span className="ds-event-card__sep" /> : null}
              <button type="button" className="ds-event-card__act" onClick={stopWrap(a.onClick)}>
                <DotsIcon name={a.icon} size={20} color="currentColor" />
                <span>{a.text}</span>
              </button>
            </span>
          ))}
        </div>
      ) : null}
    </div>
  );
}
