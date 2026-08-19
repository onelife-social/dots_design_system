import * as React from 'react';

/**
 * DotsFloatingButton — port web de DotsFloatingButton (Flutter). Píldora flotante
 * 36px de alto (r22) con blur, texto bold blanco e icono opcional.
 */
export interface DotsFloatingButtonProps {
  /** Texto del botón (labelDefaultBold 13/600, elipsis en 1 línea) */
  content: string;
  /** Nombre del icono DotsIcon (20px), opcional — p.ej. 'ic-map' */
  icon?: string;
  /** onTap de Dart */
  onClick?: () => void;
  /** Backdrop blur + capa blanca al 50% bajo el fondo (por defecto true) */
  blur?: boolean;
}

export declare const DotsFloatingButton: React.ComponentType<DotsFloatingButtonProps>;
