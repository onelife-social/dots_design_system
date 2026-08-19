import * as React from 'react';

/**
 * DotsMainButton — port web de DotsMainButton (Flutter). Botón principal en
 * forma de píldora con 15 variantes (main, secondary, premium…), 4 tamaños,
 * icono opcional, texto de detalle y estado de carga.
 */

/** Enum Dart DotsMainButtonVariant */
export type DotsMainButtonVariant =
  | 'main'
  | 'secondary'
  | 'secondaryPremium'
  | 'secondaryPremiumPlus'
  | 'secondaryLight'
  | 'secondaryDark'
  | 'destructive'
  | 'disabled'
  | 'disabledOpaque'
  | 'ghost'
  | 'premiumPlus'
  | 'premium'
  | 'surface'
  | 'surfacePremium'
  | 'surfacePremiumPlus';

/** Enum Dart DotsMainButtonSize (alturas 52/44/36/28) */
export type DotsMainButtonSize = 'mainAction' | 'large' | 'medium' | 'small';

export interface DotsMainButtonProps {
  /** Texto del botón — Dart `content` */
  label: string;
  /** Nombre de icono DotsIcon (p.ej. 'ic-check') — Dart `icon: DotsIconData` */
  icon?: string;
  /** Texto secundario; solo visible en tamaños mainAction y large — Dart `details` */
  details?: string;
  /** Tamaño del icono en px (default 20) */
  iconSize?: number;
  /** Tamaño — enum Dart DotsMainButtonSize (default 'large') */
  size?: DotsMainButtonSize;
  /** Variante visual — enum Dart DotsMainButtonVariant (default 'main') */
  variant?: DotsMainButtonVariant;
  /** Si es false se pinta `disabledVariant` y no responde a clicks (default true) */
  enabled?: boolean;
  /** Callback de tap — Dart `onTap` */
  onClick?: (e?: unknown) => void;
  /** Ocupa todo el ancho disponible (default true) */
  expand?: boolean;
  /** Padding horizontal compacto de 7px (default false) */
  adaptPaddingForText?: boolean;
  /** Color CSS que sobreescribe el color de texto del tema */
  textColor?: string;
  /** Color CSS que sobreescribe el color del icono */
  iconColor?: string;
  /** Color CSS que sobreescribe el fondo (anula también el degradado) */
  backgroundColor?: string;
  /** Estilo inline extra para el texto — Dart `textStyle` */
  textStyle?: React.CSSProperties;
  /** Aplica blur (y sombra en las variantes que la llevan) (default false) */
  shouldApplyBlur?: boolean;
  /** Posición del icono (default 'left') — enum Dart DotsMainButtonIconPosition */
  iconPosition?: 'left' | 'right';
  /** Muestra spinner y bloquea el click (default false) */
  isLoading?: boolean;
  /** Variante usada cuando enabled=false (default 'disabled') */
  disabledVariant?: DotsMainButtonVariant;
  /** Throttle del onClick (default false) — Dart `useThrottle` */
  useThrottle?: boolean;
  /** Ventana del throttle en ms (default 400) — Dart `throttleDuration` */
  throttleDuration?: number;
  /** Clase CSS extra */
  className?: string;
}

export declare const DotsMainButton: React.ComponentType<DotsMainButtonProps>;
