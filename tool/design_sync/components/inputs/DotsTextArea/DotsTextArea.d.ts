import * as React from 'react';

/**
 * DotsTextArea — port web de DotsTextArea (Flutter). Área de texto multilínea con
 * radio 24, label con icono opcional, contador de caracteres restantes y estado de error.
 */
export interface DotsTextAreaProps {
  /** Valor controlado (React). Si se define, el componente es controlado. */
  value?: string;
  /** Valor inicial en modo no controlado (espejo de TextEditingController inicial). */
  defaultValue?: string;
  /** Label sobre el texto. Dart: label */
  label?: string;
  /** Nombre real del icono Dots (p.ej. 'ic-pencil'). Dart: iconData */
  icon?: string;
  /** Placeholder. Dart: hintText */
  hintText?: string;
  /** Cambio de texto. Dart: onChanged */
  onChanged?: (text: string) => void;
  /** Submit (Ctrl/Cmd+Enter en web; Enter inserta salto de línea). Dart: onSubmitted */
  onSubmitted?: (text: string) => void;
  /** Longitud máxima; muestra contador de caracteres restantes. Dart: maxTextLength */
  maxTextLength?: number;
  /** Capitalización automática. Dart: textCapitalization (default 'none') */
  textCapitalization?: 'none' | 'words' | 'sentences' | 'characters';
  /** Alto mínimo en px. Dart: minHeight (default: maxHeight ?? 50) */
  minHeight?: number;
  /** Alto máximo en px; el contenido hace scroll. Dart: maxHeight */
  maxHeight?: number;
  /** Estado de error. Dart: isError (default false) */
  isError?: boolean;
  /** Texto de error bajo el área. Dart: errorText */
  errorText?: string;
  /** Enfocar al montar (sustituto web de FocusNode.requestFocus inicial). */
  autoFocus?: boolean;
}

export declare const DotsTextArea: React.ComponentType<DotsTextAreaProps>;
