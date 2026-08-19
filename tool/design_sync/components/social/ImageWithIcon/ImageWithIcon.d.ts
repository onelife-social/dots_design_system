import * as React from 'react';

/**
 * ImageWithIcon — port web de ImageWithIcon (Flutter). Miniatura 53×68 (o
 * circular) con gradiente superior, borde blanco interior y badge circular
 * con icono en la esquina superior derecha. Sin imagen puede mostrar una
 * inicial (aliasLabelImageText).
 */
export interface ImageWithIconProps {
  /** URL de la imagen (image de Dart). Si falla la carga → defaultImage (default_user_item) */
  src?: string;
  /** Nombre del icono DotsIcon del badge (icon: Widget en Dart) */
  icon?: string;
  /** Color CSS del icono (por defecto el del tema/currentColor) */
  iconColor?: string;
  /** Tamaño del icono (por defecto 18; badge = iconSize × 1.5) */
  iconSize?: number;
  /** Offset custom del badge; por defecto sobresale la mitad */
  iconOffset?: number;
  /** Ancho (por defecto 53) */
  width?: number;
  /** Alto (por defecto 68) */
  height?: number;
  /** Radio (por defecto 12; con circularImage → width/2) */
  borderRadius?: number;
  /** Grosor del borde blanco interior (por defecto 2) */
  borderWidth?: number;
  /** Imagen/alias circular en vez de rectángulo redondeado */
  circularImage?: boolean;
  /** Mostrar el badge (por defecto true) */
  showIcon?: boolean;
  /** Inicial mostrada cuando no hay src — Nunito 600 40, textTertiary */
  aliasLabelImageText?: string;
  /** Estilo CSS inline para el texto alias (aliasLabelImageTextStyle de Dart) */
  aliasLabelImageTextStyle?: React.CSSProperties;
  /** Error de carga de la imagen */
  onError?: (event: unknown) => void;
  className?: string;
}

export declare const ImageWithIcon: React.ComponentType<ImageWithIconProps>;
