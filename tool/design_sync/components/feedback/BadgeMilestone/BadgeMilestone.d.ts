import * as React from 'react';

/**
 * BadgeMilestone — port web de BadgeMilestone (Flutter). Píldora de hito (radio 22)
 * sobre bgBase con blur 25, texto textTertiary; pensada para flotar sobre las
 * fotos de MilestoneCard.
 */
export interface BadgeMilestoneProps {
  /** Texto del hito. Dart: content */
  content: string;
  /** Variante — enum Dart BadgeMilestoneVariant. main: borde 1px bgSecondaryBtn, pad v 9 · ghost: sin borde, pad v 6 */
  variant?: 'main' | 'ghost';
}

export declare const BadgeMilestone: React.ComponentType<BadgeMilestoneProps>;
