// DotsCalendar — inline month calendar. New in the web DS (no Dart widget yet): the Flutter app
// uses the cupertino_calendar_picker package themed by CupertinoCalendarPickerUtils (onelife_app),
// whose styles this port mirrors: header "Month year ⌄" opening a month/year picker, prev/next
// arrows, today ring, selected filled circle, disabled/outside days muted.
import { useEffect, useMemo, useRef, useState } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsIconButton } from '../DotsIconButton/DotsIconButton';

export interface DotsCalendarProps {
  /** Selected day as ISO yyyy-mm-dd; '' or undefined = nothing selected (controlled) */
  value?: string;
  /** Called with the tapped day as ISO yyyy-mm-dd */
  onChange?: (iso: string) => void;
  /** Month shown at first (yyyy-mm); defaults to the value's month, else today's */
  initialMonth?: string;
  /** Today as ISO yyyy-mm-dd (override for previews/tests; default: the device date) */
  today?: string;
  /** BCP-47 locale for month and weekday names (default: navigator.language) */
  locale?: string;
  /** First column of the grid: 1 = Monday (default), 0 = Sunday */
  firstDayOfWeek?: 0 | 1;
  /** Days before today: 'muted' greys them but keeps them selectable (default), 'disabled' blocks them, 'normal' paints them as any other */
  pastDays?: 'normal' | 'muted' | 'disabled';
  /** Earliest / latest selectable day, ISO yyyy-mm-dd (inclusive) */
  minDate?: string;
  maxDate?: string;
  /** Years offered by the month/year picker (default: today's year - 5 … + 10) */
  yearRange?: [number, number];
  /** Start with the month/year picker open (previews) */
  initialPicking?: boolean;
  className?: string;
}

interface Day {
  y: number;
  m: number; // 0-11
  d: number;
  iso: string;
  outside: boolean;
}

const pad = (n: number) => String(n).padStart(2, '0');
const toISO = (y: number, m: number, d: number) => `${y}-${pad(m + 1)}-${pad(d)}`;
const parseISO = (iso?: string): [number, number, number] | null => {
  const m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(iso ?? '');
  return m ? [Number(m[1]), Number(m[2]) - 1, Number(m[3])] : null;
};
const todayISO = () => {
  const t = new Date();
  return toISO(t.getFullYear(), t.getMonth(), t.getDate());
};
const capitalize = (s: string) => (s ? s[0].toLocaleUpperCase() + s.slice(1) : s);

function monthGrid(y: number, m: number, firstDayOfWeek: 0 | 1): Day[] {
  const first = new Date(y, m, 1);
  const lead = (first.getDay() - firstDayOfWeek + 7) % 7; // days of the previous month shown
  const daysInMonth = new Date(y, m + 1, 0).getDate();
  const total = Math.ceil((lead + daysInMonth) / 7) * 7;
  const days: Day[] = [];
  for (let i = 0; i < total; i++) {
    const date = new Date(y, m, 1 - lead + i);
    days.push({ y: date.getFullYear(), m: date.getMonth(), d: date.getDate(), iso: toISO(date.getFullYear(), date.getMonth(), date.getDate()), outside: date.getMonth() !== m });
  }
  return days;
}

const ITEM = 44; // px, picker row height (also the day cell height)
const VISIBLE = 5; // picker rows visible

