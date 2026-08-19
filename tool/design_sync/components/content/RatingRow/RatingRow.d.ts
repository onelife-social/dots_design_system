import * as React from 'react';

/**
 * RatingRow — port web de DotsRatingStarRow (Flutter). Fila de estrellas de
 * valoración (escala 5 o NPS de 10) con gradientes detractor/neutral/promoter,
 * textos en los extremos y layout compacto opcional.
 */
export interface RatingRowProps {
  /** Etiquetas de las estrellas — el Dart exige longitud 5 o 10 */
  starLabels: string[];
  /** Texto inferior izquierdo (solo layout default) */
  leftText?: string;
  /** Texto inferior derecho (solo layout default) */
  rightText?: string;
  /** Índice de la estrella seleccionada; null/undefined → todas disabled */
  selectedIndex?: number | null;
  /** Callback al pulsar una estrella */
  onStarTap?: (index: number) => void;
  /** Layout compacto: filas centradas de 6+4 (si hay 10 estrellas) */
  compact?: boolean;
  /** Mostrar la etiqueta sobre cada estrella */
  showStarText?: boolean;
  /** Tamaño del icono de estrella en px — default 28 */
  iconSize?: number;
}

export declare const RatingRow: React.ComponentType<RatingRowProps>;
