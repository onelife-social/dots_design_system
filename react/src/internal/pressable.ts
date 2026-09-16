// Keyboard-operable semantics for elements that are not native buttons (WAI-ARIA button pattern).
// A tappable card/row/badge that gets an onClick must also be reachable and activable from the
// keyboard: tab stop + Enter/Space. Internal: not exported from the package surface.
import type { KeyboardEvent } from 'react';

/** onKeyDown that activates `handler` on Enter or Space (and prevents the page scroll of Space). */
export function activateOnKey(handler: () => void) {
  return (e: KeyboardEvent<HTMLElement>) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      handler();
    }
  };
}

/**
 * Spread on a non-button element to make it a complete button: role, tab stop, click and keyboard
 * activation. Returns nothing when there is no handler, so a static element stays static.
 */
export function pressable(onClick?: () => void, role: 'button' | 'radio' | 'menuitem' = 'button') {
  if (!onClick) return {};
  return { role, tabIndex: 0, onClick, onKeyDown: activateOnKey(onClick) };
}
