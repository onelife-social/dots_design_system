import * as React from 'react';

/**
 * DotsTextFieldButton — port web de DotsTextFieldButton (Flutter). Campo píldora de 44px
 * con botón de borrado (DotsCloseButton) al enfocar, suffixIcon opcional, botón de texto
 * al final con divisor, y estado de error con asterisco.
 */
export interface DotsTextFieldButtonProps {
  /** Valor controlado (React). Si se define, el componente es controlado. */
  value?: string;
  /** Valor inicial en modo no controlado (espejo de TextEditingController inicial). */
  defaultValue?: string;
  /** Nombre real del icono Dots inicial (p.ej. 'ic-send'). Dart: iconData */
  icon?: string;
  /** Icono del botón de borrado. Dart: iconDataButton (default cross) */
  iconButton?: string;
  /** Pulsación del botón de borrado; por defecto limpia el campo. Dart: onTapBtn */
  onButtonClick?: () => void;
  /** Variante del DotsCloseButton. Dart: buttonVariant (default 'inverted') */
  buttonVariant?: 'softContrast' | 'highContrast' | 'onBackground' | 'inverted';
  /** Tamaño del DotsCloseButton. Dart: buttonSize (default 'extraSmall') */
  buttonSize?: 'large' | 'medium' | 'small' | 'extraSmall';
  /** Placeholder. Dart: hintText (default '') */
  hintText?: string;
  /** Longitud máxima. Dart: maxTextLength */
  maxTextLength?: number;
  /** Capitalización automática. Dart: textCapitalization (default 'none') */
  textCapitalization?: 'none' | 'words' | 'sentences' | 'characters';
  /** Cambio de texto. Dart: onChanged */
  onChanged?: (text: string) => void;
  /** Enter/submit. Dart: onSubmitted */
  onSubmitted?: (text: string) => void;
  /** Estado de error. Dart: isError (default false) */
  isError?: boolean;
  /** Texto de error bajo el campo. Dart: errorText */
  errorText?: string;
  /** Texto centrado. Dart: alignCenter (default false) */
  alignCenter?: boolean;
  /** Fondo píldora bgContainerSecondaryOnBackground. Dart: background (default true) */
  background?: boolean;
  /** Texto del botón al final (con divisor previo). Dart: endButtonText */
  endButtonText?: string;
  /** Color CSS del botón final. Dart: endButtonTextColor (default labelHighlight) */
  endButtonTextColor?: string;
  /** Pulsación del botón final. Dart: onEndButtonTap */
  onEndButtonClick?: () => void;
  /** Icono sufijo de 16px (sustituye al botón de borrado). Dart: suffixIcon */
  suffixIcon?: string;
  /** Color CSS del icono sufijo. Dart: suffixIconColor (default labelHighlight) */
  suffixIconColor?: string;
  /** Habilitado. Dart: enabled (default true) */
  enabled?: boolean;
  /** Pinta el texto del input en destructive cuando isError. Dart: applyErrorColor (default true) */
  applyErrorColor?: boolean;
  /** Antepone '* ' al errorText. Dart: applyErrorAsterisk (default true) */
  applyErrorAsterisk?: boolean;
  /** Enfocar al montar. */
  autoFocus?: boolean;
}

export declare const DotsTextFieldButton: React.ComponentType<DotsTextFieldButtonProps>;
