import * as React from 'react';

/**
 * NotificationBanner — port web de NotificationBanner (Flutter). Banner informativo
 * centrado (r24, bgContainerSecondaryOnBackground) con título, cuerpo opcional,
 * botón de acción opcional (DotsMainButton main·medium) y botón de cierre.
 */
export interface NotificationBannerProps {
  /** Título — typo.main.bodyLargeBold, textPrimary */
  title: string;
  /** Cuerpo bajo el título — bodyDefaultRegular, textSecondary */
  body?: string;
  /** Texto del botón de acción; sin él no hay botón */
  actionButtonText?: string;
  /** onActionTap de Dart */
  onActionClick?: () => void;
  /** onClose de Dart (DotsCloseButton softContrast·medium, top 12 right 12) */
  onClose?: () => void;
  /** Mostrar botón de cierre (por defecto true) */
  showCloseButton?: boolean;
  className?: string;
}

export declare const NotificationBanner: React.ComponentType<NotificationBannerProps>;
