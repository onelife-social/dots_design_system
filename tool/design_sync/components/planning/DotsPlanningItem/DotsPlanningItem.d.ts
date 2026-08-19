import * as React from 'react';

/**
 * DotsPlanningItem — port web de DotsPlanningItem (Flutter). Fila de sección de
 * planning: imagen squircle 52, título con chevron, fila principal siempre
 * visible y subfilas que se muestran al expandir (tap en toda la fila).
 */

/** Espejo de la clase Dart DotsPlanningInfoItem */
export interface DotsPlanningInfoItem {
  /** Nombre real del icono (assets/icons) — Dart DotsIconData */
  icon?: string;
  /** Texto de la fila. Filas sin icono o sin texto no se pintan */
  text?: string;
  /** Subrayado (solo la fila de ubicación) — Dart `underline`. Default: false */
  underline?: boolean;
}

export interface DotsPlanningItemProps {
  /** URL de la imagen de la sección — Dart `sectionImage`. Default: default_section_planning.webp (data URI) */
  sectionImage?: string;
  /** Título de la sección (bodyLargeMedium) — Dart `mainText` */
  mainText: string;
  /** Icono colapsado — Dart `mainIcon`. Default: 'ic-chevron-down' */
  mainIcon?: string;
  /** Icono expandido — Dart `mainIconActive`. Default: 'ic-chevron-up' */
  mainIconActive?: string;
  /** Fila principal siempre visible — Dart `mainItem` */
  mainItem?: DotsPlanningInfoItem;
  /** Filas visibles solo al expandir — Dart `subItems`. Default: [] */
  subItems?: DotsPlanningInfoItem[];
  /** Estado inicial (no controlado). El tap alterna. Default: false */
  defaultExpanded?: boolean;
  /** Estado controlado: si se pasa, el componente no gestiona el toggle interno */
  expanded?: boolean;
  /** Aviso de toggle con el próximo estado (útil en modo controlado) */
  onToggle?: (expanded: boolean) => void;
  className?: string;
}

export declare const DotsPlanningItem: React.ComponentType<DotsPlanningItemProps>;
