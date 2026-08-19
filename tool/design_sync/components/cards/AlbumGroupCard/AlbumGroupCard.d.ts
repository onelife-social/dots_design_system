import * as React from 'react';

/**
 * AlbumGroupCard — port web de AlbumGroupCard (Flutter). Tarjeta cuadrada de álbum
 * con foto de fondo, difuminado inferior y título centrado abajo.
 */
export interface AlbumGroupCardProps {
  /** URL de la foto de fondo (Dart imageProvider). Sin ella se pinta un placeholder degradado */
  imageSrc?: string;
  /** Título centrado abajo (requerido en Dart) */
  title: string;
  /** Variante — enum Dart AlbumGroupCardVariant */
  variant?: 'small' | 'large';
  /** Icono del CardTag superior izquierdo (Dart tagIconData), p.ej. 'ic-prime-1' */
  tagIcon?: string;
  /** Grupo bloqueado: candado centrado y sin tag */
  isBlocked?: boolean;
  /** Altura del difuminado inferior (Dart edgeSize; default 60 small / 110 large) */
  edgeSize?: number;
  /** Sigma del blur (Dart blurSigma) — aproximado en CSS, sin efecto directo */
  blurSigma?: number;
  /** Lado en px (la tarjeta es 1:1; Dart la acota a 135–160 small / 288–340 large). Default 148 / 288 */
  size?: number;
  /** Tap en la tarjeta (Dart onTap) */
  onClick?: () => void;
  className?: string;
}

export declare const AlbumGroupCard: React.ComponentType<AlbumGroupCardProps>;
