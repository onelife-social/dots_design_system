import * as React from 'react';

/**
 * BadgeLabel — port web de BadgeLabel (Flutter). Píldora de estado con 3 tamaños,
 * 10 variantes de color (incl. gradientes premium) e icono opcional.
 */
export interface BadgeLabelProps {
  /** Texto del badge. Dart: content */
  content: string;
  /** Tamaño — enum Dart BadgeLabelSize (large h34 / medium h22 / small h18) */
  size?: 'large' | 'medium' | 'small';
  /** Variante visual — enum Dart BadgeLabelVariant */
  variant?:
    | 'main'
    | 'secondary'
    | 'green'
    | 'white'
    | 'greenMaterial'
    | 'warning'
    | 'warningMaterial'
    | 'red'
    | 'premiumPlus'
    | 'premium';
  /** Nombre real del icono Dots (p.ej. 'ic-check-circle'), 16px a la izquierda. Dart: badgeIcon */
  badgeIcon?: string;
}

export declare const BadgeLabel: React.ComponentType<BadgeLabelProps>;
