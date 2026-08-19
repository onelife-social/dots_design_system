import * as React from 'react';

/**
 * BtnFolder — port web de BtnFolder (Flutter). Píldora de carpeta del home
 * (h44, r1000) con icono + label, estado seleccionado con sombra, modo
 * no-expandible (solo icono) y badge de edición opcional.
 */
export interface BtnFolderProps {
  /** Nombre del icono DotsIcon (asset real, p.ej. 'ic-family') */
  icon: string;
  /** Texto de la carpeta (se trunca a 20 caracteres con '…') */
  text?: string;
  /** onTap de Dart */
  onClick?: () => void;
  /** onLongPress de Dart (long-press ~500ms; también el badge de edición) */
  onLongPress?: () => void;
  /** Carpeta seleccionada: fondo bgStrong + sombra + icono iconSelectedColor */
  isSelected?: boolean;
  /** Solo icono 44×44 (p.ej. botón '+') */
  isNonExpandable?: boolean;
  /** Color CSS del icono cuando isSelected — en el home '#3E9ACB' */
  iconSelectedColor: string;
  /** Muestra el badge de edición (requiere isEditable) */
  showEditIcon?: boolean;
  /** La carpeta es editable */
  isEditable?: boolean;
}

export declare const BtnFolder: React.ComponentType<BtnFolderProps>;
