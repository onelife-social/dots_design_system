import * as React from 'react';

/**
 * CreateCard — port web de CreateCard (Flutter). Tarjeta 164×112 r24 para crear recuerdos:
 * variante label (sugerencia con degradado, icono y botón +) o button (crear, centrada).
 */
export interface CreateCardProps {
  /** Título de la tarjeta */
  title: string;
  /** Icono DotsIcon 32 (variante label), p.ej. 'ic-pic' */
  icon?: string;
  /** Color inicial del degradado horizontal (variante label). Sin él cae al degradado verde de marca */
  primaryColor?: string;
  /** Color final del degradado; default = primaryColor */
  secondaryColor?: string;
  /** Ancho en px (Dart width; la altura es fija 112) */
  width?: number;
  /** Variante — enum Dart CreateCardVariant */
  variant?: 'label' | 'button';
  /** Tap en la tarjeta (Dart onTap) */
  onClick?: () => void;
  className?: string;
}

export declare const CreateCard: React.ComponentType<CreateCardProps>;
