import * as React from 'react';

/**
 * DotsInputStepper — port web de DotsInputStepper (Flutter). Píldora 116 × 41
 * con botones − / + (`ic-rest` / `ic-add`) y el valor centrado; los botones se
 * deshabilitan al llegar a minValue / maxValue.
 */
export interface DotsInputStepperProps {
  /** Valor actual (modo controlado) — Dart `value` */
  value?: number;
  /** Valor inicial (modo no controlado) */
  defaultValue?: number;
  /** Mínimo permitido — Dart `minValue` (requerido en Dart) */
  minValue?: number;
  /** Máximo permitido — Dart `maxValue` (requerido en Dart) */
  maxValue?: number;
  /** Callback del botón + — Dart `onIncrement` */
  onIncrement?: () => void;
  /** Callback del botón − — Dart `onDecrement` */
  onDecrement?: () => void;
  /** Se invoca con el nuevo valor tras cada pulsación (extensión web) */
  onChanged?: (value: number) => void;
}

export declare const DotsInputStepper: React.ComponentType<DotsInputStepperProps>;
