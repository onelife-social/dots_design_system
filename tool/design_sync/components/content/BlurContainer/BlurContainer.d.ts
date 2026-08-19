import * as React from 'react';

/**
 * BlurContainer — port web de BlurContainer (Flutter): blurea todo su contenido
 * (sigma 0–5). Incluye BlurContainer.GradientBlur, port de DotsLinearGradientBlur:
 * blur progresivo definido por un gradiente lineal (values/stops/start/end) + tint,
 * como el fade de los nombres de álbum del home.
 */

/** Flutter Alignment (subset de 9 posiciones) */
export type BlurAlignment =
  | 'topLeft' | 'topCenter' | 'topRight'
  | 'centerLeft' | 'center' | 'centerRight'
  | 'bottomLeft' | 'bottomCenter' | 'bottomRight';

export interface BlurContainerProps {
  /** Cantidad de blur en px (Dart sigma, clamp 0–5) */
  sigma: number;
  /** Contenido a blurear — Dart `child` */
  children?: React.ReactNode;
  /** Clase CSS extra */
  className?: string;
}

export interface GradientBlurProps {
  /** Desviación del blur en px — Dart `sigma` (default 8) */
  sigma?: number;
  /** Fuerza del blur en cada stop, 0 (nada) a 1 (máximo) — Dart LinearGradientBlur.values (default [0, 1]) */
  values?: number[];
  /** Posiciones 0–1 de cada value — Dart LinearGradientBlur.stops (default equiespaciados) */
  stops?: number[];
  /** Inicio del gradiente (default 'topCenter') — Dart LinearGradientBlur.start */
  start?: BlurAlignment;
  /** Fin del gradiente (default 'bottomCenter') — Dart LinearGradientBlur.end */
  end?: BlurAlignment;
  /** Color CSS de tinte sobre la zona blureada — Dart `tintColor` (default transparente) */
  tintColor?: string;
  /** Contenido — Dart `child` */
  children?: React.ReactNode;
  /** Clase CSS extra */
  className?: string;
}

export interface BlurContainerComponent extends React.FC<BlurContainerProps> {
  /** Port de DotsLinearGradientBlur (blur progresivo) */
  GradientBlur: React.ComponentType<GradientBlurProps>;
}

export declare const BlurContainer: BlurContainerComponent;
