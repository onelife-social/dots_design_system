import * as React from 'react';

/**
 * DotsToggle — port web de DotsToggle (Flutter). Interruptor iOS-style de 44.42×27
 * con knob blanco animado (180 ms).
 */
export interface DotsToggleProps {
  /** Estado seleccionado (modo controlado) — Dart `isSelected` */
  isSelected?: boolean;
  /** Estado inicial (modo no controlado) */
  defaultSelected?: boolean;
  /** Callback con el nuevo valor al pulsar — Dart `onChanged(bool)` */
  onChanged?: (isSelected: boolean) => void;
  /** Deshabilitado (extensión web; el widget Dart no lo expone) */
  disabled?: boolean;
}

export declare const DotsToggle: React.ComponentType<DotsToggleProps>;
