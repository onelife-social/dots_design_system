import * as React from 'react';

/**
 * DotsSelector — port web de DotsSelector (Flutter). Selector circular para
 * superponer a fotos: off = círculo blanco 70%, on = píldora labelHighlight
 * con check (`ic-check`) o número.
 */
export interface DotsSelectorProps {
  /** Variante visual — enum Dart DotsSelectorVariant */
  variant?: 'check' | 'num';
  /** Tamaño — enum Dart DotsSelectorSize (small 22 / medium 24) */
  size?: 'small' | 'medium';
  /** Estado seleccionado (modo controlado) — Dart `isSelected` */
  isSelected?: boolean;
  /** Estado inicial (modo no controlado; click alterna) */
  defaultSelected?: boolean;
  /** Se invoca con el nuevo estado al pulsar (extensión web) */
  onChanged?: (isSelected: boolean) => void;
  /** (Solo variant num) Número mostrado cuando está seleccionado — Dart `number` */
  number?: number;
}

export declare const DotsSelector: React.ComponentType<DotsSelectorProps>;
