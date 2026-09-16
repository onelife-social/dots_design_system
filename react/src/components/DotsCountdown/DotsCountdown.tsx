// DotsCountdown — port of lib/src/components/countdown/ (CountdownRecap + CountdownEventFinished; Dart = source of truth).
import { useEffect, useState } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** 'recap' = CountdownRecap; 'small' | 'big' = Dart enum CountdownEventFinishedVariant */
export type DotsCountdownVariant = 'recap' | 'small' | 'big';

export interface DotsCountdownProps {
  /**
   * `recap` = CountdownRecap (countdown with lock icon);
   * `small` | `big` = Dart enum CountdownEventFinishedVariant.
   * Default: 'recap'
   */
  variant?: DotsCountdownVariant;

  /* ── variant 'recap' ── */
  /** Title — Dart `title` (recap and big) */
  title?: string;
  /** Target date — Dart `countdownDate`. With it the counter ticks every 1s. */
  targetDate?: Date | string | number;
  /** Fixed values for static design (alternative to `targetDate`) */
  days?: number | string;
  hours?: number;
  minutes?: number;
  seconds?: number;
  /** Forces the finished state (shows `description`) */
  finished?: boolean;
  /** Text when finished — Dart `description` */
  description?: string;
  /** textDisabled background — Dart `isDotbook`. Default: false */
  isDotbook?: boolean;
  hoursLabel?: string;
  minutesLabel?: string;
  secondsLabel?: string;

  /* ── variants 'small' | 'big' (CountdownEventFinished) ── */
  years?: string;
  months?: string;
  yearsLabel?: string;
  monthsLabel?: string;
  /** Days label — shared with recap */
  daysLabel?: string;
  /** Conjunction between months and days (small) — Dart `conjunctionText` */
  conjunctionText?: string;
  /** Small variant icon — DotsIcon name. Default: 'ic-wedding-rings' */
  icon?: string;

  className?: string;
}

interface Remaining {
  finished: boolean;
  days: number | string;
  hours: number;
  minutes: number;
  seconds: number;
}

function pad2(v: number | string | null | undefined) {
  const s = String(v == null ? 0 : v);
  return s.length >= 2 ? s : `0${s}`;
}

function remainingOf(target: number): Remaining {
  const diff = target - Date.now();
  if (diff <= 0) return { finished: true, days: 0, hours: 0, minutes: 0, seconds: 0 };
  const s = Math.floor(diff / 1000);
  return {
    finished: false,
    days: Math.floor(s / 86400),
    hours: Math.floor(s / 3600) % 24,
    minutes: Math.floor(s / 60) % 60,
    seconds: s % 60,
  };
}

function icon(name: string, size: number) {
  return <DotsIcon name={name} size={size} color="var(--label-always-white)" />;
}

// _CountdownTimeItem / _CountdownEventFinishedBigItem — value titleH4 + label labelSmallMedium
function timeItem(key: string, value: string | number, label: string, dimLabel: boolean) {
  return (
    <span key={key} className="ds-countdown__item">
      <span className="ds-countdown__item-value">{value}</span>
      <span className={`ds-countdown__item-label${dimLabel ? ' is-dim' : ''}`}>{label}</span>
    </span>
  );
}

export function DotsCountdown(props: DotsCountdownProps) {
  const variant: DotsCountdownVariant = props.variant || 'recap';
  // An unparsable targetDate gives NaN: normalize it to null so it behaves like "no target"
  // (no interval, fixed/zero values) instead of ticking forever and rendering NaN.
  const parsed = props.targetDate == null ? NaN : new Date(props.targetDate).getTime();
  const target = Number.isFinite(parsed) ? parsed : null;

  // 1s tick (Timer.periodic of _CountdownRecapState) — only with targetDate in variant recap.
  const live = target != null && variant === 'recap';
  const [, setTick] = useState(0);
  useEffect(() => {
    if (!live || target == null) return undefined;
    if (remainingOf(target).finished) return undefined;
    const id = setInterval(() => {
      setTick((n) => n + 1);
      // Dart's _timer?.cancel() on reaching zero
      if (remainingOf(target).finished) clearInterval(id);
    }, 1000);
    return () => {
      clearInterval(id);
    };
  }, [target, live]);

  const className =
    `ds-countdown ds-countdown--${variant}` +
    (variant === 'recap' && props.isDotbook ? ' ds-countdown--dotbook' : '') +
    (props.className ? ` ${props.className}` : '');

  if (variant === 'small') {
    // _CountdownEventFinishedSmallBody — h36, icon 16 + text labelDefaultBold
    const text = (
      `${props.years || ''} ${props.yearsLabel || ''} ` +
      `${props.months || ''} ${props.monthsLabel || ''} ` +
      `${props.conjunctionText || ''} ` +
      `${props.days || ''} ${props.daysLabel || ''}`
    )
      .replace(/\s+/g, ' ')
      .trim();
    return (
      <span className={className}>
        {icon(props.icon || 'ic-wedding-rings', 16)}
        <span className="ds-countdown__small-text">{text}</span>
      </span>
    );
  }

  if (variant === 'big') {
    // _CountdownEventFinishedBigBody — w169, title + years/months/days row
    return (
      <span className={className}>
        <span className="ds-countdown__title">{props.title || ''}</span>
        <span className="ds-countdown__times ds-countdown__times--big">
          {timeItem('y', props.years || '', props.yearsLabel || '', false)}
          {timeItem('m', props.months || '', props.monthsLabel || '', false)}
          {timeItem('d', props.days || '', props.daysLabel || '', false)}
        </span>
      </span>
    );
  }

  // variant 'recap' — CountdownRecap: running counter or finished body
  let r: Remaining;
  if (target != null) {
    r = remainingOf(target);
  } else {
    // Fixed values for static design
    r = {
      finished: !!props.finished,
      days: props.days || 0,
      hours: props.hours || 0,
      minutes: props.minutes || 0,
      seconds: props.seconds || 0,
    };
  }
  return (
    <span className={className}>
      {icon('ic-lock', 20)}
      <span className="ds-countdown__title">{props.title || ''}</span>
      {r.finished ? (
        <span className="ds-countdown__desc">{props.description || ''}</span>
      ) : (
        <span className="ds-countdown__times">
          {timeItem('d', pad2(r.days), props.daysLabel || '', true)}
          {timeItem('h', pad2(r.hours), props.hoursLabel || '', true)}
          {timeItem('m', pad2(r.minutes), props.minutesLabel || '', true)}
          {timeItem('s', pad2(r.seconds), props.secondsLabel || '', true)}
        </span>
      )}
    </span>
  );
}
