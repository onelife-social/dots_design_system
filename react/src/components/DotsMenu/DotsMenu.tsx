// DotsMenu — port of lib/src/components/menu/ (dots_menu.dart + dots_menu_item_model.dart
// + settings_item.dart + settings_list.dart; Dart = source of truth).
import { useLayoutEffect, useRef, useState, type CSSProperties, type MouseEvent, type ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsToggle } from '../DotsToggle/DotsToggle';
import { pressable } from '../../internal/pressable';
import { useMenuKeyboard, type MenuItemKeyboardProps } from '../../internal/useMenuKeyboard';

/** Dart DotsMenuItemModel */
export interface DotsMenuItemModel {
  /** Unique id — Dart `id` */
  id: string | number;
  /** Main text (bodyDefaultMedium) — Dart `label` */
  label: string;
  /** Second line in textTertiary — Dart `details` */
  details?: string;
  /** Trailing DotsIcon name (16px, labelPrimary) — Dart `icon` */
  icon?: string;
  /** Shows a 14px labelHighlight check on the left — Dart `selected` */
  selected?: boolean;
  /** Tints label and icons with labelDestructive — Dart `isDelete` */
  isDelete?: boolean;
  /** Sub items — tapping navigates into this level — Dart `subItems` */
  subItems?: DotsMenuItemModel[];
  /** 0.5px divider after the item — Dart `addDivider` */
  addDivider?: boolean;
  /** Dart `onTap` */
  onClick?: () => void;
}

export interface DotsMenuProps {
  /** Header item of the menu — Dart `mainItem` */
  mainItem: DotsMenuItemModel;
  /** First-level sub items — Dart `subitems` */
  subitems: DotsMenuItemModel[];
  /** Opens the menu directly at the level containing this id — Dart `defaultSelectedItemId` */
  defaultSelectedItemId?: string | number;
  className?: string;
}

/** Dart enum SettingsItemVariant */
export type DotsMenuSettingsItemVariant = 'icon' | 'toggle';

export interface DotsMenuSettingsItemProps {
  /** Row with trailing icon or with toggle — Dart enum SettingsItemVariant */
  variant: DotsMenuSettingsItemVariant;
  /** Text (bodyDefaultMedium) — Dart `label` */
  label: string;
  /** Leading icon 20px textTertiary — Dart `startIcon` */
  startIcon?: string;
  /** Trailing icon 16px textTertiary (variant 'icon' only) — Dart `endIcon` */
  endIcon?: string;
  /** Toggle state (variant 'toggle' only) — Dart `toggleValue` */
  toggleValue?: boolean;
  /** Tap on the toggle — Dart `onToggleTap` */
  onToggleTap?: () => void;
  /** Tap on the row — Dart `onTap` */
  onClick?: () => void;
  /** CSS color of the label — Dart `textColor` */
  textColor?: string;
  /** Label alignment — Dart `textAlignment` (default 'left') */
  textAlignment?: 'left' | 'center' | 'right';
}

export interface DotsMenuSettingsListProps {
  /** Uppercased title above the list — Dart `title` */
  title?: string;
  /** Description below the list — Dart `description` */
  description?: string;
  /** Settings rows — Dart `items` */
  items: DotsMenuSettingsItemProps[];
  /** Horizontal padding of title/description — Dart `textPadding` (default 15) */
  textPadding?: number;
  className?: string;
}

// ── DotsMenu — contextual menu with nested navigation through subItems ──────
function findStack(subItems: DotsMenuItemModel[] | undefined, targetId: string | number): DotsMenuItemModel[] {
  for (const it of subItems ?? []) {
    if (it.id === targetId) return [it];
    if (it.subItems && it.subItems.length) {
      const stack = findStack(it.subItems, targetId);
      if (stack.length) return [it, ...stack];
    }
  }
  return [];
}

interface MenuItemProps {
  item: DotsMenuItemModel;
  isExpanded: boolean;
  isInitialItem?: boolean;
  /** Click / Enter / Space action. Omitted → static row: no role, outside the keyboard navigation. */
  onTap?: () => void;
  /** Roving focus of the enclosing `menu` (useMenuKeyboard) */
  nav: MenuItemKeyboardProps<HTMLDivElement>;
}

