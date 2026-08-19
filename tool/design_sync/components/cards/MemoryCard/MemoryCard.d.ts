import * as React from 'react';

/**
 * MemoryCard — port web de MemoryCard (Flutter). Miniatura vertical de recuerdo pendiente
 * del home (68px de ancho) con borde degradado (verde = memory, sweep multicolor = recap)
 * y nombre del grupo debajo.
 */
export interface MemoryCardProps {
  /** URL de la foto (Dart image: Widget). Sin ella se pinta un placeholder degradado */
  imageSrc?: string;
  /** Nombre del grupo bajo la tarjeta */
  groupName: string;
  /** Variante del borde — enum Dart MemoryCardVariant */
  variant?: 'memory' | 'recap';
  /** Tap en la tarjeta (Dart onTap) */
  onClick?: () => void;
  className?: string;
}

export declare const MemoryCard: React.ComponentType<MemoryCardProps>;
