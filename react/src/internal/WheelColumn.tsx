// One scroll-snap column of a wheel picker (DotsCalendar month/year, DotsTimePicker): the row under the
// highlight band is the current one. Internal helper; each component styles it through its own classes.
import { useEffect, useRef, type KeyboardEvent } from 'react';

export const WHEEL_ITEM = 44; // px, row height
export const WHEEL_VISIBLE = 5; // rows visible

// A looping column repeats its items this many times and starts on the middle copy; it jumps back to the
// middle copy (same value, same pixels) only once a settle lands on the first or last copy.
const LOOP_COPIES = 5;

export interface WheelColumnProps {
  items: string[];
  index: number;
  onIndexChange: (i: number) => void;
  ariaLabel: string;
  /** Wraps from the last item to the first, like the Cupertino time wheel */
  loop?: boolean;
  className: string;
  itemClassName: string;
  selectedItemClassName: string;
}

export function WheelColumn(props: WheelColumnProps) {
  const n = props.items.length;
  const copies = props.loop ? LOOP_COPIES : 1;
  const middle = props.loop ? Math.floor(LOOP_COPIES / 2) * n : 0;
  const ref = useRef<HTMLDivElement>(null);
  const settle = useRef<number | undefined>(undefined);
  const lastReported = useRef(props.index);
  const tappedRow = useRef<number | null>(null);

  const rowAt = (el: HTMLDivElement) => Math.max(0, Math.min(n * copies - 1, Math.round(el.scrollTop / WHEEL_ITEM)));
  // The row showing item `i` closest to where the column is now, so a looping wheel never spins the long way.
  const nearestRow = (el: HTMLDivElement, i: number) => {
    if (!props.loop) return i;
    const current = rowAt(el);
    const base = current - (((current % n) + n) % n) + i;
    return [base - n, base, base + n].filter((r) => r >= 0 && r < n * copies).reduce((a, b) => (Math.abs(b - current) < Math.abs(a - current) ? b : a));
  };

  // External index → scroll (instant on mount, smooth after a tap)
  const mounted = useRef(false);
  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    const tapped = tappedRow.current;
    tappedRow.current = null;
    const row = !mounted.current ? middle + props.index : tapped !== null && tapped % n === props.index ? tapped : nearestRow(el, props.index);
    const top = row * WHEEL_ITEM;
    if (Math.abs(el.scrollTop - top) > 1) el.scrollTo({ top, behavior: mounted.current ? 'smooth' : 'auto' });
    mounted.current = true;
    lastReported.current = props.index;
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [props.index]);

  useEffect(() => () => window.clearTimeout(settle.current), []);

  // Scroll → index once the wheel settles (debounced: iOS 16 WebKit has no `scrollend`)
  const onScroll = () => {
    window.clearTimeout(settle.current);
    settle.current = window.setTimeout(() => {
      const el = ref.current;
      if (!el) return;
      const row = rowAt(el);
      const i = row % n;
      if (props.loop && (row < n || row >= n * (copies - 1))) el.scrollTop = (middle + i) * WHEEL_ITEM;
      if (i !== lastReported.current) {
        lastReported.current = i;
        props.onIndexChange(i);
      }
    }, 80);
  };

  const onKeyDown = (e: KeyboardEvent<HTMLDivElement>) => {
    const step = e.key === 'ArrowDown' ? 1 : e.key === 'ArrowUp' ? -1 : 0;
    if (!step) return;
    e.preventDefault();
    const next = props.index + step;
    if (props.loop) props.onIndexChange((next + n) % n);
    else if (next >= 0 && next < n) props.onIndexChange(next);
  };

  const padRows = Math.floor(WHEEL_VISIBLE / 2);
  const rows = Array.from({ length: n * copies }, (_, row) => row);
  return (
    <div ref={ref} className={props.className} role="listbox" aria-label={props.ariaLabel} tabIndex={0} onScroll={onScroll} onKeyDown={onKeyDown}>
      <div style={{ height: padRows * WHEEL_ITEM, flex: 'none' }} />
      {rows.map((row) => {
        const i = row % n;
        const selected = i === props.index;
        return (
          <button
            key={row}
            type="button"
            role="option"
            tabIndex={-1}
            aria-selected={selected}
            aria-hidden={props.loop && row !== middle + i ? true : undefined}
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
