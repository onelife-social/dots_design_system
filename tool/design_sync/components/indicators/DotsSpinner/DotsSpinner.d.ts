import * as React from 'react';

/**
 * DotsSpinner — port web de SpinnerRound (Flutter). Spinner circular que pinta
 * track + arco de progreso y, opcionalmente, el porcentaje centrado.
 */
export interface DotsSpinnerProps {
  /** Progreso 0..1 — Dart `progress` */
  progress?: number;
  /** Lado en px — Dart `size`. Default: 43 */
  size?: number;
  /** Grosor del trazo — Dart `strokeWidth`. Default: 4 */
  strokeWidth?: number;
  /** Muestra el % centrado — Dart `showPercentage`. Default: true */
  showPercentage?: boolean;
  /** Extensión web: gira indefinidamente (ignora `progress`, oculta el %) */
  indeterminate?: boolean;
  className?: string;
}

export declare const DotsSpinner: React.ComponentType<DotsSpinnerProps>;
