import * as React from 'react';

/**
 * DotsFilterChip — port web de DotsFilterChip (Flutter). Chip de filtro activo con
 * etiqueta y botón de cierre (todo el chip es clicable).
 */
export interface DotsFilterChipProps {
  /** Etiqueta del filtro. Dart: label */
  label?: string;
  /** Callback al pulsar el chip (o su cruz). Dart: onTap */
  onClick?: () => void;
}

export declare const DotsFilterChip: React.ComponentType<DotsFilterChipProps>;
