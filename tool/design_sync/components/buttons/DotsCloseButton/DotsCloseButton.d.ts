import * as React from 'react';

/**
 * DotsCloseButton — port web de DotsCloseButton (Flutter). Botón circular de
 * cierre (cruz por defecto) con 4 variantes de contraste y 4 tamaños.
 */
export interface DotsCloseButtonProps {
  /** Nombre del icono DotsIcon — por defecto 'ic-cross' (DotsIconData.cross) */
  icon?: string;
  /** Enum Dart DotsCloseButtonSize (diámetro 44/30/24/16, icono 20/16/16/10) */
  size?: 'large' | 'medium' | 'small' | 'extraSmall';
  /** Enum Dart DotsCloseButtonVariant */
  variant?: 'softContrast' | 'highContrast' | 'onBackground' | 'inverted';
  /** onTap de Dart */
  onClick?: () => void;
  /** Color CSS que fuerza el color del icono */
  color?: string;
  /** Backdrop blur de fondo (por defecto true) */
  addBlur?: boolean;
}

export declare const DotsCloseButton: React.ComponentType<DotsCloseButtonProps>;
