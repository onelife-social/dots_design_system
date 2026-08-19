import * as React from 'react';

/**
 * DotsDivider — port web de DotsDivider (Flutter). Separador horizontal de dos
 * líneas de 1px (labelSecondary sobre bgStrong) al 60% de opacidad, con efecto
 * de relieve sutil.
 */
export interface DotsDividerProps {
  /** Ancho CSS o px (default 100% — Dart double.infinity) */
  width?: number | string;
  /** Clase CSS extra */
  className?: string;
}

export declare const DotsDivider: React.ComponentType<DotsDividerProps>;
