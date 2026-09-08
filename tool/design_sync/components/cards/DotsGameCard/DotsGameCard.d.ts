import * as React from 'react';

/**
 * DotsGameCard — card de un juego comprado, una por acceso (Figma 11574:5112).
 * Comparte ancho (340) y esquina (squircle52) con AlbumGroupCard large para que
 * ambas lean como la misma familia en el feed; el alto lo marca el contenido.
 */
export interface DotsGameCardProps {
  /** Estado de aprovisionamiento — enum Dart DotsGameCardStatus */
  status: 'processing' | 'error' | 'active';
  /** Artwork del juego; se dibuja en una caja de 138×100 sin recortar (BoxFit.contain) */
  imageSrc?: string;
  /** Alternativa a imageSrc: nodo propio — espejo del slot `image` (Widget) de Dart */
  image?: React.ReactNode;
  imageAlt?: string;
  /** Copy del badge: PREPARANDO / NO DISPONIBLE / ACTIVO. La variante la elige `status` */
  badgeText: string;
  title: string;
  description: string;
  /** Texto del botón, o la etiqueta de progreso cuando `status` es 'processing' */
  actionText: string;
  /** Dart `onActionTap`. Se IGNORA con status 'processing': esa variante informa, no se pulsa */
  onActionClick?: () => void;
  /** Indicador para 'processing'. Sin él se pinta un anillo de 16px como placeholder de diseño */
  progressIndicator?: React.ReactNode;
  className?: string;
}

export declare const DotsGameCard: React.ComponentType<DotsGameCardProps>;
