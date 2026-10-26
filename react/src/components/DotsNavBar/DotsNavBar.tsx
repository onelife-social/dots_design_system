// DotsNavBar — port of lib/src/components/nav_bar/nav_bar.dart (Dart = source of truth).
// Unlike Dart's fixed 70px items, an item grows to fit its label: a fixed width wraps any
// label over 54px onto two lines (weddings_app#380).
import { useLayoutEffect, useRef, useState } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Dart DotsNavBarItem */
export interface DotsNavBarItem {
  /** Real DS icon name (assets/icons) — Dart `iconData`. E.g. 'ic-home' */
  icon: string;
  /** Label below the icon */
  label: string;
  /** Numeric badge over the icon — Dart `pendingNumber` (shown up to 99) */
  badge?: number;
}

export interface DotsNavBarProps {
  /** The items (Dart: exactly 3). Default: Crear (ic-add) / Inicio (ic-home) / Galería (ic-gallery) */
  items?: DotsNavBarItem[];
  /** Active item index (0-based). Default: 0 */
  selectedIndex?: number;
  /** Tap on an item — Dart `DotsNavBarItem.onTap` */
  onSelect?: (index: number) => void;
  className?: string;
}

const MAX_PENDING = 99; // kMaxPendingNumber (lib/src/core/constants.dart)
const ITEM_PADDING_X = 16; // .ds-nav-bar__item side padding outside tight mode, both sides
const ICON_SIZE = 20;
const DEFAULT_ITEMS: DotsNavBarItem[] = [
  { icon: 'ic-add', label: 'Crear' },
  { icon: 'ic-home', label: 'Inicio' },
  { icon: 'ic-gallery', label: 'Galería' },
];

export function DotsNavBar(props: DotsNavBarProps) {
  const items = props.items ?? DEFAULT_ITEMS;
  const selectedIndex = props.selectedIndex ?? 0;
  const onSelect = props.onSelect;
  const navRef = useRef<HTMLElement>(null);
  const [pill, setPill] = useState<{ left: number; width: number } | null>(null);
  const [tight, setTight] = useState(false);
  const labelsKey = items.map((item) => item.label).join('\n');

  useLayoutEffect(() => {
    const nav = navRef.current;
    if (!nav) return;
    const buttons = Array.from(nav.querySelectorAll<HTMLElement>('.ds-nav-bar__item'));
    const measure = () => {
      const navBox = nav.getBoundingClientRect();
      if (navBox.width === 0 || nav.offsetWidth === 0) return;
      // Rects are in screen pixels: undo an ancestor scale (e.g. a zoomed design canvas), keeping
      // the fractional rect when there is none (offsetWidth rounds).
      const scale = Math.abs(navBox.width - nav.offsetWidth) < 1 ? 1 : navBox.width / nav.offsetWidth;
      const fromNavLeft = (x: number) => (x - navBox.left) / scale;
      const navStyle = getComputedStyle(nav);
      const borderLeft = parseFloat(navStyle.borderLeftWidth);
      const contentLeft = borderLeft + parseFloat(navStyle.paddingLeft);
      const contentRight = navBox.width / scale - parseFloat(navStyle.borderRightWidth) - parseFloat(navStyle.paddingRight);
      if (!tight) {
        const overflows = buttons.some((button) => {
          const box = button.getBoundingClientRect();
          return fromNavLeft(box.left) < contentLeft - 0.5 || fromNavLeft(box.right) > contentRight + 0.5;
        });
        if (overflows) {
          setTight(true);
          return;
        }
      } else {
        // An item's width outside tight mode, from the label's full width even when it is cut. scrollWidth
        // rounds to a whole pixel: 1px per item of margin.
        const needed = buttons.reduce((sum, button) => {
          const label = button.querySelector<HTMLElement>('.ds-nav-bar__label')?.scrollWidth ?? 0;
          return sum + Math.max(label, ICON_SIZE) + ITEM_PADDING_X;
        }, 0);
        if (needed + buttons.length <= contentRight - contentLeft) {
          setTight(false);
          return;
        }
      }
      const box = buttons[selectedIndex]?.getBoundingClientRect();
      if (box && box.width > 0) {
        const left = fromNavLeft(box.left) - borderLeft;
        const width = box.width / scale;
        setPill((prev) => (prev && prev.left === left && prev.width === width ? prev : { left, width }));
      }
    };
    measure();
    if (typeof ResizeObserver === 'undefined') return;
    const observer = new ResizeObserver(measure);
    observer.observe(nav);
    buttons.forEach((button) => observer.observe(button));
    return () => observer.disconnect();
  }, [selectedIndex, labelsKey, tight]);

  return (
    <nav ref={navRef} className={`ds-nav-bar${tight ? ' is-tight' : ''}${props.className ? ` ${props.className}` : ''}`}>
      {/* Mounted with its first measurement, so it does not slide in from the first item */}
      {pill ? <span className="ds-nav-bar__pill" style={{ left: `${pill.left}px`, width: `${pill.width}px` }} aria-hidden="true" /> : null}
      {items.map((item, i) => {
        const selected = i === selectedIndex;
        const badge = item.badge == null ? null : item.badge > MAX_PENDING ? String(MAX_PENDING) : String(item.badge);
        return (
          <button
            key={i}
            type="button"
            className={`ds-nav-bar__item${selected ? ' is-selected' : ''}`}
            aria-current={selected ? 'page' : undefined}
            onClick={onSelect ? () => onSelect(i) : undefined}
          >
            <span className="ds-nav-bar__icon-wrap">
              <DotsIcon name={item.icon} size={ICON_SIZE} color="currentColor" />
              {badge != null ? <span className="ds-nav-bar__badge">{badge}</span> : null}
            </span>
            <span className="ds-nav-bar__label">{item.label}</span>
          </button>
        );
      })}
    </nav>
  );
}
