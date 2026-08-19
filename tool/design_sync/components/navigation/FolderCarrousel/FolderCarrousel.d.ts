import * as React from 'react';

/**
 * Item de FolderCarrousel — espejo de BtnFolderData (Dart).
 */
export interface FolderCarrouselItem {
  /** Nombre real del icono del DS (p.ej. 'ic-family') — Dart `icon` */
  icon: string;
  /** Texto de la carpeta (BtnFolder lo trunca a 20 caracteres) */
  text?: string;
  /** onTap del item — Dart `onTap`. Si falta, se usa el `onSelect(i)` del carrusel */
  onClick?: () => void;
  /** Long-press del item — Dart `onPressed` */
  onLongPress?: () => void;
  /** Carpeta seleccionada (bgStrong + sombra + icono en iconSelectedColor) */
  isSelected?: boolean;
  /** Color CSS del icono al seleccionar — requerido en Dart; default '#3E9ACB' (home) */
  iconSelectedColor?: string;
  /** Solo icono 44×44 (p.ej. botón '+') — prop de BtnFolder */
  isNonExpandable?: boolean;
  /** La carpeta es editable (muestra badge lápiz si showEditIcon) */
  isEditable?: boolean;
}

/**
 * FolderCarrousel — port web de FolderCarrousel (Flutter). Fila horizontal
 * scrolleable de BtnFolder (pad lateral 16, sin barra de scroll).
 */
export interface FolderCarrouselProps {
  /** Carpetas a renderizar como BtnFolder — Dart `buttonsData` */
  items: FolderCarrouselItem[];
  /** Muestra el badge de edición en los items editables — Dart `showEditIcon` (default false) */
  showEditIcon?: boolean;
  /** Conveniencia: click en el item i (cuando el item no trae su propio onClick) */
  onSelect?: (index: number) => void;
  /** Nodos extra al final de la fila — Dart `customWidgets` (DefaultFolderWidget) */
  children?: React.ReactNode;
  className?: string;
}

export declare const FolderCarrousel: React.ComponentType<FolderCarrouselProps>;
