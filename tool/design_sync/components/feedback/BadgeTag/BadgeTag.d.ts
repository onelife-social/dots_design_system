import * as React from 'react';

/**
 * BadgeTag — port web de BadgeTag (Flutter). Contador rojo (labelDestructive)
 * min 18×18; standalone o flotando sobre un child en la esquina superior derecha.
 */
export interface BadgeTagProps {
  /** Texto del tag. Cadena vacía → píldora vacía 18×18. Dart: tag */
  tag: string;
  /**
   * Offset desde la esquina sup. dcha. cuando hay child (right = width, top = height).
   * Default -5/-5. Dart: size (Size)
   */
  size?: { width?: number; height?: number };
  /** Contenido principal sobre el que flota el tag. Dart: child */
  children?: React.ReactNode;
}

export declare const BadgeTag: React.ComponentType<BadgeTagProps>;
