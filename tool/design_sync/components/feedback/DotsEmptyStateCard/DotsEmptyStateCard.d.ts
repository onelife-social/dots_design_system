import * as React from 'react';

/**
 * DotsEmptyStateCard — port web de DotsEmptyStateCard (Flutter). Estado vacío
 * centrado: imagen o icono, título editorial, descripción y botón opcional.
 */
export interface DotsEmptyStateCardProps {
  /** Variante — enum Dart DotsEmptyStateCardVariant */
  variant: 'image' | 'icon';
  /** URL de la imagen (variante image). Dart: imageProvider */
  image?: string;
  /** Icono (variante icon): nombre DotsIcon (48px textQuarternary) o nodo React. Dart: icon (DotsIcon) */
  icon?: string | React.ReactNode;
  /** Título, title02H5 (P22 Mackinac 20/500). Dart: title */
  title: string;
  /** Descripción, bodyDefaultRegular textQuarternary. Dart: description */
  description: string;
  /** Color CSS del título. Dart: titleColor */
  titleColor?: string;
  /** Color CSS de la descripción. Dart: descriptionColor */
  descriptionColor?: string;
  /** Botón opcional (normalmente un DotsMainButton). Dart: button */
  button?: React.ReactNode;
  /** Espacio extra (px) tras la imagen. Dart: extraSpaceAfterImage */
  extraSpaceAfterImage?: number;
  /** Ancho (px) de la imagen. Dart: imageWidth */
  imageWidth?: number;
  /** Descripción rica renderizada en lugar de description (que queda como aria-label). Dart: descriptionSpans */
  descriptionSpans?: React.ReactNode;
  className?: string;
}

export declare const DotsEmptyStateCard: React.ComponentType<DotsEmptyStateCardProps>;
