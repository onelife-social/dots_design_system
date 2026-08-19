import * as React from 'react';

/**
 * DotsAccordion — port web de DotsAccordion (Flutter). Lista de secciones
 * plegables con cabecera (icono opcional + título + chevron animado), divisor
 * entre secciones y despliegue animado del contenido.
 */
export interface DotsAccordionSection {
  /** Título de la cabecera — bodyLargeMedium textPrimary */
  title: string;
  /** Contenido desplegado — Dart `content` (Widget) */
  content?: React.ReactNode;
  /** Nombre del icono (asset ic-…) a la izquierda del título — Dart `leadingIcon` */
  leadingIcon?: string;
  /** Abierta inicialmente */
  expanded?: boolean;
}

export interface DotsAccordionProps {
  /** Secciones del acordeón */
  sections: DotsAccordionSection[];
  /** Solo una sección abierta a la vez */
  singleOpen?: boolean;
  /** Duración de la animación de despliegue en ms — Dart `animationDuration` */
  animationDuration?: number;
  /** Padding horizontal de 16px en cabeceras y contenido */
  addHorizontalPadding?: boolean;
  /** Extensión web: notifica el toggle de una sección */
  onToggle?: (index: number, expanded: boolean) => void;
}

export declare const DotsAccordion: React.ComponentType<DotsAccordionProps>;
