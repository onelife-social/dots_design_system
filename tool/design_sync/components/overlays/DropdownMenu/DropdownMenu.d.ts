import * as React from 'react';

/**
 * DropdownMenu — port web de dropdowns/ (Flutter: DropdownList + DropdownMenu +
 * DropdownItem en una sola API). Con `label` renderiza el botón desplegable con su
 * menú debajo; sin `label` renderiza solo el panel del menú.
 */
export interface DropdownMenuItemProps {
  /** Texto principal (bodyDefaultMedium). Dart: DropdownItem.text */
  text: string;
  /** Subtítulo inline en textSecondary. Dart: subtitle */
  subtitle?: string;
  /** Nodo inicial opcional. Dart: leading */
  leading?: React.ReactNode;
  /** Nombre real del icono Dots trailing (16px). Dart: icon (DotsIconData) */
  icon?: string;
  /** Color CSS que tiñe texto e icono. Dart: itemColor */
  itemColor?: string;
  /** Atajo para itemColor = labelDestructive. */
  destructive?: boolean;
  /** El item se encoge a su contenido. Dart: minSize (default false) */
  minSize?: boolean;
  /** Dart: onTap */
  onClick?: () => void;
}

export interface DropdownMenuProps {
  /** Items del menú. Dart: DropdownMenu.items / DropdownList.items */
  items: DropdownMenuItemProps[];
  /** Ancho del panel en px. Dart: DropdownMenu.width (default 250) */
  width?: number;
  /** Alto máximo del panel con scroll. Dart: maxHeight */
  maxHeight?: number;
  /** Texto del botón desplegable. Si se omite, solo se pinta el panel. Dart: DropdownList.label */
  label?: string;
  /** Subtítulo del botón en textTertiary. Dart: subtitle */
  subtitle?: string;
  /** Tamaño del botón — enum Dart DropdownListSize. */
  size?: 'small' | 'medium';
  /** Variante — enum Dart DropdownListVariant (defaultVariant → 'default'). */
  variant?: 'default' | 'onBackground';
  /** Menú abierto (controlado). Dart: isActive */
  isActive?: boolean;
  /** Estado inicial abierto en modo no controlado. */
  defaultActive?: boolean;
  /** El botón se encoge a su contenido. Dart: minSize (default true) */
  minSize?: boolean;
  /** Ancho máximo del menú desplegado. Dart: menuMaxWidth */
  menuMaxWidth?: number;
  /** Alto máximo del menú desplegado. Dart: menuMaxHeight */
  menuMaxHeight?: number;
  /** Notifica el nuevo estado abierto/cerrado tras un tap en el botón. */
  onToggle?: (active: boolean) => void;
  /** Tap en el botón. Dart: DropdownList.onTap */
  onClick?: () => void;
  className?: string;
}

export declare const DropdownMenu: React.ComponentType<DropdownMenuProps> & {
  /** Fila individual del menú (DropdownItem). */
  Item: React.ComponentType<DropdownMenuItemProps>;
};