function MenuItem(p: MenuItemProps) {
  const item = p.item;
  // Dart _MenuItem.leftIcon: selected → check; subItems && !initial → chevron down/right
  let leftIcon: string | null = null;
  if (item.selected) leftIcon = 'ic-check';
  else if (item.subItems && item.subItems.length && !p.isInitialItem) {
    leftIcon = p.isExpanded ? 'ic-chevron-down' : 'ic-chevron-right';
  }
  const iconColor = item.isDelete ? 'var(--label-destructive)' : item.selected ? 'var(--label-highlight)' : null;
  const textStyle: CSSProperties | undefined = item.isDelete ? { color: 'var(--label-destructive)' } : undefined;
  const rowProps = p.onTap ? { role: 'menuitem' as const, onClick: p.onTap, ...p.nav } : {};

  return (
    <div className={`ds-menu__item${item.details != null ? ' ds-menu__item--details' : ''}`} {...rowProps}>
      {leftIcon ? <DotsIcon name={leftIcon} size={14} color={iconColor ?? 'var(--text-primary)'} className="ds-menu__item-left" /> : null}
      <span className="ds-menu__item-body">
        <span className="ds-menu__item-label" style={textStyle}>
          {item.label}
        </span>
        {item.details != null ? (
          <span className="ds-menu__item-details" style={textStyle}>
            {item.details}
          </span>
        ) : null}
      </span>
      {item.icon ? <DotsIcon name={item.icon} size={16} color={iconColor ?? 'var(--label-primary)'} className="ds-menu__item-right" /> : null}
    </div>
  );
}

interface MenuState {
  stack: DotsMenuItemModel[];
  selected: DotsMenuItemModel;
}

export function DotsMenu(props: DotsMenuProps) {
  const [state, setState] = useState<MenuState>(() => {
    const root: DotsMenuItemModel = { ...props.mainItem, subItems: props.subitems ?? [] };
    let stack: DotsMenuItemModel[] = [];
    let selected = root;
    if (props.defaultSelectedItemId != null && props.defaultSelectedItemId !== root.id) {
      const path = findStack(root.subItems, props.defaultSelectedItemId);
      if (path.length) {
        selected = path.pop() as DotsMenuItemModel;
        stack = [root, ...path];
      }
    }
    return { stack, selected };
  });
  const selected = state.selected;
  const isInitialItem = state.stack.length === 0;
  const subs = selected.subItems ?? [];
  const scrollable = subs.length > 7; // Dart: > 7 subitems → maxHeight 336 with scroll

  // Keyboard model (WAI-ARIA menu): the header row is item 0 and the sub items follow, all under
  // one roving tab stop. The header is only a menu item when tapping it does something (goes
  // back a level, or the item has an onClick); at the root without onClick it is a static title.
  const headerTaps = !isInitialItem || !!selected.onClick;
  // Row to focus once a level change has rendered (entering: first sub item; back: the row the
  // level was entered from) — applied in the layout effect below.
  const pendingFocus = useRef<number | null>(null);

  function tapHeader() {
    selected.onClick?.();
    if (!state.stack.length) return;
    const stack = state.stack.slice();
    const parent = stack.pop() as DotsMenuItemModel;
    pendingFocus.current = 1 + (parent.subItems ?? []).indexOf(selected);
    setState({ selected: parent, stack });
  }
  function tapSub(item: DotsMenuItemModel) {
    item.onClick?.();
    if (!item.subItems || !item.subItems.length) return;
    pendingFocus.current = 1;
    setState({ stack: [...state.stack, selected], selected: item });
  }

  const kb = useMenuKeyboard<HTMLDivElement>({
    count: 1 + subs.length,
    isDisabled: (i) => i === 0 && !headerTaps,
    onActivate: (i) => (i === 0 ? tapHeader() : tapSub(subs[i - 1])),
  });
  const { focusItem } = kb;
  useLayoutEffect(() => {
    if (pendingFocus.current == null) return;
    const index = pendingFocus.current;
    pendingFocus.current = null;
    focusItem(index);
  });

  const children: ReactNode[] = [];
  subs.forEach((item, i) => {
    children.push(<MenuItem key={`i${i}`} item={item} isExpanded={false} onTap={() => tapSub(item)} nav={kb.itemProps(1 + i)} />);
    const isLast = i === subs.length - 1;
    if (item.addDivider && !isLast) children.push(<div key={`d${i}`} className="ds-menu__divider ds-menu__divider--item" />);
    else if (!isLast) children.push(<div key={`s${i}`} className="ds-menu__spacer" />);
  });

  return (
    <div className={`ds-menu${props.className ? ` ${props.className}` : ''}`} role="menu" aria-orientation="vertical">
      <MenuItem item={selected} isExpanded isInitialItem={isInitialItem} onTap={headerTaps ? tapHeader : undefined} nav={kb.itemProps(0)} />
      <div className="ds-menu__divider" />
      <div className={`ds-menu__list${scrollable ? ' ds-menu__list--scroll' : ''}`}>{children}</div>
    </div>
  );
}