export function DotsCalendar(props: DotsCalendarProps) {
  const locale = props.locale ?? (typeof navigator !== 'undefined' ? navigator.language : 'es');
  const firstDayOfWeek = props.firstDayOfWeek ?? 1;
  const pastDays = props.pastDays ?? 'muted';
  const today = props.today ?? todayISO();
  const selected = parseISO(props.value);

  const initial = useMemo(() => {
    const m = /^(\d{4})-(\d{2})$/.exec(props.initialMonth ?? '');
    if (m) return [Number(m[1]), Number(m[2]) - 1] as const;
    const src = selected ?? parseISO(today)!;
    return [src[0], src[1]] as const;
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
  const [year, setYear] = useState(initial[0]);
  const [month, setMonth] = useState(initial[1]);
  const [picking, setPicking] = useState(!!props.initialPicking);

  const monthFmt = useMemo(() => new Intl.DateTimeFormat(locale, { month: 'long' }), [locale]);
  const weekdayFmt = useMemo(() => new Intl.DateTimeFormat(locale, { weekday: 'narrow' }), [locale]);
  const monthNames = useMemo(() => Array.from({ length: 12 }, (_, i) => capitalize(monthFmt.format(new Date(2024, i, 1)))), [monthFmt]);
  const weekdays = useMemo(
    () => Array.from({ length: 7 }, (_, i) => weekdayFmt.format(new Date(2024, 0, 7 + firstDayOfWeek + i))), // 2024-01-07 is a Sunday
    [weekdayFmt, firstDayOfWeek],
  );
  const todayYear = parseISO(today)![0];
  const [yearFrom, yearTo] = props.yearRange ?? [todayYear - 5, todayYear + 10];
  const years = useMemo(() => Array.from({ length: Math.max(1, yearTo - yearFrom + 1) }, (_, i) => yearFrom + i), [yearFrom, yearTo]);

  const days = useMemo(() => monthGrid(year, month, firstDayOfWeek), [year, month, firstDayOfWeek]);

  const isDisabled = (iso: string) =>
    (pastDays === 'disabled' && iso < today) || (props.minDate !== undefined && iso < props.minDate) || (props.maxDate !== undefined && iso > props.maxDate);

  const go = (delta: number) => {
    const date = new Date(year, month + delta, 1);
    setYear(date.getFullYear());
    setMonth(date.getMonth());
  };

  const pick = (day: Day) => {
    if (isDisabled(day.iso)) return;
    if (day.outside) {
      setYear(day.y);
      setMonth(day.m);
    }
    props.onChange?.(day.iso);
  };

  const label = `${monthNames[month]} ${year}`;

  return (
    <div className={`ds-calendar${props.className ? ` ${props.className}` : ''}`}>
      <div className="ds-calendar__header">
        <button type="button" className="ds-calendar__month-btn" aria-expanded={picking} onClick={() => setPicking((v) => !v)}>
          <span className="ds-calendar__month-label">{label}</span>
          <span className={`ds-calendar__chevron${picking ? ' ds-calendar__chevron--open' : ''}`} aria-hidden>
            <DotsIcon name="ic-chevron-down" size={16} />
          </span>
        </button>
        <div className="ds-calendar__spacer" />
        {!picking ? (
          <div className="ds-calendar__nav">
            <DotsIconButton icon="ic-chevron-left" size="small" style="noBackground" onClick={() => go(-1)} />
            <DotsIconButton icon="ic-chevron-right" size="small" style="noBackground" onClick={() => go(1)} />
          </div>
        ) : null}
      </div>

      {!picking ? (
        <div className="ds-calendar__grid" role="grid" aria-label={label}>
          {weekdays.map((w, i) => (
            <div key={`w${i}`} className="ds-calendar__weekday" role="columnheader">
              {w}
            </div>
          ))}
          {days.map((day) => {
            const isSelected = !!selected && day.iso === toISO(selected[0], selected[1], selected[2]);
            const isToday = day.iso === today;
            const disabled = isDisabled(day.iso);
            const muted = pastDays === 'muted' && day.iso < today && !isSelected;
            const cls = [
              'ds-calendar__day',
              day.outside ? 'ds-calendar__day--outside' : '',
              muted ? 'ds-calendar__day--muted' : '',
              isToday ? 'ds-calendar__day--today' : '',
              isSelected ? 'ds-calendar__day--selected' : '',
              disabled ? 'ds-calendar__day--disabled' : '',
            ]
              .filter(Boolean)
              .join(' ');
            return (
              <button
                key={day.iso}
                type="button"
                role="gridcell"
                className={cls}
                aria-selected={isSelected}
                aria-current={isToday ? 'date' : undefined}
                aria-disabled={disabled || undefined}
                onClick={() => pick(day)}
              >
                <span className="ds-calendar__num">{day.d}</span>
              </button>
            );
          })}
        </div>
      ) : (
        <div className="ds-calendar__picker">
          <div className="ds-calendar__band" aria-hidden />
          <WheelColumn items={monthNames} index={month} onIndexChange={setMonth} ariaLabel="month" />
          <WheelColumn items={years.map(String)} index={Math.max(0, years.indexOf(year))} onIndexChange={(i) => setYear(years[i])} ariaLabel="year" />
        </div>
      )}
    </div>
  );
}

// One scroll-snap column of the month/year picker: the item under the band is the current one.
function WheelColumn(props: { items: string[]; index: number; onIndexChange: (i: number) => void; ariaLabel: string }) {
  const ref = useRef<HTMLDivElement>(null);
  const settle = useRef<number | undefined>(undefined);
  const lastReported = useRef(props.index);

  // External index → scroll (instant on mount, smooth after a tap)
  const mounted = useRef(false);
  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    const top = props.index * ITEM;
    if (Math.abs(el.scrollTop - top) > 1) el.scrollTo({ top, behavior: mounted.current ? 'smooth' : 'auto' });
    mounted.current = true;
    lastReported.current = props.index;
  }, [props.index]);

  // Scroll → index once the wheel settles (debounced: iOS 16 WebKit has no `scrollend`)
  const onScroll = () => {
    window.clearTimeout(settle.current);
    settle.current = window.setTimeout(() => {
      const el = ref.current;
      if (!el) return;
      const i = Math.max(0, Math.min(props.items.length - 1, Math.round(el.scrollTop / ITEM)));
      if (i !== lastReported.current) {
        lastReported.current = i;
        props.onIndexChange(i);
      }
    }, 80);
  };

  const padRows = Math.floor(VISIBLE / 2);
  return (
    <div ref={ref} className="ds-calendar__col" role="listbox" aria-label={props.ariaLabel} onScroll={onScroll}>
      <div style={{ height: padRows * ITEM, flex: 'none' }} />
      {props.items.map((item, i) => (
        <button
          key={item}
          type="button"
          role="option"
          aria-selected={i === props.index}
          className={`ds-calendar__item${i === props.index ? ' ds-calendar__item--selected' : ''}`}
          onClick={() => props.onIndexChange(i)}
        >
          {item}
        </button>
      ))}
      <div style={{ height: padRows * ITEM, flex: 'none' }} />
    </div>
  );
}
