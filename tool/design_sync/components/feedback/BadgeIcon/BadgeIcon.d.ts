import * as React from 'react';

/**
 * BadgeIcon — port web de BadgeIcon (Flutter). Círculo blanco con icono centrado
 * y sombra suave, en 3 tamaños. Con `icons` renderiza el grupo apilado
 * (BadgeIconGroup, lienzo 63×70, 1-3 iconos).
 */
export interface BadgeIconProps {
  /** Nombre real del icono Dots (p.ej. 'ic-heart'). Dart: icon (DotsIconData). Requerido en modo single. */
  icon?: string;
  /** Tamaño — enum Dart BadgeIconSize (large 44/24 · medium 36/20 · small 28/16) */
  size?: 'large' | 'medium' | 'small';
  /** Estilo visual — enum Dart BadgeIconStyle (solo 'white') */
  style?: 'white';
  /** Color CSS opcional para el icono. Dart: iconColor */
  iconColor?: string;
  /** Dart: onTap */
  onClick?: () => void;
  /**
   * Modo grupo (Dart BadgeIconGroup): 1-3 nombres de icono apilados en 63×70.
   * icons[0] medium abajo-izda; icons[1]/icons[2] small. Ignora `icon`/`size`.
   */
  icons?: string[];
  /** Modo grupo: color por icono (null = default del estilo). Dart: iconColors */
  iconColors?: Array<string | null>;
}

export declare const BadgeIcon: React.ComponentType<BadgeIconProps>;
