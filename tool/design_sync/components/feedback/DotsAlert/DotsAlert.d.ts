import * as React from 'react';

/**
 * DotsAlert — port web de DotsAlert (Flutter). Diálogo modal de 320px con icono
 * destacado, título/mensaje y acciones según variante (botones, input o selector).
 */
export interface DotsAlertSelectorItem {
  /** Texto del ítem. Dart: DotsListItemModel.label */
  label: string;
  /** URL de la miniatura 40×40 (placeholder si se omite). Dart: DotsListItemModel.image */
  image?: string;
  /** Tap en el ítem. Dart: DotsListItemModel.onTap */
  onClick?: () => void;
}

export interface DotsAlertProps {
  /** Variante — enum Dart DotsAlertVariant (las factories DotsAlert.oneButton… se expresan aquí) */
  variant?:
    | 'noButtons'
    | 'oneButton'
    | 'twoHorizontalButtons'
    | 'twoHorizontalButtonsDestructive'
    | 'twoVerticalButtons'
    | 'twoVerticalButtonsNoActive'
    | 'twoVerticalButtonsDestructive'
    | 'input'
    | 'selector';
  /** Nombre de icono DotsIcon del chip destacado. Dart: iconData */
  icon: string;
  /** URL de imagen 48×48 que sustituye al chip (fallback al chip si falla). Dart: iconImage */
  iconImage?: string;
  /** Título, bodyLargeBold (16/700). Dart: title */
  title?: string;
  /** Mensaje, bodyDefaultRegular (14/400). Dart: message */
  message?: string;
  /** Cierre (botón X y tap fuera con showScrim). Dart: onClose */
  onClose?: () => void;
  /** Con showScrim: tap fuera ejecuta onClose. Dart: enableCloseOnTapOutside */
  enableCloseOnTapOutside?: boolean;
  /** (input) Cambios del campo de texto. Dart: onInputChanged */
  onInputChanged?: (value: string) => void;
  /** (input) Placeholder del campo. Dart: inputHint */
  inputHint?: string;
  /** (selector) Ítems de la lista. Dart: selectorItemList */
  selectorItems?: DotsAlertSelectorItem[];
  /** Texto del botón principal. Dart: mainButtonText */
  mainButtonText?: string;
  /** Tap del botón principal. Dart: mainButtonOnTap */
  onMainButtonClick?: () => void;
  /** Texto del botón secundario. Dart: secondaryButtonText */
  secondaryButtonText?: string;
  /** Tap del botón secundario. Dart: secondaryButtonOnTap */
  onSecondaryButtonClick?: () => void;
  /** Muestra la X (DotsCloseButton medium softContrast). Dart: showCloseButton */
  showCloseButton?: boolean;
  /** Blur 50 tras la tarjeta (por defecto true). Dart: showBlurBackground */
  showBlurBackground?: boolean;
  /** Envuelve la tarjeta en un scrim fixed negro 50% centrado (en Dart siempre existe; aquí opt-in) */
  showScrim?: boolean;
  className?: string;
}

export declare const DotsAlert: React.ComponentType<DotsAlertProps>;
