// RecapCard — port of lib/src/components/cards/recap/ (recap_card.dart + recap_card_locked.dart
// unified via the `locked` prop; CountdownRecap from countdown_recap.dart embedded). Dart = source of truth.
import { useEffect, useState, type MouseEvent, type SyntheticEvent } from 'react';
import { BadgeLabel } from '../BadgeLabel/BadgeLabel';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsMainButton } from '../DotsMainButton/DotsMainButton';
import { pressable } from '../../internal/pressable';

/** Dart enum RecapCardVariant (onlyTitle = active without title/badge/button) */
export type RecapCardVariant = 'active' | 'blocked' | 'generated' | 'onlyTitle';
/** Dart enum RecapCardLockedVariant */
export type RecapCardLockedVariant = 'countdown' | 'locked' | 'soon';

export interface RecapCardProps {
  /** true → renders RecapCardLocked (7:8, countdown); false/omitted → RecapCard (4:5) */
  locked?: boolean;
  /** Variant without locked — Dart enum RecapCardVariant (default 'active') */
  variant?: RecapCardVariant;
  /** Variant with locked — Dart enum RecapCardLockedVariant (default 'countdown') */
  lockedVariant?: RecapCardLockedVariant;
  /** Width in px (Dart width; required in Dart). Default 220 */
  width?: number;
  /** Background photo URL (Dart imageProvider). Without it a gradient placeholder is painted */
  imageSrc?: string;
  /** URL of the overlaid text image (Dart textImageProvider, only without locked) */
  textImageSrc?: string;
  /** Title (without locked: top row with ic-clock--timer · locked: countdown title) */
  title?: string;
  /** Text of the premium large BadgeLabel (without locked, not in blocked) */
  badgeText?: string;
  /** Label of the bottom DotsMainButton (active/blocked; locked: locked variant) */
  buttonText?: string;
  /** Album name (generated variant) */
  albumName?: string;
  /** Author (generated variant), e.g. "Creado por Ana" */
  createdBy?: string;
  /** Countdown description when there is no countdown running (locked/soon or countdown finished) */
  description?: string;
  /** Unlock date (ISO/Date) — live countdown (lockedVariant countdown) */
  countdownDate?: string | number | Date;
  /** Countdown labels */
  daysLabel?: string;
  hoursLabel?: string;
  minutesLabel?: string;
  secondsLabel?: string;
  /** Blur the background image (Dart blurImageProvider, locked only; blocked always blurs it) */
  blurImage?: boolean;
  /** Tap on the card / main button without locked (Dart onTap) */
  onClick?: () => void;
  /** Tap on the info/share/lock button (Dart onInfoTap) */
  onInfoClick?: () => void;
  /** Tap on the bottom button with locked (Dart onButtonTap) */
  onButtonClick?: () => void;
  className?: string;
}

const VARIANTS: Record<RecapCardVariant, true> = { active: true, blocked: true, generated: true, onlyTitle: true };
const LOCKED_VARIANTS: Record<RecapCardLockedVariant, true> = { countdown: true, locked: true, soon: true };

// Keeps inner taps from also firing the card's onClick
const stopWrap = (fn?: () => void) => (fn ? (e?: MouseEvent) => { e?.stopPropagation(); fn(); } : undefined);
// Keys on inner native buttons (Enter/Space) must not reach the pressable card either
function stopKeys(e: SyntheticEvent) {
  e.stopPropagation();
}

function pad2(n: number) {
  return (n < 10 ? '0' : '') + n;
}

function imageLayer(props: RecapCardProps, blurred: boolean) {
  return (
    <div
      className={`ds-recap-card__img${props.imageSrc ? '' : ' ds-recap-card__img--ph'}${blurred ? ' ds-recap-card__img--blur' : ''}`}
      style={props.imageSrc ? { backgroundImage: `url("${props.imageSrc}")` } : undefined}
    />
  );
}

export function RecapCard(props: RecapCardProps) {
  const locked = !!props.locked;
  const lockedVariant: RecapCardLockedVariant = props.lockedVariant && LOCKED_VARIANTS[props.lockedVariant] ? props.lockedVariant : 'countdown';
  const variant: RecapCardVariant = props.variant && VARIANTS[props.variant] ? props.variant : 'active'; // Dart: factories; web default active
  const width = props.width ?? 220;

  // CountdownRecap — 1s tick while there is time left (Dart: Timer.periodic)
  const target = locked && lockedVariant === 'countdown' && props.countdownDate ? new Date(props.countdownDate).getTime() : 0;
  const [, setTick] = useState(0);
  useEffect(() => {
    if (!target || target - Date.now() <= 0) return undefined;
    const id = setInterval(() => {
      if (target - Date.now() <= 0) clearInterval(id);
      setTick((n) => n + 1);
    }, 1000);
    return () => clearInterval(id);
  }, [target]);
  const remaining = target ? Math.max(0, target - Date.now()) : 0;

  return locked ? renderLocked(props, lockedVariant, width, remaining) : renderUnlocked(props, variant, width);
}

