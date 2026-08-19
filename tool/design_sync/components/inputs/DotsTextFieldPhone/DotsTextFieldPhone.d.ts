import * as React from 'react';

/** Código de país para el input de teléfono. Dart: PhoneCountryCode */
export interface PhoneCountryCode {
  /** Prefijo internacional, p.ej. '+34'. Dart: dialCode */
  dialCode: string;
  /** Emoji de bandera, p.ej. '🇪🇸'. Dart: flagEmoji */
  flagEmoji: string;
}

/**
 * DotsTextFieldPhone — port web de DotsTextFieldPhone (Flutter). DotsTextField con
 * selector de país al inicio (bandera + prefijo + chevron + divisor) y teclado tel.
 */
export interface DotsTextFieldPhoneProps {
  /** Valor controlado (React). Si se define, el componente es controlado. */
  value?: string;
  /** Valor inicial en modo no controlado. */
  defaultValue?: string;
  /** País seleccionado (bandera + prefijo). Dart: countryCode (requerido) */
  countryCode: PhoneCountryCode;
  /** Pulsación en el selector de país (abrir picker). Dart: onCountryTap (requerido) */
  onCountryTap: () => void;
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
  /** Fondo píldora. Dart: background (default true) */
  background?: boolean;
  /** Subrayado inferior cuando background es false. Dart: showUnderline (default false) */
  showUnderline?: boolean;
  /** Enfocar al montar. */
  autoFocus?: boolean;
}

export declare const DotsTextFieldPhone: React.ComponentType<DotsTextFieldPhoneProps>;
