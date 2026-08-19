import * as React from 'react';

/**
 * DotsMainContainer — port web de DotsMainContainer (Flutter). Contenedor base
 * redondeado con 4 variantes de fondo translúcido, padding 16 y radio
 * automático 24/32 según altura.
 */

/** Enum Dart DotsMainContainerVariant */
export type DotsMainContainerVariant = 'main' | 'secondary' | 'onBackground' | 'tertiary';

export interface DotsMainContainerProps {
  /** Variante de fondo (default 'main') — enum Dart DotsMainContainerVariant */
  variant?: DotsMainContainerVariant;
  /** Ancho CSS o px (default 100%; Dart: ancho de pantalla) */
  width?: number | string;
  /** Alto CSS o px; solo se aplica con forceHeight (Dart: alto de pantalla) */
  height?: number | string;
  /** Padding del contenido en px; solo se aplica si hay children (default 16) */
  padding?: number | string;
  /** Radio en px (default: 24 si height ≤ 100, si no 32) */
  radius?: number | string;
  /** Color CSS que sobreescribe el fondo de la variante */
  backgroundColor?: string;
  /** Imagen de fondo: URL/data URI o cualquier valor CSS de background-image */
  backgroundImage?: string;
  /** Callback de tap — Dart `onTap` (GestureDetector) */
  onClick?: () => void;
  /** Aplica `height` cuando está definido (default true) — Dart `forceHeight` */
  forceHeight?: boolean;
  /** Contenido — Dart `child` */
  children?: React.ReactNode;
  /** Estilo inline extra */
  style?: React.CSSProperties;
  /** Clase CSS extra */
  className?: string;
}

export declare const DotsMainContainer: React.ComponentType<DotsMainContainerProps>;
