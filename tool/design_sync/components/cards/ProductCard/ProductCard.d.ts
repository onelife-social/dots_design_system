import * as React from 'react';

/**
 * ProductCard — port web de ProductCard (Flutter). Media card cuadrada con la
 * copy sobre el fondo, legible gracias a un blur + degradado inferior. El fondo
 * es un slot (foto, carrusel, degradado); todo lo demás salvo `title` es opcional.
 */
export interface ProductCardProps {
  /** Línea principal, siempre visible */
  title: string;
  /** Imagen de fondo (URL). Sin ella se pinta un degradado placeholder */
  imageSrc?: string;
  /** Segunda línea bajo el título */
  subtitle?: string;
  /** Tercera línea, normalmente el precio ("Desde 29,99 €") */
  caption?: string;
  /** Valor tachado tras `caption`, p. ej. el precio anterior. Se ignora sin `caption` */
  captionPrevious?: string;
  /** Contenido del badge de la esquina superior derecha (p. ej. un BadgeLabel) */
  badge?: React.ReactNode;
  /** Número de puntos del PageControl. `0` lo oculta */
  pageCount?: number;
  /** Índice del punto activo */
  activePage?: number;
  /** Nombre del icono DotsIcon del botón de acción (por defecto `ic-arrow-right`) */
  actionIcon?: string;
  /** Ancho / alto. Por defecto 1 (cuadrada, como el componente de Figma) */
  aspectRatio?: number;
  /** onTap de Dart — toda la card */
  onClick?: () => void;
  /** onActionTap de Dart. Sin él, el botón no se pinta */
  onActionClick?: () => void;
  className?: string;
}

export declare const ProductCard: React.ComponentType<ProductCardProps>;
