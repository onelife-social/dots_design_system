import * as React from 'react';

/**
 * ImageWithProgressAround — port web de ImageWithProgressAround (Flutter).
 * Imagen redondeada con overlay de porcentaje y anillo de progreso con
 * gradiente recap dibujado alrededor del borde (empieza arriba, sentido horario).
 */
export interface ImageWithProgressAroundProps {
  /** Progreso 0..1 — Dart `progress`. Valores > 1 se interpretan como porcentaje (72 → 0.72). */
  progress: number;
  /** Ancho en px — Dart `width`. Default: 150. La altura sale del aspect ratio. */
  width?: number;
  /** URL de la imagen central (equivale al `imageProvider` Dart). Sin ella, placeholder de diseño. */
  src?: string;
  /** Texto alternativo de la imagen */
  alt?: string;
  /** `standard` = 9:16 (kStandardAspectRatio) · `small` = 3:4 (kSmallAspectRatio, isSmallScreen). Default: 'standard' */
  aspectRatio?: 'standard' | 'small';
  /** Grosor del anillo — Dart `progressBarWidth`. Default: 6 */
  progressBarWidth?: number;
  /** Separación imagen↔anillo — Dart `innerPadding`. Default: 8 */
  innerPadding?: number;
  /** Radio de la imagen interior — Dart `borderRadius`. Default: 45 */
  borderRadius?: number;
  /** Colores CSS del gradiente del anillo — Dart `progressBarColors`. Default: DotsColors.recapGradientColors */
  progressBarColors?: string[];
  className?: string;
}

export declare const ImageWithProgressAround: React.ComponentType<ImageWithProgressAroundProps>;
