import * as React from 'react';

/**
 * DotsToast — port web de DotsToast/DotsToastInfo/DotsToastAction (Flutter).
 * Toast flotante con icono por variante: fila de 358px (info) o columna
 * de 160px (action, `isAction: true`).
 */
export interface DotsToastProps {
  /** Texto del toast. Dart: title */
  title: string;
  /** Variante — enum Dart DotsToastVariant */
  variant: 'success' | 'error' | 'info' | 'progress' | 'connectionResumed' | 'connectionLost' | 'widget';
  /** true → DotsToastAction (columna 160); false/omitido → DotsToastInfo (fila 358). Dart: isAction */
  isAction?: boolean;
  /** Nombre de icono DotsIcon que sustituye al de la variante. Dart: customIconData */
  customIcon?: string;
  /** Color CSS para el icono (sustituye al de la variante). Dart: customIconColor */
  customIconColor?: string;
  /** Texto del botón ghost — solo variante progress con isAction: false. Dart: btnTitle */
  btnTitle?: string;
  /** Nodo mostrado en lugar del icono — solo variante widget con isAction: true. Dart: customWidget */
  customWidget?: React.ReactNode;
  /** Tap en el toast (y en el botón ghost). Dart: onTap */
  onClick?: () => void;
  className?: string;
}

export declare const DotsToast: React.ComponentType<DotsToastProps>;
