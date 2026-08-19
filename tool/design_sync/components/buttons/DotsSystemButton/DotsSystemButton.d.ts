import * as React from 'react';

/**
 * DotsSystemButton — port web de DotsSystemButton (Flutter). Botón de sistema
 * translúcido (fondo bgContainerSecondaryOnBackground + blur, radio 16) con
 * variantes active / disabled / destructive e icono opcional.
 */

/** Enum Dart DotsSystemButtonVariant */
export type DotsSystemButtonVariant = 'active' | 'disabled' | 'destructive';

/** Enum Dart DotsSystemButtonSize (único valor: medium, altura 44) */
export type DotsSystemButtonSize = 'medium';

export interface DotsSystemButtonProps {
  /** Texto del botón — Dart `content` */
  label: string;
  /** Nombre de icono DotsIcon (p.ej. 'ic-add') — Dart `icon: DotsIconData` */
  icon?: string;
  /** Tamaño — enum Dart DotsSystemButtonSize (default y único: 'medium') */
  size?: DotsSystemButtonSize;
  /**
   * Variante — enum Dart DotsSystemButtonVariant (default 'active').
   * Ojo: 'disabled' es solo visual, el botón sigue emitiendo onClick (igual que en Dart).
   */
  variant?: DotsSystemButtonVariant;
  /** Callback de tap — Dart `onTap` */
  onClick?: (e?: unknown) => void;
  /** Ocupa todo el ancho (equivale al Row mainAxisSize.max de Flutter llenando al padre) */
  expand?: boolean;
  /** Clase CSS extra */
  className?: string;
}

export declare const DotsSystemButton: React.ComponentType<DotsSystemButtonProps>;
