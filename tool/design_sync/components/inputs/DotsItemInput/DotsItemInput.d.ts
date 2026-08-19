import * as React from 'react';

/**
 * DotsItemInput — port web de DotsItemInput (Flutter). Fila de formulario de 42px
 * (icono + label + caja de valor de 120px) apilable en grupo con radios por posición.
 */
export interface DotsItemInputProps {
  /** Texto de la fila. Dart: label */
  label?: string;
  /** Valor mostrado en la caja derecha (120×r7). Dart: value */
  value?: string;
  /** Nombre real del icono Dots. Dart: icon (default DotsIconData.calendar → 'ic-calendar') */
  icon?: string;
  /** Posición en el grupo — enum Dart DotsItemInputPosition (default onlyOne) */
  position?: 'onlyOne' | 'first' | 'middle' | 'last';
  /** Pulsación en la fila. Dart: onTap */
  onClick?: () => void;
}

export declare const DotsItemInput: React.ComponentType<DotsItemInputProps>;
