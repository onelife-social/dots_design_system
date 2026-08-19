import * as React from 'react';

/**
 * DotsRadioButton — port web de DotsRadioButton (Flutter). Círculo de 24 px con
 * borde de 2 px; seleccionado muestra el icono `ic-selector` en labelHighlight.
 */
export interface DotsRadioButtonProps {
  /** Estado seleccionado (modo controlado) — Dart `isSelected` */
  isSelected?: boolean;
  /** Estado inicial (modo no controlado) */
  defaultSelected?: boolean;
  /** Se invoca con `true` al pulsar (un radio no se des-selecciona a sí mismo) */
  onChanged?: (isSelected: boolean) => void;
  /** Diámetro en px — Dart `size` */
  size?: number;
  /** Deshabilitado (extensión web; el widget Dart no lo expone) */
  disabled?: boolean;
}

export declare const DotsRadioButton: React.ComponentType<DotsRadioButtonProps>;
