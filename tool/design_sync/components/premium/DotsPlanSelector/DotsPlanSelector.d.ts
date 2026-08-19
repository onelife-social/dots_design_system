import * as React from 'react';

/**
 * DotsPlanSelector — port web de DotsPlanSelector (Flutter). Tarjeta selectora de
 * plan (Básico / Premium / Premium+) que al seleccionarse muestra el fondo webp
 * de marca del plan (bg_basic / bg_premium / bg_premium_plus).
 */
export interface DotsPlanSelectorProps {
  /** Título del plan (bodyDefaultBold) */
  title: string;
  /** Descripción opcional bajo el título (labelSmallRegular) */
  description?: string;
  /** Variante visual — enum Dart DotsPlanSelectorVariant */
  variant: 'basic' | 'premium' | 'premiumPlus';
  /** Si está seleccionado (con enabled, pinta el fondo webp del plan) */
  selected: boolean;
  /** Dart `enabled`. Default: true. Deshabilitado: texto textQuarternary y sin fondo */
  enabled?: boolean;
  /** Dart `onTap` */
  onClick?: () => void;
  className?: string;
}

export declare const DotsPlanSelector: React.ComponentType<DotsPlanSelectorProps>;
