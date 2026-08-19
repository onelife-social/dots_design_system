import * as React from 'react';

/**
 * EventGroupCard — port web de EventGroupCard (Flutter). Tarjeta cuadrada de grupo/evento
 * con foto de fondo, título y, en las variantes grandes, texto secundario y menú de acciones con blur.
 */
export interface EventGroupCardAction {
  /** Nombre de icono DotsIcon, p.ej. 'ic-camera' */
  icon: string;
  /** Texto bajo el icono */
  text: string;
  onClick?: () => void;
}

export interface EventGroupCardProps {
  /** Variante — enum Dart EventGroupCardVariant */
  variant?: 'small' | 'active' | 'passed';
  /** URL de la foto de fondo (Dart imageProvider). Sin ella se pinta un placeholder degradado */
  imageSrc?: string;
  /** Título (small: abajo · active/passed: arriba) */
  title?: string;
  /** Texto secundario (active: "· N participantes" · passed: label del botón) */
  secondaryText?: string;
  /** Icono del CardTag superior izquierdo (Dart tagIconData), p.ej. 'ic-prime-1' */
  tagIcon?: string;
  /** Acciones del menú inferior con blur (solo active/passed) — Dart GroupEventCardModel */
  actions?: EventGroupCardAction[];
  /** Grupo bloqueado: candado centrado y sin tag */
  isBlocked?: boolean;
  /** Altura del difuminado inferior (Dart edgeSize; default 60 small / 110 resto) */
  edgeSize?: number;
  /** Lado en px (la tarjeta es 1:1; Dart la acota a 135–160 small / 288–340 resto). Default 148 / 288 */
  size?: number;
  /** Tap en la tarjeta (Dart onTap) */
  onClick?: () => void;
  /** Tap en el texto/botón secundario (Dart onSecondaryTap) */
  onSecondaryClick?: () => void;
  className?: string;
}

export declare const EventGroupCard: React.ComponentType<EventGroupCardProps>;
