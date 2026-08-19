import * as React from 'react';

/**
 * DotsTooltip — port web de DotsTooltip (Flutter). Globo de ayuda con cola
 * triangular en 10 posiciones, icono opcional 32px y botón de cierre.
 */
export type DotsToolTipTailPosition =
  | 'topAlignLeadingEdge'
  | 'topAlignLeading'
  | 'topAlignCenter'
  | 'topAlignTrailing'
  | 'topAlignTrailingEdge'
  | 'bottomAlignLeadingEdge'
  | 'bottomAlignLeading'
  | 'bottomAlignCenter'
  | 'bottomAlignTrailing'
  | 'bottomAlignTrailingEdge';

export interface DotsTooltipProps {
  /** Texto del tooltip (labelDefaultMedium). Dart: text */
  text: string;
  /** Posición de la cola — enum Dart DotsToolTipTailPosition. Obligatorio. */
  tailPosition: DotsToolTipTailPosition;
  /** Nombre real del icono Dots (32px, labelHighlight). Dart: icon (DotsIconData) */
  icon?: string;
  /** Nodo de icono personalizado; tiene prioridad sobre `icon`. Dart: iconWidget */
  iconNode?: React.ReactNode;
  /** Muestra DotsCloseButton small softContrast. Dart: showCloseButton (default true) */
  showCloseButton?: boolean;
  /** Ancho máximo en px. Dart: maxWidth (default 288) */
  maxWidth?: number;
  /** Tap en el cuerpo. Dart: onTap */
  onClick?: () => void;
  /** Tap en el botón de cierre. Dart: onClose */
  onClose?: () => void;
  className?: string;
}

export declare const DotsTooltip: React.ComponentType<DotsTooltipProps>;
