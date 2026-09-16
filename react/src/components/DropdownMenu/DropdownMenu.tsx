// DropdownMenu — port of lib/src/components/dropdowns/ (dropdown_menu + dropdown_list +
// dropdown_item → a single API; Dart = source of truth).
import { useState, type CSSProperties, type ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

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
  /** Max width of the dropped menu — Dart `menuMaxWidth` */
  menuMaxWidth?: number;
  /** Max height of the dropped menu — Dart `menuMaxHeight` */
  menuMaxHeight?: number;
  /** Notifies the next open/closed state after a button tap */
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
    <div className={cls} style={style} role="menuitem" tabIndex={0} onClick={props.onClick}>
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

  if (!props.label) return renderMenu(props.items, props.width, props.maxHeight);

  const size: DropdownMenuSize = props.size === 'medium' ? 'medium' : 'small'; // DropdownListSize.small default
  const onBackground = props.variant === 'onBackground'; // DropdownListVariant.onBackgroundVariant

  const btnCls =
    `ds-dropdown__btn ds-dropdown__btn--${size}` +
    (active ? ' ds-dropdown__btn--active' : '') +
    (onBackground && !active ? ' ds-dropdown__btn--on-bg' : '') +
    (props.minSize === false ? ' ds-dropdown__btn--expand' : '');

  function handleTap() {
    if (!controlled) setInner(!active);
    props.onToggle?.(!active);
    props.onClick?.();
  }

  return (
    <div className={`ds-dropdown${props.className ? ` ${props.className}` : ''}`}>
      <button type="button" className={btnCls} aria-expanded={active} onClick={handleTap}>
        <span className="ds-dropdown__btn-text">
          {props.label}
          {props.subtitle ? <span className="ds-dropdown__btn-subtitle">{` ${props.subtitle}`}</span> : null}
        </span>
        <DotsIcon name={active ? 'ic-chevron-up' : 'ic-chevron-down'} size={14} color="currentColor" className="ds-dropdown__chevron" />
      </button>
      {active ? <div className="ds-dropdown__overlay">{renderMenu(props.items, props.menuMaxWidth ?? 250, props.menuMaxHeight)}</div> : null}
    </div>
  );
}

DropdownMenu.Item = DropdownMenuItem;
