import * as React from 'react';

/**
 * DotsTopBar — port web de DotsTopBar (Flutter). Barra superior de pantalla con
 * status bar (50px), título/subtítulo centrados, botón atrás, iconos laterales
 * y CTA opcional; variantes espejo de los constructores Dart.
 */
export interface DotsTopBarProps {
  /** Constructor Dart equivalente. Si se omite se deduce: children→widget, ctaLabel→cta, title→title, si no onlyStatusBar */
  variant?: 'onlyStatusBar' | 'title' | 'widget' | 'cta';
  /** Título centrado — titleH6 textPrimary */
  title?: string;
  /** Subtítulo bajo el título — labelSmallRegular textSecondary */
  subtitle?: string;
  /** URL de imagen 20×20 redonda junto al título — Dart `imageTitle` (DotsProfilePhoto) */
  imageTitle?: string;
  /** Contenido central custom (variant widget) — Dart `child` */
  children?: React.ReactNode;
  /** Nodo a la izquierda (no combinable con onBack) — Dart `leftIcon` */
  leftIcon?: React.ReactNode;
  /** Nodo a la derecha (normalmente un DotsIconButton) — Dart `rightIcon` */
  rightIcon?: React.ReactNode;
  /** Muestra el botón atrás (chevron-left, DotsIconButton medium) — Dart `onTapBack` */
  onBack?: () => void;
  /** Botón atrás dentro de círculo gris (DotsIconButton solid) */
  showCircleBackButton?: boolean;
  /** Texto del CTA (DotsMainButton main·small) — Dart `ctaLabel` */
  ctaLabel?: string;
  /** Callback del CTA — Dart `onCtaTap` */
  onCtaClick?: () => void;
  /** CTA habilitado (default true) */
  ctaEnabled?: boolean;
  /** Altura grande 106px con hueco de status (default true; onlyStatusBar fuerza 50px) */
  bigStatusBar?: boolean;
  /** Fondo transparente en vez de bgContainerPrimary */
  hideBackground?: boolean;
  /** Color CSS que fuerza el fondo (ignora hideBackground) */
  color?: string;
  /** Borde inferior 1px negro @0.2 */
  showBottomBorder?: boolean;
  className?: string;
}

export declare const DotsTopBar: React.ComponentType<DotsTopBarProps>;
