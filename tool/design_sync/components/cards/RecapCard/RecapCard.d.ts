import * as React from 'react';

/**
 * RecapCard — port web de RecapCard + RecapCardLocked (Flutter), unificados con la prop `locked`.
 * Sin `locked`: tarjeta 4:5 squircle52 con overlay (variantes active/blocked/generated/onlyTitle).
 * Con `locked`: tarjeta 7:8 con CountdownRecap centrado (variantes countdown/locked/soon).
 */
export interface RecapCardProps {
  /** true → renderiza RecapCardLocked (7:8, countdown); false/omitido → RecapCard (4:5) */
  locked?: boolean;
  /** Variante sin locked — enum Dart RecapCardVariant (onlyTitle = active sin título/badge/botón) */
  variant?: 'active' | 'blocked' | 'generated' | 'onlyTitle';
  /** Variante con locked — enum Dart RecapCardLockedVariant */
  lockedVariant?: 'countdown' | 'locked' | 'soon';
  /** Ancho en px (Dart width; requerido en Dart). Default 220 */
  width?: number;
  /** URL de la foto de fondo (Dart imageProvider). Sin ella se pinta un placeholder degradado */
  imageSrc?: string;
  /** URL de la imagen de texto superpuesta (Dart textImageProvider, solo sin locked) */
  textImageSrc?: string;
  /** Título (sin locked: fila superior con ic-clock--timer · locked: título del countdown) */
  title?: string;
  /** Texto del BadgeLabel premium large (sin locked, no en blocked) */
  badgeText?: string;
  /** Label del DotsMainButton inferior (active/blocked; locked: variante locked) */
  buttonText?: string;
  /** Nombre del álbum (variante generated) */
  albumName?: string;
  /** Autor (variante generated), p.ej. "Creado por Ana" */
  createdBy?: string;
  /** Descripción del countdown cuando no hay cuenta atrás (locked/soon o countdown terminado) */
  description?: string;
  /** Fecha de desbloqueo (ISO/Date) — cuenta atrás en vivo (lockedVariant countdown) */
  countdownDate?: string | number | Date;
  /** Etiquetas de la cuenta atrás */
  daysLabel?: string;
  hoursLabel?: string;
  minutesLabel?: string;
  secondsLabel?: string;
  /** Difumina la imagen de fondo (Dart blurImageProvider, solo locked; blocked la difumina siempre) */
  blurImage?: boolean;
  /** Tap en la tarjeta / botón principal sin locked (Dart onTap) */
  onClick?: () => void;
  /** Tap en el botón info/share/lock (Dart onInfoTap) */
  onInfoClick?: () => void;
  /** Tap en el botón inferior con locked (Dart onButtonTap) */
  onButtonClick?: () => void;
  className?: string;
}

export declare const RecapCard: React.ComponentType<RecapCardProps>;
