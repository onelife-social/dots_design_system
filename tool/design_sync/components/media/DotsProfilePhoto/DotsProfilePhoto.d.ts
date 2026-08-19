import * as React from 'react';

/**
 * DotsProfilePhoto — port web de DotsProfilePhoto / DotsProfilePhotoBited (Flutter).
 * Foto de perfil circular; con `bited` muestra la mordida inferior-derecha con reaction.
 */
export interface DotsProfilePhotoProps {
  /** URL de la imagen. Sin `src` (o si falla la carga) se pinta un placeholder degradado. */
  src?: string;
  /** Texto alternativo; también sirve de semilla del placeholder degradado. */
  alt?: string;
  /** Ancho en px. Default 32 (44 con `bited`). */
  width?: number;
  /** Alto en px. Default 32 (44 con `bited`). */
  height?: number;
  /** Variante DotsProfilePhotoBited: mordida abajo-derecha. */
  bited?: boolean;
  /** (Solo `bited`) Emoji/texto de la reacción centrado en la mordida. */
  reaction?: string;
  /** (Solo `bited`) Tamaño de la mordida como fracción del diámetro. Default 0.25. */
  biteSize?: number;
  /** (Solo `bited`) Offset de la mordida (fracciones del diámetro). Default { x: 0.85, y: 0.85 }. */
  biteOffset?: { x: number; y: number };
  /** Callback al pulsar (Dart onTap). */
  onClick?: () => void;
  /** Callback si la imagen falla al cargar (Dart onError). */
  onError?: (event: unknown) => void;
  className?: string;
}

export declare const DotsProfilePhoto: React.ComponentType<DotsProfilePhotoProps>;