// ---- RecapCard (recap_card.dart): 4:5, squircle52, black 30% overlay + 2px borderButton border ----
function renderUnlocked(props: RecapCardProps, variant: RecapCardVariant, width: number) {
  const isBlocked = variant === 'blocked';
  const isGenerated = variant === 'generated';
  const isOnlyTitle = variant === 'onlyTitle'; // Dart: active without title/badge/button

  const title = isOnlyTitle ? null : props.title;
  const badgeText = isOnlyTitle ? null : props.badgeText;
  const buttonText = isOnlyTitle ? null : props.buttonText;

  // Right side of the top row (premium badge / share / lock)
  let control = null;
  if (!isBlocked && badgeText) {
    control = <BadgeLabel content={badgeText} variant="premium" size="large" />;
  } else if (isGenerated && !badgeText) {
    // DotsIconButton floating large Ø44 · share icon 24 · textPrimary
    control = (
      <button type="button" className="ds-recap-card__icon-btn" onClick={stopWrap(props.onInfoClick)} onKeyDown={stopKeys} aria-label="share">
        <DotsIcon name="ic-share" size={24} color="currentColor" />
      </button>
    );
  } else if (isBlocked) {
    // DotsIconButton floating large Ø44 · lock · bgBtnImage at 50%
    control = (
      <button
        type="button"
        className="ds-recap-card__icon-btn ds-recap-card__icon-btn--half"
        onClick={stopWrap(props.onInfoClick)}
        onKeyDown={stopKeys}
        aria-label="lock"
      >
        <DotsIcon name="ic-lock" size={24} color="currentColor" />
      </button>
    );
  }

  // Bottom zone: createdBy (generated) or main DotsMainButton with blur
  let bottom = null;
  if (isGenerated) {
    bottom = (
      <div className="ds-recap-card__created-by">
        {props.albumName ? <span>{props.albumName}</span> : null}
        {props.createdBy ? <span>{props.createdBy}</span> : null}
      </div>
    );
  } else if (buttonText) {
    bottom = <DotsMainButton label={buttonText} variant="main" expand={false} shouldApplyBlur onClick={stopWrap(props.onClick)} />;
  }

  return (
    <div
      className={`ds-recap-card${props.className ? ` ${props.className}` : ''}`}
      style={{ width: `${width}px` }}
      {...pressable(props.onClick)}
    >
      {imageLayer(props, isBlocked) /* blocked → ImageFilter.blur(15) */}
      <div className="ds-recap-card__overlay">
        {props.textImageSrc ? <div className="ds-recap-card__text-img" style={{ backgroundImage: `url("${props.textImageSrc}")` }} /> : null}
      </div>
      <div className="ds-recap-card__inner">
        <div className="ds-recap-card__title-row">
          {title ? (
            <span className="ds-recap-card__ttl">
              <DotsIcon name="ic-clock--timer" size={16} color="currentColor" />
              {title}
            </span>
          ) : (
            <span />
          )}
          {control}
        </div>
        <div className="ds-recap-card__bottom" onKeyDown={stopKeys}>
          {bottom}
        </div>
      </div>
    </div>
  );
}

// ---- RecapCardLocked (recap_card_locked.dart): 7:8, squircle52, pad 20, CountdownRecap ----
function renderLocked(props: RecapCardProps, lockedVariant: RecapCardLockedVariant, width: number, remaining: number) {
  const showTimes = lockedVariant === 'countdown' && remaining > 0;
  let body;
  if (showTimes) {
    const d = Math.floor(remaining / 86400000);
    const hrs = Math.floor(remaining / 3600000) % 24;
    const min = Math.floor(remaining / 60000) % 60;
    const sec = Math.floor(remaining / 1000) % 60;
    body = (
      <div className="ds-recap-card__times">
        {timeItem(pad2(d), props.daysLabel)}
        {timeItem(pad2(hrs), props.hoursLabel)}
        {timeItem(pad2(min), props.minutesLabel)}
        {timeItem(pad2(sec), props.secondsLabel)}
      </div>
    );
  } else {
    // Dart: countdown finished (or locked/soon variants) → description
    body = <div className="ds-recap-card__cd-desc">{props.description || ''}</div>;
  }

  return (
    <div className={`ds-recap-card ds-recap-card--locked${props.className ? ` ${props.className}` : ''}`} style={{ width: `${width}px` }}>
      {imageLayer(props, !!props.blurImage) /* blurImageProvider → ImageFilter.blur(15) */}
      <div className="ds-recap-card__inner">
        {lockedVariant !== 'soon' ? (
          <button
            type="button"
            className="ds-recap-card__icon-btn ds-recap-card__icon-btn--medium ds-recap-card__info"
            onClick={props.onInfoClick}
            aria-label="info"
          >
            <DotsIcon name="ic-info" size={20} color="currentColor" />
          </button>
        ) : null}
        {/* CountdownRecap — w192 r24 white 30% border + blur20 */}
        <div className="ds-recap-card__countdown">
          <span className="ds-recap-card__cd-lock">
            <DotsIcon name="ic-lock" size={20} color="currentColor" />
          </span>
          <div className="ds-recap-card__cd-ttl">{props.title || ''}</div>
          {body}
        </div>
        {lockedVariant === 'locked' && props.buttonText ? (
          <div className="ds-recap-card__bottom">
            <DotsMainButton label={props.buttonText} variant="main" expand={false} icon="ic-gallery" onClick={props.onButtonClick} />
          </div>
        ) : null}
      </div>
    </div>
  );
}

function timeItem(value: string, label?: string) {
  return (
    <span className="ds-recap-card__t">
      <span className="ds-recap-card__t-v">{value}</span>
      <span className="ds-recap-card__t-l">{label || ''}</span>
    </span>
  );
}
