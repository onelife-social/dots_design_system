import * as React from 'react';

/**
 * ActivityPreview — port web de ActivityPreview (Flutter). Tarjeta 3:4 (r24,
 * sombra, borde) con imagen de fondo y píldora inferior con blur: emojis de
 * reacciones o icono (ojo/corazón) + número ya formateado.
 */
export interface ActivityPreviewProps {
  /** Enum Dart ActivityPreviewVariant */
  variant?: 'reactions' | 'views' | 'favs';
  /** URL de la imagen de fondo (image de Dart). Sin src → placeholder degradado */
  src?: string;
  /** Emojis de reacciones (solo variant reactions) */
  reactions?: string[];
  /** Número YA formateado ('123', '1.2K'…) — como en Dart */
  number?: string;
  /** onCardTap de Dart */
  onCardClick?: () => void;
  /** onError de Dart (error de carga de la imagen) */
  onError?: (event: unknown) => void;
  className?: string;
}

/**
 * ActivityPreview.OverviewItem — port web de ActivityOverviewItem (Flutter).
 * Pila de fotos 53×68 (segunda foto rotada -5°) con badge de variante en la
 * esquina, contador, título y fila "+N" con avatares solapados.
 */
export interface ActivityOverviewItemProps {
  /** URLs de las fotos; la primera delante, la última detrás rotada (images de Dart) */
  images?: string[];
  /** Nombre del icono DotsIcon del badge (icon: Widget en Dart) */
  icon: string;
  /** Color CSS del icono del badge (por defecto labelAlwaysWhite) */
  iconColor?: string;
  /** Variante — colorea el badge: reactions→friends001, views→hobby002, favs→couple001 */
  variant: 'reactions' | 'views' | 'favs';
  /** Contador bajo la pila (se formatea con k/M/B) */
  count: number;
  /** Título bajo el contador */
  title: string;
  /** Total de reacciones; > 0 muestra la fila "+N" */
  reactionsCount: number;
  /** URLs de avatares de usuarios (solapados 10px, círculos de 17) */
  userImages: string[];
  /** Ancho de la foto (por defecto 53) */
  width?: number;
  /** Alto de la foto (por defecto 68) */
  height?: number;
  /** Radio de la foto (por defecto 12) */
  borderRadius?: number;
  /** Grosor del borde blanco interior (por defecto 1) */
  borderWidth?: number;
  /** Máximo de avatares mostrados (por defecto 2) */
  maxUserImages?: number;
  /** Error de carga de cualquier foto */
  onError?: (event: unknown) => void;
  className?: string;
}

export declare const ActivityPreview: React.ComponentType<ActivityPreviewProps> & {
  OverviewItem: React.ComponentType<ActivityOverviewItemProps>;
};
