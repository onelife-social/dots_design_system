import * as React from 'react';

/**
 * DotsIcon — catálogo de iconos reales del design system (SVG de assets/icons/**
 * embebidos en el bundle). Los monocromos heredan color via currentColor.
 */
export interface DotsIconProps {
  /**
   * Nombre del icono = nombre de archivo del asset sin `.svg` (ej. 'ic-heart').
   * El catálogo completo está en runtime en `DotsIcon.names` (string[]).
   * Un nombre desconocido renderiza un placeholder punteado (no lanza error).
   */
  name: string;
  /** Lado del cuadrado en px (default 24) */
  size?: number;
  /** Color CSS para iconos monocromos (default 'currentColor'; los multicolor lo ignoran) */
  color?: string;
  className?: string;
}

export declare const DotsIcon: React.ComponentType<DotsIconProps> & {
  /** Lista completa de nombres disponibles en el catálogo embebido */
  names: string[];
};
