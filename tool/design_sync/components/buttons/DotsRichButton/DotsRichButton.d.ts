import * as React from 'react';

/**
 * DotsRichButton — port web de DotsRichButton (Flutter). Botón ancho con blur:
 * leading (icono o imagen), contenido central (título + detalles) y trailing
 * (texto o chevron `ic-chevron-right`).
 */
export interface DotsRichButtonProps {
  /** Tamaño — enum Dart DotsRichButtonSize (large 358×75 r100 · medium 358×60 r32 · small 248×60 r32) */
  size: 'large' | 'medium' | 'small';
  /** Tamaño del texto central — enum Dart DotsRichButtonTextSize */
  textSize: 'large' | 'medium';
  /** Nombre de icono DotsIcon leading (ej. `'ic-pics'`) — Dart `icon` */
  icon?: string;
  /** Color CSS del icono leading — Dart `iconColor` (default textSecondary) */
  iconColor?: string;
  /** URL de imagen leading 32×32 (prioridad sobre `icon`) — Dart `image` */
  image?: string;
  /** Texto principal — Dart `content` */
  content: string;
  /** Texto secundario bajo el principal — Dart `details` */
  details?: string;
  /** Texto trailing; si falta se muestra un chevron. Además activa el punto rojo — Dart `trailingText` */
  trailingText?: string;
  /** Pulsación — Dart `onTap` */
  onClick?: () => void;
}

export declare const DotsRichButton: React.ComponentType<DotsRichButtonProps>;
