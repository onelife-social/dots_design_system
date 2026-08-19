import * as React from 'react';

/**
 * Item de DotsNavBar — espejo de DotsNavBarItem (Dart).
 */
export interface DotsNavBarItem {
  /** Nombre real del icono del DS (assets/icons) — Dart `iconData`. Ej: 'ic-home' */
  icon: string;
  /** Etiqueta bajo el icono */
  label: string;
  /** Badge numérico sobre el icono — Dart `pendingNumber` (se muestra máx. 99) */
  badge?: number;
}

/**
 * DotsNavBar — port web de DotsNavBar (Flutter). Barra de navegación flotante
 * de 3 items con blur, píldora animada bajo el ítem activo y badge opcional.
 */
export interface DotsNavBarProps {
  /** Los 3 items. Default: Crear (ic-add) / Inicio (ic-home) / Galería (ic-gallery) */
  items?: DotsNavBarItem[];
  /** Índice del ítem activo (0..2). Default: 0 */
  selectedIndex?: number;
  /** Callback al pulsar un ítem — Dart `DotsNavBarItem.onTap` */
  onSelect?: (index: number) => void;
  className?: string;
}

export declare const DotsNavBar: React.ComponentType<DotsNavBarProps>;
