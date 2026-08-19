import * as React from 'react';

/** Opción activa — enum Dart SegmentedControlOption */
export type DotsSegmentedControlOption = 'left' | 'right';

/**
 * DotsSegmentedControl — port web de SegmentedControl / SegmentedControlIcon /
 * SegmentedControlSingle (Flutter). Pill segmentada de 2 opciones (texto o icono)
 * o de opción única.
 */
export interface DotsSegmentedControlProps {
  /** Widget Dart equivalente: 'text' → SegmentedControl, 'icon' → SegmentedControlIcon, 'single' → SegmentedControlSingle */
  type?: 'text' | 'icon' | 'single';
  /** Solo type 'text' — enum Dart SegmentedControlVariant */
  variant?: 'main' | 'camera';
  /** type 'text': etiqueta izquierda — Dart `leftOptionName` */
  leftOptionName?: string;
  /** type 'text': etiqueta derecha — Dart `rightOptionName` */
  rightOptionName?: string;
  /** type 'text': badge sobre la opción derecha — Dart `rightOptionTag` */
  rightOptionTag?: string;
  /** type 'icon': nombre de icono DotsIcon ('ic-…') — Dart `leftOptionIcon` */
  leftOptionIcon?: string;
  /** type 'icon': nombre de icono DotsIcon ('ic-…') — Dart `rightOptionIcon` */
  rightOptionIcon?: string;
  /** type 'single': etiqueta del botón — Dart `buttonName` */
  buttonName?: string;
  /** type 'single': badge — Dart `buttonTag` */
  buttonTag?: string;
  /** Opción activa (modo controlado) — Dart `selectedOption` */
  selectedOption?: DotsSegmentedControlOption;
  /** Opción inicial (modo no controlado) */
  defaultSelectedOption?: DotsSegmentedControlOption;
  /** Callback con la opción pulsada — Dart `onTapOption` */
  onTapOption?: (option: DotsSegmentedControlOption) => void;
  /** type 'text'/'single': color CSS del segmento seleccionado — Dart `selectedColor` */
  selectedColor?: string;
  /** type 'text'/'single': color CSS de fondo — Dart `backgroundColor` */
  backgroundColor?: string;
}

export declare const DotsSegmentedControl: React.ComponentType<DotsSegmentedControlProps>;
