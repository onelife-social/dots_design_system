import * as React from 'react';

/**
 * PageControl — port web de PageControl (Flutter, dot_book). Puntos de
 * paginación del dotbook: variante `main` (punto activo único) y `background`
 * (progreso acumulado con píldora bgActive del primer punto al activo).
 */
export interface PageControlProps {
  /** Número total de puntos — Dart `count` */
  count: number;
  /** Índice activo, clampado a [0, count-1] — Dart `activeIndex`. Default: 0 */
  activeIndex?: number;
  /** Variante — enum Dart PageControlVariant. Default: 'main' */
  variant?: 'main' | 'background';
  /** Color de los puntos no activos — Dart `dotColor`. Default: labelSecondary */
  dotColor?: string;
  /** Color del punto activo — Dart `activeColor`. Default: labelPrimary (main) / labelActive (background) */
  activeColor?: string;
  className?: string;
}

export declare const PageControl: React.ComponentType<PageControlProps>;
