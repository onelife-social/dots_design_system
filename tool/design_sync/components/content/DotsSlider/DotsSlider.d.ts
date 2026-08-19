import * as React from 'react';

/**
 * DotsSlider — port web de DotsSlider (Flutter). Slider horizontal con iconos a
 * ambos lados, track de 9px, thumb blanco de 28px y divisiones opcionales con
 * snap; drag con pointer events, controlado o no controlado.
 */
export interface DotsSliderProps {
  /** Valor actual (modo controlado) — Dart `value` */
  value?: number;
  /** Valor inicial (modo no controlado, extensión web) */
  defaultValue?: number;
  /** Número de divisiones discretas; null/undefined → continuo — Dart `divisions` */
  divisions?: number | null;
  /** Valor máximo — Dart `max` */
  max?: number;
  /** Se invoca con el nuevo valor al arrastrar/pulsar — Dart `onChanged` */
  onChanged?: (value: number) => void;
  /** Icono izquierdo (asset ic-…) — Dart `leftIcon` */
  leftIcon?: string;
  /** Icono derecho (asset ic-…) — Dart `rightIcon` */
  rightIcon?: string;
}

export declare const DotsSlider: React.ComponentType<DotsSliderProps>;
