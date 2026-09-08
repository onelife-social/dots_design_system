import * as React from 'react';

/**
 * DotsUploadItem — port web de DotsUploadItem (Flutter). Fila de estado de subida
 * con foto squircle 64, texto de estado y botón/progreso según la variante.
 */
export interface DotsUploadItemProps {
  /** URL de la imagen. Sin `src` (o si falla) → placeholder degradado. */
  src?: string;
  alt?: string;
  /** Variante — enum Dart UploadItemVariant. */
  variant: 'processing' | 'success' | 'error';
  /** (processing) Progreso 0..1 para la barra y el porcentaje. */
  percentage?: number;
  /** Fecha mostrada arriba (bodyDefaultMedium). */
  textDate?: string;
  /** Texto de estado junto al icono (labelDefaultRegular). */
  processText?: string;
  /** Máximo de líneas de `processText`: 1 (por defecto) una línea con ellipsis,
   *  n>1 recorta a n líneas, `null` deja que el texto haga wrap libre. */
  processTextMaxLines?: number | null;
  /** (success) Tiempo transcurrido bajo el estado. */
  timeElapsed?: string;
  /** (success/error) Texto del botón derecho (DotsMainButton medium). */
  btnText?: string;
  /** (success/error) Callback del botón derecho (Dart btnOnTap). */
  onBtnClick?: () => void;
  /** Callback si la imagen falla al cargar. */
  onError?: (event: unknown) => void;
  className?: string;
}

export declare const DotsUploadItem: React.ComponentType<DotsUploadItemProps>;
