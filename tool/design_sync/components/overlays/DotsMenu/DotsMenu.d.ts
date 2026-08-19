import * as React from 'react';

/**
 * DotsMenu — port web de menu/ (Flutter: DotsMenu + DotsMenuItemModel +
 * SettingsList/SettingsItem). Menú contextual de 250px con navegación anidada por
 * subItems; `DotsMenu.SettingsList` es la lista de ajustes con filas icon/toggle.
 */
export interface DotsMenuItemModel {
  /** Identificador único. Dart: id */
  id: string | number;
  /** Texto principal (bodyDefaultMedium). Dart: label */
  label: string;
  /** Segunda línea en textTertiary. Dart: details */
  details?: string;
  /** Nombre real del icono Dots trailing (16px, labelPrimary). Dart: icon */
  icon?: string;
  /** Muestra check 14px labelHighlight a la izquierda. Dart: selected */
  selected?: boolean;
  /** Tiñe label e iconos de labelDestructive. Dart: isDelete */
  isDelete?: boolean;
  /** Subitems — al tocar se navega a este nivel. Dart: subItems */
  subItems?: DotsMenuItemModel[];
  /** Divider de 0.5px tras el item. Dart: addDivider */
  addDivider?: boolean;
  /** Dart: onTap */
  onClick?: () => void;
}

export interface DotsMenuProps {
  /** Item cabecera del menú. Dart: mainItem */
  mainItem: DotsMenuItemModel;
  /** Subitems del primer nivel. Dart: subitems */
  subitems: DotsMenuItemModel[];
  /** Abre el menú directamente en el nivel que contiene este id. Dart: defaultSelectedItemId */
  defaultSelectedItemId?: string | number;
  className?: string;
}

export interface DotsMenuSettingsItemProps {
  /** Fila con icono trailing o con toggle — enum Dart SettingsItemVariant. */
  variant: 'icon' | 'toggle';
  /** Texto (bodyDefaultMedium). Dart: label */
  label: string;
  /** Icono inicial 20px textTertiary. Dart: startIcon */
  startIcon?: string;
  /** Icono final 16px textTertiary (solo variant 'icon'). Dart: endIcon */
  endIcon?: string;
  /** Estado del toggle (solo variant 'toggle'). Dart: toggleValue */
  toggleValue?: boolean;
  /** Tap en el toggle. Dart: onToggleTap */
  onToggleTap?: () => void;
  /** Tap en la fila. Dart: onTap */
  onClick?: () => void;
  /** Color CSS del label. Dart: textColor */
  textColor?: string;
  /** Alineación del label. Dart: textAlignment (default 'left') */
  textAlignment?: 'left' | 'center' | 'right';
}

export interface DotsMenuSettingsListProps {
  /** Título en mayúsculas sobre la lista. Dart: title */
  title?: string;
  /** Descripción bajo la lista. Dart: description */
  description?: string;
  /** Filas de ajustes. Dart: items */
  items: DotsMenuSettingsItemProps[];
  /** Padding horizontal de título/descripción. Dart: textPadding (default 15) */
  textPadding?: number;
  className?: string;
}

export declare const DotsMenu: React.ComponentType<DotsMenuProps> & {
  SettingsList: React.ComponentType<DotsMenuSettingsListProps>;
  SettingsItem: React.ComponentType<DotsMenuSettingsItemProps>;
};
