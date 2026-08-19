import * as React from 'react';

/**
 * DotsCaptureButton — port web de DotsCaptureButton (Flutter). Botón de captura
 * de cámara Ø80: photo = disco blanco, video = disco rojo; grabando muestra un
 * arco de progreso blanco y el icono de stop.
 */
export interface DotsCaptureButtonProps {
  /** Tipo de captura — enum Dart DotsCaptureButtonType */
  type: 'photo' | 'video';
  /**
   * Estado — enum Dart DotsCaptureButtonState. Si se pasa, el componente es
   * controlado; si se omite, gestiona la grabación internamente al hacer click.
   */
  state?: 'active' | 'recording';
  /** Segundos máximos de grabación (progreso del arco; solo video) — Dart `maxTimeRecording` */
  maxTimeRecording?: number;
  /** Disparo de foto (solo photo) — Dart `onTakePicture` */
  onTakePicture?: () => void;
  /** Comienzo de grabación (solo video) — Dart `onStartRecording` */
  onStartRecording?: () => void;
  /** Fin de grabación (click o tiempo máximo) — Dart `onStopRecording` */
  onStopRecording?: () => void;
}

export declare const DotsCaptureButton: React.ComponentType<DotsCaptureButtonProps>;
