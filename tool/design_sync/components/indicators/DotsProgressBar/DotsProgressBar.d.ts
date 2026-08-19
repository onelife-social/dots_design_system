import * as React from 'react';

/**
 * DotsProgressBar — port web de DotsProgressBar (Flutter). Barra de progreso
 * convencional dividida en partes (segmentos redondeados de 5px de alto).
 */
export interface DotsProgressBarProps {
  /** Progreso 0..1 — Dart `percentage` */
  percentage: number;
  /** Número de segmentos (> 0) — Dart `parts`. Default: 3 */
  parts?: number;
  /** Ancho total (px si es number, o cualquier CSS) — Dart `width`. Default: '100%' */
  width?: number | string;
  /** Separación entre segmentos en px — Dart `spaceBetween`. Default: 5 */
  spaceBetween?: number;
  /** Color de la barra — Dart `barColor`. Default: labelHighlight */
  barColor?: string;
  /** Color de fondo de los segmentos — Dart `bgColor`. Default: labelSecondary */
  bgColor?: string;
  className?: string;
}

export declare const DotsProgressBar: React.ComponentType<DotsProgressBarProps> & {
  /** Espejo del factory Dart `DotsProgressBar.byStep(stepNumber, totalSteps)` */
  byStep(stepNumber: number, totalSteps: number): React.ReactElement;
};
