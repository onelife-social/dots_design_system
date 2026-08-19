import * as React from 'react';

/**
 * BadgeProgress — port web de BadgeProgress (Flutter). Contador "current/max" en
 * píldora h36 con icono check-circle azul (labelHighlight).
 */
export interface BadgeProgressProps {
  /** Número a la izquierda. Dart: current */
  current: number;
  /** Número a la derecha. Dart: max */
  max: number;
}

export declare const BadgeProgress: React.ComponentType<BadgeProgressProps>;
