// DropdownMenu — port of lib/src/components/dropdowns/ (dropdown_menu + dropdown_list +
// dropdown_item → a single API; Dart = source of truth).
import { useEffect, useLayoutEffect, useRef, useState, type CSSProperties, type ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { activateOnKey } from '../../internal/pressable';

/** Dart enum DropdownListSize */
export type DropdownMenuSize = 'small' | 'medium';
/** Dart enum DropdownListVariant (defaultVariant → 'default', onBackgroundVariant → 'onBackground') */
export type DropdownMenuVariant = 'default' | 'onBackground';

export interface DropdownMenuItemProps {
  /** Main text (bodyDefaultMedium) — Dart `DropdownItem.text` */
  text: string;
  /** Inline subtitle in textSecondary — Dart `subtitle` */
  subtitle?: string;
  /** Optional leading node — Dart `leading` */
  leading?: ReactNode;
  /** Trailing DotsIcon name (16px) — Dart `icon` (DotsIconData) */
  icon?: string;
  /** CSS color tinting text and icon — Dart `itemColor` */
  itemColor?: string;
  /** Shortcut for itemColor = labelDestructive */
  destructive?: boolean;
  /** The item shrinks to its content — Dart `minSize` (default false) */
  minSize?: boolean;
  /** Dart `onTap` */
  onClick?: () => void;
}

export interface DropdownMenuProps {
  /** Menu items — Dart `DropdownMenu.items` / `DropdownList.items` */
  items: DropdownMenuItemProps[];
  /** Panel width in px — Dart `DropdownMenu.width` (default 250) */
  width?: number;
  /** Max panel height, scrolls beyond it — Dart `maxHeight` */
  maxHeight?: number;
  /** Dropdown button text. Omitted → only the panel is painted — Dart `DropdownList.label` */
  label?: string;
  /** Button subtitle in textTertiary — Dart `subtitle` */
  subtitle?: string;
  /** Button size — Dart enum DropdownListSize (default 'small') */
  size?: DropdownMenuSize;
  /** Variant — Dart enum DropdownListVariant (default 'default') */
  variant?: DropdownMenuVariant;
  /** Open menu (controlled) — Dart `isActive` */
  isActive?: boolean;
  /** Initial open state in uncontrolled mode */
  defaultActive?: boolean;
  /** The button shrinks to its content — Dart `minSize` (default true) */
  minSize?: boolean;
  /** Max width of the dropped menu; the menu never exceeds the button width — Dart `menuMaxWidth` */
  menuMaxWidth?: number;
  /** Max height of the dropped menu — Dart `menuMaxHeight` */
  menuMaxHeight?: number;
  /** Notifies the next open/closed state: after a button tap, and `false` on outside pointer / Escape */
  onToggle?: (active: boolean) => void;
  /** Tap on the button — Dart `DropdownList.onTap` */
  onClick?: () => void;
  className?: string;
}

// DropdownItem (dropdown_item.dart) — menu row: text + inline subtitle,
// optional leading, trailing icon 16, pressed → bgContainerSecondary
export function DropdownMenuItem(props: DropdownMenuItemProps) {
  const style: CSSProperties | undefined = props.itemColor ? { color: props.itemColor } : undefined;
  const cls =
    'ds-dropdown__item' + (props.destructive ? ' ds-dropdown__item--destructive' : '') + (props.minSize ? ' ds-dropdown__item--min' : '');
  return (
    <div
      className={cls}
      style={style}
      role="menuitem"
      tabIndex={0}
      onClick={props.onClick}
      onKeyDown={props.onClick ? activateOnKey(props.onClick) : undefined}
    >
      {props.leading ? <span className="ds-dropdown__item-leading">{props.leading}</span> : null}
      <span className="ds-dropdown__item-text">
        {props.text}
        {props.subtitle ? <span className="ds-dropdown__item-subtitle">{` ${props.subtitle}`}</span> : null}
      </span>
      {props.icon ? <DotsIcon name={props.icon} size={16} color="currentColor" className="ds-dropdown__item-icon" /> : null}
    </div>
  );
}

function renderMenu(items: DropdownMenuItemProps[] | undefined, width: number | undefined, maxHeight: number | undefined) {
  const style: CSSProperties = { width: `${width ?? 250}px` };
  if (maxHeight != null) {
    style.maxHeight = `${maxHeight}px`;
    style.overflowY = 'auto';
  }
  return (
    <div className="ds-dropdown__menu" style={style} role="menu">
      {(items ?? []).map((it, i) => (
        <DropdownMenuItem key={i} {...it} />
      ))}
    </div>
  );
}

// DropdownList (dropdown_list.dart) + DropdownMenu (dropdown_menu.dart).
// Without `label` it renders only the menu panel; with `label`, button + menu dropped
// below when active (controlled isActive, or internal toggle).
export function DropdownMenu(props: DropdownMenuProps) {
  const [inner, setInner] = useState(!!props.defaultActive);
  const controlled = props.isActive !== undefined && props.isActive !== null;
  const active = controlled ? !!props.isActive : inner;
  const dropped = !!props.label && active; // the button + overlay form only exists with a label

  const rootRef = useRef<HTMLDivElement>(null);
  const btnRef = useRef<HTMLButtonElement>(null);
  // Button width measured while the menu is open (Dart `_buttonWidth`, `_scheduleMeasure`).
  const [triggerWidth, setTriggerWidth] = useState<number | undefined>(undefined);
  const { onToggle } = props;

  // Outside dismissal. The Dart overlay covers the screen with a translucent, unpainted
  // GestureDetector whose tap fires the same `onTap` the button uses, so the consumer closes it;
  // here a pointerdown outside the component root (button + menu) and Escape close the menu and
  // notify `onToggle(false)`. No backdrop element: the Dart paints nothing.
  useEffect(() => {
    if (!dropped) return;
    const dismiss = () => {
      if (!controlled) setInner(false);
      onToggle?.(false);
    };
    const onPointerDown = (e: PointerEvent) => {
      const root = rootRef.current;
      if (root && e.target instanceof Node && root.contains(e.target)) return;
      dismiss();
    };
    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') dismiss();
    };
    document.addEventListener('pointerdown', onPointerDown);
    document.addEventListener('keydown', onKeyDown);
    return () => {
      document.removeEventListener('pointerdown', onPointerDown);
      document.removeEventListener('keydown', onKeyDown);
    };
  }, [dropped, controlled, onToggle]);

  // Measure the button when the menu opens and follow its resizes while open
  // (Dart re-measures on tap and on label/subtitle/size/variant changes).
  useLayoutEffect(() => {
    const el = btnRef.current;
    if (!dropped || !el) return;
    const measure = () => setTriggerWidth(el.getBoundingClientRect().width);
    measure();
    if (typeof ResizeObserver === 'undefined') return;
    const observer = new ResizeObserver(measure);
    observer.observe(el);
    return () => observer.disconnect();
  }, [dropped]);

  if (!props.label) return renderMenu(props.items, props.width, props.maxHeight);

  const size: DropdownMenuSize = props.size === 'medium' ? 'medium' : 'small'; // DropdownListSize.small default
  const onBackground = props.variant === 'onBackground'; // DropdownListVariant.onBackgroundVariant

  const btnCls =
    `ds-dropdown__btn ds-dropdown__btn--${size}` +
    (active ? ' ds-dropdown__btn--active' : '') +
    (onBackground && !active ? ' ds-dropdown__btn--on-bg' : '') +
    (props.minSize === false ? ' ds-dropdown__btn--expand' : '');

  // dropdown_list.dart `_showOverlay`:
  //   menuWidth = (buttonWidth != null && menuMaxWidth != null)
  //     ? min(buttonWidth, menuMaxWidth) : buttonWidth ?? menuMaxWidth
  // and DropdownMenu falls back to 250 when that is still null (renderMenu does the same).
  // Before the first measurement only menuMaxWidth (or 250) applies.
  const menuWidth =
    triggerWidth != null && props.menuMaxWidth != null ? Math.min(triggerWidth, props.menuMaxWidth) : (triggerWidth ?? props.menuMaxWidth);

  function handleTap() {
    if (!controlled) setInner(!active);
    props.onToggle?.(!active);
    props.onClick?.();
  }

  return (
    <div ref={rootRef} className={`ds-dropdown${props.className ? ` ${props.className}` : ''}`}>
      <button ref={btnRef} type="button" className={btnCls} aria-expanded={active} onClick={handleTap}>
        <span className="ds-dropdown__btn-text">
          {props.label}
          {props.subtitle ? <span className="ds-dropdown__btn-subtitle">{` ${props.subtitle}`}</span> : null}
        </span>
        <DotsIcon name={active ? 'ic-chevron-up' : 'ic-chevron-down'} size={14} color="currentColor" className="ds-dropdown__chevron" />
      </button>
      {active ? <div className="ds-dropdown__overlay">{renderMenu(props.items, menuWidth, props.menuMaxHeight)}</div> : null}
    </div>
  );
}

DropdownMenu.Item = DropdownMenuItem;
