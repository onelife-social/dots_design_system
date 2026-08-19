import * as React from 'react';

/**
 * ImageThumbnail — port web de DotsImageThumbnail (Flutter). Miniatura cuadrada
 * r12 que muestra una imagen (cover) o un icono centrado sobre fondo secundario.
 */
export interface ImageThumbnailProps {
  /** Variante — enum Dart DotsImageThumbnailVariant. Default: 'image' */
  variant?: 'image' | 'icon';
  /** URL de la imagen (variant image) — equivale al `image` (ImageProvider) Dart */
  src?: string;
  /** Texto alternativo de la imagen */
  alt?: string;
  /** Lado en px — Dart `size`. Default: 40 */
  size?: number;
  /** Nombre de DotsIcon (variant icon) — Dart `iconData`. Default: 'ic-user' */
  icon?: string;
  /** Tamaño del icono — Dart `iconSize`. Default: 20 */
  iconSize?: number;
  /** Color CSS del icono — Dart `iconColor`. Default: text-secondary */
  iconColor?: string;
  /** Overlay negro 30 % sobre la imagen — Dart `coverImage`. Default: false */
  coverImage?: boolean;
  /** Error de carga de la imagen — Dart `onError` */
  onError?: React.ReactEventHandler<HTMLImageElement>;
  className?: string;
}

export declare const ImageThumbnail: React.ComponentType<ImageThumbnailProps>;
