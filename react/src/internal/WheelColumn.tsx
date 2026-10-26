// One scroll-snap column of a wheel picker (DotsCalendar month/year, DotsTimePicker): the row under the
// highlight band is the current one. Internal helper; each component styles it through its own classes.
import { useEffect, useId, useRef, type KeyboardEvent } from 'react';

export const WHEEL_ITEM = 44; // px, row height
export const WHEEL_VISIBLE = 5; // rows visible

// A looping column repeats its items this many times and rests on the middle copy: once a scroll settles on
// another copy it jumps back to the same row of the middle one (same pixels), so a fling never reaches an end.
const LOOP_COPIES = 5;

export interface WheelColumnProps {
  items: string[];
  index: number;
  /** Called as soon as another row passes under the band (while scrolling too), after a tap and on arrow keys */
  onIndexChange: (i: number) => void;
  ariaLabel: string;
  /** Wraps from the last item to the first, like the Cupertino time wheel */
  loop?: boolean;
  className: string;
  itemClassName: string;
  selectedItemClassName: string;
}

export function WheelColumn(props: WheelColumnProps) {
  const latest = useRef(props);
  latest.current = props;
  const id = useId();
  const n = props.items.length;
  const copies = props.loop ? LOOP_COPIES : 1;
  const middleCopy = Math.floor(copies / 2);
  const middle = middleCopy * n;
  const ref = useRef<HTMLDivElement>(null);
  const settle = useRef<number | undefined>(undefined);
  const lastReported = useRef(props.index);
  const tappedRow = useRef<number | null>(null);
  // Row a smooth programmatic scroll is heading to: the rows it passes on the way are not reported.
  const target = useRef<number | null>(null);

  const rowAt = (el: HTMLDivElement) => Math.max(0, Math.min(n * copies - 1, Math.round(el.scrollTop / WHEEL_ITEM)));
  // The row showing item `i` closest to where the column is now, so a looping wheel never spins the long way.
  const nearestRow = (el: HTMLDivElement, i: number) => {
    if (!props.loop) return i;
    const current = rowAt(el);
    const base = current - (current % n) + i;
    return [base - n, base, base + n].filter((r) => r >= 0 && r < n * copies).reduce((a, b) => (Math.abs(b - current) < Math.abs(a - current) ? b : a));
  };

  const report = (i: number) => {
    if (i === lastReported.current) return;
    lastReported.current = i;
    latest.current.onIndexChange(i);
  };

  // Index → scroll: instant on mount; smooth when it comes from outside, a tap or a key. An index this column
  // reported itself is already under the band, so the scroll the user is making is left alone.
  const mounted = useRef(false);
  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    const tapped = tappedRow.current;
    tappedRow.current = null;
    if (mounted.current && props.index === lastReported.current) return;
    lastReported.current = props.index;
    const row = !mounted.current ? middle + props.index : tapped !== null && tapped % n === props.index ? tapped : nearestRow(el, props.index);
    const top = row * WHEEL_ITEM;
    if (Math.abs(el.scrollTop - top) > 1) {
      target.current = mounted.current ? row : null;
      el.scrollTo({ top, behavior: mounted.current ? 'smooth' : 'auto' });
    }
    mounted.current = true;
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [props.index]);

  useEffect(() => () => window.clearTimeout(settle.current), []);

  const onScroll = () => {
    const el = ref.current;
    if (!el) return;
    // Settled (debounced: iOS 16 WebKit has no `scrollend`): drop a target the user interrupted, back to the middle copy.
    window.clearTimeout(settle.current);
    settle.current = window.setTimeout(() => {
      target.current = null;
      const row = rowAt(el);
      if (latest.current.loop && Math.floor(row / n) !== middleCopy) el.scrollTop = (middle + (row % n)) * WHEEL_ITEM;
      report(row % n);
    }, 80);
    const row = rowAt(el);
    if (target.current !== null) {
      if (row !== target.current) return;
      target.current = null;
    }
    report(row % n);
  };

  const onKeyDown = (e: KeyboardEvent<HTMLDivElement>) => {
    const i = props.index;
    const next = { ArrowDown: i + 1, ArrowUp: i - 1, Home: 0, End: n - 1 }[e.key];
    if (next === undefined) return;
    e.preventDefault();
    if (props.loop) props.onIndexChange((next + n) % n);
    else if (next >= 0 && next < n && next !== i) props.onIndexChange(next);
  };

  const padRows = Math.floor(WHEEL_VISIBLE / 2);
  const rows = Array.from({ length: n * copies }, (_, row) => row);
  return (
    <div
      ref={ref}
      className={props.className}
      role="listbox"
      aria-label={props.ariaLabel}
      aria-activedescendant={`${id}-${middle + props.index}`}
      tabIndex={0}
      onScroll={onScroll}
      onKeyDown={onKeyDown}
    >
      <div style={{ height: padRows * WHEEL_ITEM, flex: 'none' }} />
      {rows.map((row) => {
        const i = row % n;
        const selected = i === props.index;
        return (
          <button
            key={row}
            id={`${id}-${row}`}
            type="button"
            role="option"
            tabIndex={-1}
            aria-selected={selected}
            aria-hidden={row - i !== middle ? true : undefined}
            className={`${props.itemClassName}${selected ? ` ${props.selectedItemClassName}` : ''}`}
            onClick={() => {
              tappedRow.current = row;
              props.onIndexChange(i);
            }}
          >
            {props.items[i]}
          </button>
        );
      })}
      <div style={{ height: padRows * WHEEL_ITEM, flex: 'none' }} />
    </div>
  );
}
