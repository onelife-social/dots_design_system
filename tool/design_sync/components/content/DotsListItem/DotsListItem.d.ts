import * as React from 'react';

/**
 * DotsListItem — port web de DotsListsItem (Flutter). Fila de lista con miniatura
 * (imagen 40×40, avatar circular o icono), label con ellipsis y trailing opcional
 * (radio, check) o variante divider con título de sección.
 */
export interface DotsListItemProps {
  /** Variante — enum Dart DotsListsItemVariant */
  variant?: 'main' | 'selector' | 'icon' | 'check' | 'radioButton' | 'divider';
  /** Texto de la fila (o de la sección en variant divider) */
  label?: string;
  /** URL/data URI de la imagen — Dart `image` (ImageProvider) */
  imageSrc?: string;
  /** Forma de la miniatura con imagen — enum Dart DotsListsItemPicType */
  picType?: 'album' | 'user';
  /** Nombre del icono (asset ic-…) si variant es icon o no hay imagen — Dart `iconData` */
  iconName?: string;
  /** Callback al pulsar la fila — Dart `onTap` */
  onClick?: () => void;
  /** Callback si la imagen de picType user falla al cargar — Dart `onError` */
  onError?: (event: unknown) => void;
}

export declare const DotsListItem: React.ComponentType<DotsListItemProps>;
