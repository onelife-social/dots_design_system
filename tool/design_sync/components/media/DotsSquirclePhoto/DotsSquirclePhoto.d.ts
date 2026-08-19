import * as React from 'react';

/**
 * DotsSquirclePhoto — port web de DotsSquircleImage (Flutter, dots_squircle_photo.dart).
 * Imagen squircle con sombra default, borde opcional y overlay de error de subida.
 */
export interface DotsSquirclePhotoProps {
  /** URL de la imagen. Sin `src` (o si falla) se pinta un placeholder degradado. */
  src?: string;
  /** Texto alternativo; semilla del placeholder degradado. */
  alt?: string;
  /** Lado en px (cuadrada). Default 52. */
  size?: number;
  /** Radio (número → px). Default 16 (DotsBorderRadius.r16). */
  borderRadius?: number | string;
  /** Ocultar el borde. Default true. */
  hideBorder?: boolean;
  /** Grosor del borde en px. Default 1. */
  borderSize?: number;
  /** Color CSS del borde. Default `var(--bg-btn-image)` (bgBtnImage al 60%). */
  borderColor?: string;
  /** Overlay de error de subida (negro 20% + icono blanco centrado). Default false. */
  uploadError?: boolean;
  /** Icono del overlay de error. Default 'ic-cloud-fail' (DotsIconData.cloudFail). */
  uploadErrorIcon?: string;
  onClick?: () => void;
  /** Callback si la imagen falla al cargar (Dart onError). */
  onError?: (event: unknown) => void;
  className?: string;
}

/**
 * DotsSquirclePhoto.Tag — port web de DotsSquircleImageTag (dots_squircle_photo_tag.dart).
 * Squircle con borde blanco + círculo tag labelHighlight con icono abajo-derecha.
 */
export interface DotsSquirclePhotoTagProps {
  src?: string;
  alt?: string;
  /** Lado de la imagen en px (lienzo = size + 10). Default 100. */
  size?: number;
  /** Radio. Default 24 (DotsBorderRadius.r24). */
  borderRadius?: number | string;
  /** Color del borde. Default `var(--label-always-white)`. */
  borderColor?: string;
  /** Grosor del borde. Default 2. */
  borderSize?: number;
  /** Icono del tag. Default 'ic-calendar--check' (DotsIconData.calendarCheck). */
  icon?: string;
  /** Tamaño del icono. Default 24. */
  iconSize?: number;
  /** Color del icono. Default `var(--label-always-white)`. */
  iconColor?: string;
  /** Diámetro del círculo tag. Default 40. */
  tagCircleSize?: number;
  onClick?: () => void;
  onError?: (event: unknown) => void;
  className?: string;
}

export declare const DotsSquirclePhoto: React.ComponentType<DotsSquirclePhotoProps> & {
  Tag: React.ComponentType<DotsSquirclePhotoTagProps>;
};
