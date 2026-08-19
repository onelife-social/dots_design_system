import * as React from 'react';

/**
 * DotsCountdown — port web de CountdownRecap + CountdownEventFinished (Flutter).
 * Tarjeta con blur pensada para vivir sobre foto: cuenta atrás (recap) o
 * tiempo transcurrido desde un evento (small / big).
 */
export interface DotsCountdownProps {
  /**
   * `recap` = CountdownRecap (cuenta atrás con candado);
   * `small` | `big` = enum Dart CountdownEventFinishedVariant.
   * Default: 'recap'
   */
  variant?: 'recap' | 'small' | 'big';

  /* ── variant 'recap' ── */
  /** Título — Dart `title` (recap y big) */
  title?: string;
  /** Fecha objetivo — Dart `countdownDate`. Con ella el contador hace tick cada 1s. */
  targetDate?: Date | string | number;
  /** Valores fijos para diseño estático (alternativa a `targetDate`) */
  days?: number | string;
  hours?: number;
  minutes?: number;
  seconds?: number;
  /** Fuerza el estado terminado (muestra `description`) */
  finished?: boolean;
  /** Texto al terminar — Dart `description` */
  description?: string;
  /** Fondo textDisabled — Dart `isDotbook`. Default: false */
  isDotbook?: boolean;
  hoursLabel?: string;
  minutesLabel?: string;
  secondsLabel?: string;

  /* ── variants 'small' | 'big' (CountdownEventFinished) ── */
  years?: string;
  months?: string;
  yearsLabel?: string;
  monthsLabel?: string;
  /** Etiqueta de días — compartida con recap */
  daysLabel?: string;
  /** Conjunción entre meses y días (small) — Dart `conjunctionText` */
  conjunctionText?: string;
  /** Icono del small — nombre DotsIcon. Default: 'ic-wedding-rings' */
  icon?: string;

  className?: string;
}

export declare const DotsCountdown: React.ComponentType<DotsCountdownProps>;
