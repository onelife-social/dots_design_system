// Keyboard model of a WAI-ARIA `menu` (vertical): roving tabIndex (only the active item is in the
// Tab order), ArrowDown/ArrowUp move with wrap, Home/End jump, Enter/Space activate the item and
// Escape is handed to the owner (a dropdown closes and returns focus to its trigger). Focus moves
// by calling `.focus()` on the item element, kept in an array of refs. Disabled/static rows are
// skipped. Internal: not exported from the package surface.
import { useRef, useState, type FocusEvent, type KeyboardEvent } from 'react';

export interface MenuKeyboardOptions {
  /** Number of `menuitem`s, in DOM order. */
  count: number;
  /** Rows the navigation skips (disabled / static). They still get `tabIndex -1`. */
  isDisabled?: (index: number) => boolean;
  /** Enter / Space on the active item — the same action as its click. */
  onActivate: (index: number) => void;
  /** Escape inside the menu. Omitted → the key is left to the ancestors. */
  onEscape?: () => void;
}

export interface MenuItemKeyboardProps<E extends HTMLElement> {
  ref: (el: E | null) => void;
  tabIndex: 0 | -1;
  onKeyDown: (e: KeyboardEvent<E>) => void;
  onFocus: (e: FocusEvent<E>) => void;
}

export interface MenuKeyboard<E extends HTMLElement> {
  /** Index of the tabbable item: the last focused one, else the first enabled (-1 when none). */
  activeIndex: number;
  /** Props to spread on the `menuitem` at `index`. */
  itemProps: (index: number) => MenuItemKeyboardProps<E>;
  /** Moves DOM focus (and the tab stop) to the item at `index`; falls back to the first enabled. */
  focusItem: (index: number) => void;
}

export function useMenuKeyboard<E extends HTMLElement>(options: MenuKeyboardOptions): MenuKeyboard<E> {
  const { count, isDisabled, onActivate, onEscape } = options;
  const items = useRef<Array<E | null>>([]);
  const [active, setActive] = useState(0);

  const enabled = (i: number) => i >= 0 && i < count && !isDisabled?.(i);
  // Nearest enabled index from `from` (inclusive) walking `dir`, wrapping once; -1 when none.
  const seek = (from: number, dir: 1 | -1): number => {
    for (let n = 0, i = from; n < count; n++, i = (i + dir + count) % count) if (enabled(i)) return i;
    return -1;
  };
  const activeIndex = enabled(active) ? active : seek(0, 1);

  function focusItem(index: number) {
    const target = enabled(index) ? index : seek(0, 1);
    if (target < 0) return;
    setActive(target);
    items.current[target]?.focus();
  }

  function itemProps(index: number): MenuItemKeyboardProps<E> {
    return {
      ref: (el) => {
        items.current[index] = el;
      },
      tabIndex: index === activeIndex ? 0 : -1,
      // A pointer click focuses the row too: the tab stop follows it.
      onFocus: (e) => {
        if (e.target === e.currentTarget && enabled(index)) setActive(index);
      },
      onKeyDown: (e) => {
        // Keys pressed on a nested control (a real button inside the row) are that control's.
        if (e.target !== e.currentTarget) return;
        let next: number;
        switch (e.key) {
          case 'ArrowDown':
            next = seek((index + 1) % count, 1);
            break;
          case 'ArrowUp':
            next = seek((index - 1 + count) % count, -1);
            break;
          case 'Home':
            next = seek(0, 1);
            break;
          case 'End':
            next = seek(count - 1, -1);
            break;
          case 'Enter':
          case ' ':
            e.preventDefault();
            if (enabled(index)) onActivate(index);
            return;
          case 'Escape':
            if (!onEscape) return;
            e.preventDefault();
            e.stopPropagation();
            onEscape();
            return;
          default:
            return;
        }
        e.preventDefault();
        if (next >= 0) focusItem(next);
      },
    };
  }

  return { activeIndex, itemProps, focusItem };
}