// ── DotsMenu.SettingsItem — settings_item.dart ──────────────────────────────
export function DotsMenuSettingsItem(p: DotsMenuSettingsItemProps) {
  const isToggle = p.variant === 'toggle'; // SettingsItemVariant
  const labelStyle: CSSProperties = {};
  if (p.textColor) labelStyle.color = p.textColor;
  if (p.textAlignment) labelStyle.textAlign = p.textAlignment;
  // One focusable control per row: variant 'icon' → the row itself (pressable when it has a
  // handler); variant 'toggle' → the embedded DotsToggle is the control and the row only forwards
  // its click (not focusable, no role) so the toggle is not nested inside a second button.
  const rowProps = isToggle ? { onClick: p.onClick ?? p.onToggleTap } : pressable(p.onClick);
  return (
    <div className={`ds-menu-settings__item${isToggle ? ' ds-menu-settings__item--toggle' : ''}`} {...rowProps}>
      {p.startIcon ? <DotsIcon name={p.startIcon} size={20} color="var(--text-tertiary)" className="ds-menu-settings__start" /> : null}
      <span className="ds-menu-settings__label" style={labelStyle}>
        {p.label}
      </span>
      {isToggle ? (
        // Dart: DotsToggle(isSelected: toggleValue, onChanged: onToggleTap); the tap does not reach the row
        <span className="ds-menu-settings__toggle" onClick={(e: MouseEvent<HTMLSpanElement>) => e.stopPropagation()}>
          <DotsToggle isSelected={!!p.toggleValue} onChanged={() => p.onToggleTap?.()} />
        </span>
      ) : p.endIcon ? (
        <DotsIcon name={p.endIcon} size={16} color="var(--text-tertiary)" />
      ) : null}
    </div>
  );
}

// ── DotsMenu.SettingsList — settings_list.dart ──────────────────────────────
export function DotsMenuSettingsList(props: DotsMenuSettingsListProps) {
  const items = props.items ?? [];
  const textPad = props.textPadding ?? 15; // Dart: 15
  const rows: ReactNode[] = [];
  items.forEach((item, i) => {
    rows.push(<DotsMenuSettingsItem key={`i${i}`} {...item} />);
    if (i < items.length - 1) rows.push(<div key={`d${i}`} className="ds-menu-settings__divider" />);
  });
  return (
    <div className={`ds-menu-settings${props.className ? ` ${props.className}` : ''}`}>
      {props.title ? (
        <div className="ds-menu-settings__title" style={{ margin: `0 ${textPad}px 8px` }}>
          {String(props.title).toUpperCase()}
        </div>
      ) : null}
      {items.length ? <div className="ds-menu-settings__list">{rows}</div> : null}
      {props.description ? (
        <div className="ds-menu-settings__desc" style={{ margin: `8px ${textPad}px 0` }}>
          {props.description}
        </div>
      ) : null}
    </div>
  );
}

DotsMenu.SettingsList = DotsMenuSettingsList;
DotsMenu.SettingsItem = DotsMenuSettingsItem;
