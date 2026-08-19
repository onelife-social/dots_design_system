import * as React from 'react';

/**
 * DotsIconButton — port web de DotsIconButton (Flutter). Botón circular de icono
 * con estilos defaultStyle/onPhoto/floating/noBackground, 4 estados, 6 tamaños,
 * label opcional (column/row) y badge de notificación.
 */
export interface DotsIconButtonProps {
  /** Nombre del icono DotsIcon (asset real, p.ej. 'ic-heart') */
  icon: string;
  /** Tamaño del icono en px — por defecto el del size */
  iconSize?: number;
  /** Label opcional bajo/junto al botón */
  label?: string;
  /** Texto del badge de notificación (BadgeTag) */
  tag?: string;
  /** Enum Dart DotsIconButtonSize (diámetro 56/52/44/36/28/22) */
  size?: 'enormous' | 'extraLarge' | 'large' | 'medium' | 'small' | 'extraSmall';
  /** @deprecated usa style + state — enum Dart DotsIconButtonVariant */
  variant?: 'solid' | 'photo' | 'active' | 'noBackground' | 'photoDisable';
  /** Enum Dart DotsIconButtonStyle */
  style?: 'defaultStyle' | 'onPhoto' | 'floating' | 'noBackground';
  /** Enum Dart DotsIconButtonState */
  state?: 'defaultState' | 'active' | 'disabled' | 'destructive';
  /** Enum Dart DotsIconButtonDirection — colocación del label */
  direction?: 'column' | 'row';
  /** onTap de Dart */
  onClick?: () => void;
  /** Color CSS que fuerza icono y label */
  color?: string;
  /** Color CSS que fuerza el fondo del círculo */
  backgroundColor?: string;
  /** Si true, el label también dispara onClick */
  textTappable?: boolean;
  /** Aplica backdrop blur (por defecto true) */
  shouldApplyBlur?: boolean;
  /** Sombra shadowFolder alrededor del círculo */
  showShadow?: boolean;
  /** 'ellipsis' → 1 línea con elipsis; sin definir → 2 líneas */
  overflow?: 'ellipsis';
}

export declare const DotsIconButton: React.ComponentType<DotsIconButtonProps>;
