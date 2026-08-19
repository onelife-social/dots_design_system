import * as React from 'react';

/**
 * DotsHomeTopBar — port web de DotsHomeTopBar + DotsHomeTopBarMainSection
 * (Flutter). Barra superior del home: avatar a la izquierda, título pequeño
 * centrado (labelDefaultBold textTertiary) y dos iconos a la derecha
 * (en el home reales: ic-heart e ic-chat como DotsIconButton noBackground).
 */
export interface DotsHomeTopBarProps {
  /** Constructor Dart equivalente. Si se omite se deduce: title→title, child→widget, si no onlyStatusBar */
  variant?: 'onlyStatusBar' | 'title' | 'widget';
  /** Título centrado — labelDefaultBold 13/600 textTertiary */
  title?: string;
  /** Tap sobre el título — Dart DotsHomeTopBarMainSection.onTitleTap */
  onTitleClick?: () => void;
  /** Contenido central custom (variant widget) — Dart `child` */
  child?: React.ReactNode;
  /** Avatar a la izquierda (en el home DotsProfilePhoto 32) — Dart `imgProfile` */
  imgProfile?: React.ReactNode;
  /** Primer icono derecho (en el home DotsIconButton ic-heart, large, noBackground, tag) */
  rightIcon?: React.ReactNode;
  /** Segundo icono derecho (en el home DotsIconButton ic-chat) — lleva el margen final de 16px */
  secondRightIcon?: React.ReactNode;
  /** Fondo blur 50 + bgContainerPrimary — Dart `backgroundBlur` */
  backgroundBlur?: boolean;
  /** Fondo con degradado a transparente (ShaderMask + blur 18) — Dart `showGradient` */
  showGradient?: boolean;
  /** Widgets extra bajo el contenido — Dart `children` */
  children?: React.ReactNode;
  className?: string;
}

export declare const DotsHomeTopBar: React.ComponentType<DotsHomeTopBarProps>;
