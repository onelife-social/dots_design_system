import * as React from 'react';

/**
 * NotificationBannerImage — port web de NotificationBannerImage (Flutter).
 * Banner r24 con imagen superior, título (titleH6), descripción opcional con
 * apéndice destacado, botón de acción (main/secondary) y botón de cierre.
 * El banner del home (HomeRecapsBanner) es este componente.
 */
export interface NotificationBannerImageProps {
  /** URL de la imagen (imageProvider de Dart). Sin src se muestra un placeholder degradado */
  src?: string;
  /** Lado en px de la imagen (cuadrada). Sin él, la imagen ocupa el ancho */
  imageSize?: number;
  /** Padding horizontal alrededor de la imagen (por defecto 20) */
  imagePadding?: number;
  /** Título — typo.main.titleH6, textPrimary */
  title: string;
  /** Descripción — bodyDefaultRegular, textTertiary */
  description?: string;
  /** Apéndice de la descripción en labelHighlight (se antepone un espacio) */
  appendedDescription?: string;
  /** Texto del botón de acción; sin él no hay botón */
  actionButtonText?: string;
  /** Tamaño del DotsMainButton — enum Dart DotsMainButtonSize */
  actionButtonSize?: 'mainAction' | 'large' | 'medium' | 'small';
  /** true → variant main; false → variant secondary (por defecto true) */
  isBtnActive?: boolean;
  /** onActionTap de Dart — también hace clicable todo el banner */
  onActionClick?: () => void;
  /** onClose de Dart */
  onClose?: () => void;
  /** Mostrar botón de cierre (por defecto true) */
  showCloseButton?: boolean;
  /** Error de carga de la imagen (Dart: errorBuilder → se oculta la imagen) */
  onError?: (event: unknown) => void;
  className?: string;
}

export declare const NotificationBannerImage: React.ComponentType<NotificationBannerImageProps>;
