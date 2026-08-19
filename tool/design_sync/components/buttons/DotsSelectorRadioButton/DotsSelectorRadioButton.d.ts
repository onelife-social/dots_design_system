import * as React from 'react';

/**
 * DotsSelectorRadioButton — port web de los selectores de lib/src/components/selectors/.
 * Tarjeta seleccionable (bgContainerSecondary, r24) con radio a la derecha; el
 * bundle también expone DotsSelectorRadioButtonLabel y DotsSettingItemRadioBtn.
 */
export interface DotsSelectorRadioButtonProps {
  /** Seleccionada (borde 1.5 labelHighlight) — Dart `isSelected` */
  isSelected: boolean;
  /** Título — bodyDefaultBold */
  title: string;
  /** Icono de la primera fila de detalle — Dart `icon1` (DotsIconData.clockFilled) */
  icon1?: string;
  /** Tamaño del icono 1 — Dart `icon1Size` */
  icon1Size?: number;
  /** Texto de la primera fila de detalle */
  details1: string;
  /** Icono de la segunda fila — Dart `icon2` (DotsIconData.calendar) */
  icon2?: string;
  /** Tamaño del icono 2 — Dart `icon2Size` */
  icon2Size?: number;
  /** Texto de la segunda fila */
  details2: string;
  /** Pulsación — Dart `onTap` */
  onClick?: () => void;
}

/** Variante de etiqueta — enum Dart SelectorRadioButtonLabelVariant */
export type SelectorRadioButtonLabelVariant = 'free' | 'acquired' | 'premium' | 'premiumPlus';

export interface DotsSelectorRadioButtonLabelProps {
  isSelected: boolean;
  /** Título — title02H6 (P22 Mackinac) */
  title: string;
  /** Texto del BadgeLabel superior — Dart `tagText` */
  tagText: string;
  details1: string;
  details2: string;
  /** Si es false oculta el radio y desactiva la selección — Dart `isSelectable` */
  isSelectable: boolean;
  /** free → badge main · acquired → green · premium → premium · premiumPlus → premiumPlus */
  variant: SelectorRadioButtonLabelVariant;
  onClick?: () => void;
}

export interface DotsSettingItemRadioBtnProps {
  isSelected: boolean;
  /** Etiqueta principal (izquierda) — Dart `leadingLabel` */
  leadingLabel: string;
  /** Etiqueta secundaria (derecha) — Dart `trailingLabel` */
  trailingLabel?: string;
  onClick?: () => void;
}

export declare const DotsSelectorRadioButton: React.ComponentType<DotsSelectorRadioButtonProps>;
export declare const DotsSelectorRadioButtonLabel: React.ComponentType<DotsSelectorRadioButtonLabelProps>;
export declare const DotsSettingItemRadioBtn: React.ComponentType<DotsSettingItemRadioBtnProps>;
