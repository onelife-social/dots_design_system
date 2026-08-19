import * as React from 'react';

/**
 * ColorSelector — port web unificado de DotsColorOptionsRow y DotsColorSelectorRow
 * (Flutter, lib/src/components/color_options/). Fila horizontal scrolleable de
 * círculos de color seleccionables: variante 'options' (paleta DotsColorOption
 * con check) y variante 'selector' (colores libres con anillo highlight).
 */

/** Enum Dart DotsColorOption (los hex viven en dots_colors.dart) */
export type DotsColorOption =
  | 'textQuarternary'
  | 'couple005' | 'couple007'
  | 'friends001' | 'friends002' | 'friends005' | 'friends008' | 'friends010'
  | 'class005' | 'class009'
  | 'wedding002'
  | 'family001' | 'family004' | 'family006'
  | 'child001' | 'child002' | 'child006'
  | 'birthday003' | 'birthday007'
  | 'celebration002'
  | 'hobby001' | 'hobby002' | 'hobby004' | 'hobby005' | 'hobby009'
  | 'work005';

export interface ColorSelectorProps {
  /** 'options' = DotsColorOptionsRow (check al seleccionar) · 'selector' = DotsColorSelectorRow (anillo highlight). Default 'options' */
  variant?: 'options' | 'selector';
  /**
   * Colores a mostrar. En 'options': nombres DotsColorOption (default: la paleta
   * de 15 de Dart `colorOptions`). En 'selector': colores CSS (requerido).
   */
  colors?: Array<DotsColorOption | string>;
  /** Color seleccionado (mismo valor que en `colors`) */
  selected?: DotsColorOption | string;
  /** Callback al pulsar un color — Dart `onColorSelected` */
  onColorSelected?: (color: string) => void;
  /** Diámetro de cada círculo en px (default 32) */
  size?: number;
  /** Separación entre círculos en px (default: 18 en 'options', 12 en 'selector') */
  spacing?: number;
  /** Clase CSS extra */
  className?: string;
}

export declare const ColorSelector: React.ComponentType<ColorSelectorProps> & {
  /** Mapa DotsColorOption → color CSS (dots_colors.dart) */
  OPTION_COLORS: Record<DotsColorOption, string>;
  /** Paleta por defecto de la variante 'options' (Dart DotsColorOptionsRow.colorOptions) */
  DEFAULT_OPTIONS: DotsColorOption[];
};
