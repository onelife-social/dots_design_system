import * as React from 'react';

/**
 * DotsTextFieldDate — port web de DotsTextFieldDate (Flutter). Pastilla de 44px que
 * muestra fecha (y hora) como chips a la derecha; todo el campo es un botón (abre un picker).
 */
export interface DotsTextFieldDateProps {
  /** Nombre real del icono Dots (p.ej. 'ic-calendar'). Dart: iconData */
  icon?: string;
  /** Texto a la izquierda. Dart: label */
  label?: string;
  /** Fecha mostrada como chip. Dart: date (requerido) */
  date: string;
  /** Hora mostrada como segundo chip. Dart: time */
  time?: string;
  /** Pulsación en el campo (abrir date picker). Dart: onTap (requerido) */
  onClick: () => void;
  /** Estado de error: pinta el texto de los chips en labelDestructive. Dart: isError (default false) */
  isError?: boolean;
  /** Texto de error bajo el campo (solo con background). Dart: errorText */
  errorText?: string;
  /** Fondo píldora bgContainerSecondaryOnBackground. Dart: background (default true) */
  background?: boolean;
}

export declare const DotsTextFieldDate: React.ComponentType<DotsTextFieldDateProps>;
