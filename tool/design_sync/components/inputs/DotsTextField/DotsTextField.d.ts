import * as React from 'react';

/**
 * DotsTextField — port web de DotsTextField (Flutter). Campo de texto píldora de 44px
 * con icono opcional, botón de borrado al enfocar, estado de error y modo sin fondo.
 */
export interface DotsTextFieldProps {
  /** Valor controlado (React). Si se define, el componente es controlado. */
  value?: string;
  /** Valor inicial en modo no controlado (espejo de TextEditingController inicial). */
  defaultValue?: string;
  /** Nombre real del icono Dots (p.ej. 'ic-search'). Dart: iconData */
  icon?: string;
  /** Nodo opcional al inicio (p.ej. selector de país). Dart: leading */
  leading?: React.ReactNode;
  /** Placeholder. Dart: hintText */
  hintText?: string;
  /** Pinta el hint en labelDestructive cuando isError y sin foco. Dart: addHintTextColorError */
  addHintTextColorError?: boolean;
  /** Cambio de texto. Dart: onChanged */
  onChanged?: (text: string) => void;
  /** Enter/submit. Dart: onSubmitted */
  onSubmitted?: (text: string) => void;
  /** Pérdida de foco. Dart: onFocusLost */
  onFocusLost?: (text: string) => void;
  /** Longitud máxima. Dart: maxTextLength */
  maxTextLength?: number;
  /** Estado de error. Dart: isError (default false) */
  isError?: boolean;
  /** Texto de error bajo el campo (solo con background). Dart: errorText */
  errorText?: string;
  /** Habilitado. Dart: enabled (default true) */
  enabled?: boolean;
  /** Fondo píldora bgContainerSecondaryOnBackground. Dart: background (default true) */
  background?: boolean;
  /** Subrayado inferior cuando background es false. Dart: showUnderline (default false) */
  showUnderline?: boolean;
  /** Texto centrado. Dart: alignCenter (default false) */
  alignCenter?: boolean;
  /** Tipo de teclado. Dart: keyboardType (TextInputType) */
  keyboardType?: 'text' | 'number' | 'phone' | 'emailAddress' | 'url';
  /** Capitalización automática. Dart: textCapitalization (default 'none') */
  textCapitalization?: 'none' | 'words' | 'sentences' | 'characters';
  /** Enfocar al montar (sustituto web de FocusNode.requestFocus inicial). */
  autoFocus?: boolean;
}

export declare const DotsTextField: React.ComponentType<DotsTextFieldProps>;
