// DropdownMenu — port of lib/src/components/dropdowns/ (dropdown_menu + dropdown_list +
// dropdown_item → a single API; Dart = source of truth).
import {
  useCallback,
  useEffect,
  useLayoutEffect,
  useRef,
  useState,
  type CSSProperties,
  type KeyboardEvent as ReactKeyboardEvent,
  type ReactNode,
} from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { activateOnKey } from '../../internal/pressable';
import { useMenuKeyboard, type MenuItemKeyboardProps } from '../../internal/useMenuKeyboard';

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
interface RowProps extends DropdownMenuItemProps {
  /** Roving focus of the enclosing panel (useMenuKeyboard). Omitted → standalone row with its own tab stop. */
  nav?: MenuItemKeyboardProps<HTMLDivElement>;
}

function Row(props: RowProps) {
  const style: CSSProperties | undefined = props.itemColor ? { color: props.itemColor } : undefined;
  const cls =
    'ds-dropdown__item' + (props.destructive ? ' ds-dropdown__item--destructive' : '') + (props.minSize ? ' ds-dropdown__item--min' : '');
  // Standalone row: a tab stop only when it is actionable (a label-like item without onClick must not
  // read as a broken menu entry).
  const keys = props.nav ?? (props.onClick ? { tabIndex: 0, onKeyDown: activateOnKey(props.onClick) } : {});
  return (
    <div className={cls} style={style} role="menuitem" onClick={props.onClick} {...keys}>
      {props.leading ? <span className="ds-dropdown__item-leading">{props.leading}</span> : null}
      <span className="ds-dropdown__item-text">
        {props.text}
        {props.subtitle ? <span className="ds-dropdown__item-subtitle">{` ${props.subtitle}`}</span> : null}
      </span>
      {props.icon ? <DotsIcon name={props.icon} size={16} color="currentColor" className="ds-dropdown__item-icon" /> : null}
    </div>
  );
}

export function DropdownMenuItem(props: DropdownMenuItemProps) {
  return <Row {...props} />;
}

interface MenuPanelProps {
  items: DropdownMenuItemProps[] | undefined;
  width: number | undefined;
  maxHeight: number | undefined;
  /** Dropped from a button: focus enters the first item when the panel opens */
  autoFocus?: boolean;
  /** Escape inside the panel (dropped mode: close + focus the trigger) */
  onEscape?: () => void;
  /** The panel is going away while it holds the focus (dropped mode: hand it back to the trigger) */
  onFocusLost?: () => void;
}

// DropdownMenu (dropdown_menu.dart) — the panel. Owns the WAI-ARIA menu keyboard model: one
// roving tab stop, arrows/Home/End move, Enter/Space activate, Escape to the owner.
function MenuPanel(p: MenuPanelProps) {
  const items = p.items ?? [];
  const panelRef = useRef<HTMLDivElement>(null);
  const kb = useMenuKeyboard<HTMLDivElement>({
    count: items.length,
    onActivate: (i) => items[i]?.onClick?.(),
    onEscape: p.onEscape,
  });
  const { focusItem } = kb;
  const { autoFocus, onFocusLost } = p;
  // Mount = the panel opens (it is only rendered while active).
  useEffect(() => {
    if (autoFocus) focusItem(0);
  }, []);
  // Layout cleanup runs while the panel is still in the DOM, so the focus can be checked.
  useLayoutEffect(() => {
    return () => {
      const panel = panelRef.current;
      if (panel && panel.contains(document.activeElement)) onFocusLost?.();
    };
  }, []);

  const style: CSSProperties = { width: `${p.width ?? 250}px` };
  if (p.maxHeight != null) {
    style.maxHeight = `${p.maxHeight}px`;
    style.overflowY = 'auto';
  }
  return (
    <div ref={panelRef} className="ds-dropdown__menu" style={style} role="menu" aria-orientation="vertical">
      {items.map((it, i) => (
        <Row key={i} {...it} nav={kb.itemProps(i)} />
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
  const dismiss = useCallback(() => {
    if (!controlled) setInner(false);
    onToggle?.(false);
  }, [controlled, onToggle]);
  useEffect(() => {
    if (!dropped) return;
    const inside = (target: EventTarget | null) => {
      const root = rootRef.current;
      return !!root && target instanceof Node && root.contains(target);
    };
    const onPointerDown = (e: PointerEvent) => {
      if (!inside(e.target)) dismiss();
    };
    // Escape with the focus inside the component is the button's / the menu items' own handler
    // (they also return the focus to the button); here only the outside case.
    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape' && !inside(e.target)) dismiss();
    };
    document.addEventListener('pointerdown', onPointerDown);
    document.addEventListener('keydown', onKeyDown);
    return () => {
      document.removeEventListener('pointerdown', onPointerDown);
      document.removeEventListener('keydown', onKeyDown);
    };
  }, [dropped, dismiss]);

  // A menu already open when the component mounts does not steal the page focus; from then on
  // opening moves the focus into the first item (WAI-ARIA menu button).
  const openAtMount = useRef(dropped);
  useEffect(() => {
    if (!dropped) openAtMount.current = false;
  }, [dropped]);

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

  if (!props.label) return <MenuPanel items={props.items} width={props.width} maxHeight={props.maxHeight} />;

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
  const focusTrigger = () => btnRef.current?.focus();
  function escapeToTrigger() {
    dismiss();
    focusTrigger();
  }
  function onTriggerKeyDown(e: ReactKeyboardEvent<HTMLButtonElement>) {
    if (e.key !== 'Escape' || !active) return;
    e.preventDefault();
    dismiss();
  }

  return (
    <div ref={rootRef} className={`ds-dropdown${props.className ? ` ${props.className}` : ''}`}>
      <button
        ref={btnRef}
        type="button"
        className={btnCls}
        aria-haspopup="menu"
        aria-expanded={active}
        onClick={handleTap}
        onKeyDown={onTriggerKeyDown}
      >
        <span className="ds-dropdown__btn-text">
          {props.label}
          {props.subtitle ? <span className="ds-dropdown__btn-subtitle">{` ${props.subtitle}`}</span> : null}
        </span>
        <DotsIcon name={active ? 'ic-chevron-up' : 'ic-chevron-down'} size={14} color="currentColor" className="ds-dropdown__chevron" />
      </button>
      {active ? (
        <div className="ds-dropdown__overlay">
          <MenuPanel
            items={props.items}
            width={menuWidth}
            maxHeight={props.menuMaxHeight}
            autoFocus={!openAtMount.current}
            onEscape={escapeToTrigger}
            onFocusLost={focusTrigger}
          />
        </div>
      ) : null}
    </div>
  );
}

DropdownMenu.Item = DropdownMenuItem;
