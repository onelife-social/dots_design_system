import * as React from 'react';

/**
 * DotsBottomEdgeBlur — desenfoque progresivo en el borde inferior del contenido:
 * una banda de alto `edgeSize` que va de nítido (arriba) a desenfocado (abajo),
 * para que el contenido se funda con el pie en vez de cortarse en seco.
 */
export interface DotsBottomEdgeBlurProps {
  /** Contenido sobre el que se pinta la banda (Dart: `child`) */
  children?: React.ReactNode;
  /** Alto de la banda desenfocada. Con 0 el componente no pinta nada encima */
  edgeSize: number;
  /** Fuerza del desenfoque en la parte baja de la banda. Con 0, passthrough */
  sigma?: number;
  className?: string;
}

export declare const DotsBottomEdgeBlur: React.ComponentType<DotsBottomEdgeBlurProps>;
