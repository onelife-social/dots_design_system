import * as React from 'react';

/**
 * FeatureItem — port web de FeatureItem (Flutter). Fila etiqueta/valor con
 * leading de icono (16px, textQuarternary) o imagen custom (24×24): feature a
 * la izquierda (textTertiary) y value opcional a la derecha (textSecondary).
 */
export interface FeatureItemProps {
  /** Etiqueta izquierda — Dart `feature` */
  feature: string;
  /** Valor derecho opcional (alineado a la derecha) — Dart `value` */
  value?: string;
  /** Nombre de icono DotsIcon (p.ej. 'ic-calendar') — Dart `icon: DotsIconData`. Ignorado si hay `image` */
  icon?: string;
  /** Leading custom de 24×24 — variante Dart `FeatureItem.image` */
  image?: React.ReactNode;
  /** Clase CSS extra */
  className?: string;
}

export declare const FeatureItem: React.ComponentType<FeatureItemProps>;
