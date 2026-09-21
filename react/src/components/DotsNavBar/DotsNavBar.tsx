// DotsNavBar — port of lib/src/components/nav_bar/nav_bar.dart (Dart = source of truth).
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
  /** The 3 items. Default: Crear (ic-add) / Inicio (ic-home) / Galería (ic-gallery) */
  items?: DotsNavBarItem[];
  /** Active item index (0..2). Default: 0 */
  selectedIndex?: number;
  /** Tap on an item — Dart `DotsNavBarItem.onTap` */
  onSelect?: (index: number) => void;
  className?: string;
}

const MAX_PENDING = 99; // kMaxPendingNumber (lib/src/core/constants.dart)
const DEFAULT_ITEMS: DotsNavBarItem[] = [
  { icon: 'ic-add', label: 'Crear' },
  { icon: 'ic-home', label: 'Inicio' },
  { icon: 'ic-gallery', label: 'Galería' },
];

export function DotsNavBar(props: DotsNavBarProps) {
  const items = props.items ?? DEFAULT_ITEMS;
  const selectedIndex = props.selectedIndex ?? 0;
  const onSelect = props.onSelect;
  return (
    <nav className={`ds-nav-bar${props.className ? ` ${props.className}` : ''}`}>
      {/* Active item pill — AnimatedPositioned left = selectedIndex * 70 (+5 padding) */}
      <span className="ds-nav-bar__pill" style={{ left: `${5 + selectedIndex * 70}px` }} aria-hidden="true" />
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
              <DotsIcon name={item.icon} size={20} color="currentColor" />
              {badge != null ? <span className="ds-nav-bar__badge">{badge}</span> : null}
            </span>
            <span className="ds-nav-bar__label">{item.label}</span>
          </button>
        );
      })}
    </nav>
  );
}
