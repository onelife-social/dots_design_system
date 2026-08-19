import * as React from 'react';

/**
 * DotsActionSheet — port web de action_sheet/ (Flutter). Hoja modal inferior con
 * variantes standard | list | input | radioButtons | settings | search | spotlight.
 * Se renderiza como hoja estática montable (position relative, sin scrim): colócala
 * donde quieras y dale ancho con el contenedor.
 */
export type DotsActionSheetVariant =
  | 'standard'
  | 'list'
  | 'input'
  | 'radioButtons'
  | 'settings'
  | 'search'
  | 'spotlight';

export interface DotsActionSheetListItemProps {
  /** Nombre real del icono Dots (20px sobre caja 40×40 r12). Dart: DotsListItem.icon */
  icon?: string;
  /** Nodo alternativo para la caja del icono (p.ej. imagen). */
  iconNode?: React.ReactNode;
  /** Texto (bodyLargeBold). Dart: text */
  label: string;
  /** Candado 14px tras el texto. Dart: showLockIcon */
  showLockIcon?: boolean;
  /** Dart: onTap */
  onClick?: () => void;
}

export interface DotsActionSheetSelectedItem {
  /** Dart: SelectedItem.id */
  id: string | number;
  /** Dart: SelectedItem.name */
  name: string;
}

export interface DotsActionSheetRadioOption {
  id?: string | number;
  /** Título de la card (bodyDefaultBold). Dart: RadioCardIcons */
  title: string;
  /** Icono 16px junto al título. */
  titleIcon?: string;
  /** Líneas de detalle (13px textTertiary), con icono 16px opcional. */
  details?: Array<{ icon?: string; label: string }>;
  /** Control derecho: radio (default) o toggle. */
  control?: 'radio' | 'toggle';
  selected?: boolean;
}

export interface DotsActionSheetSystemButton {
  /** Nombre real del icono Dots (20px). */
  icon?: string;
  label: string;
  /** Texto/icono en labelDestructive. Dart: DotsSystemButton destructive */
  destructive?: boolean;
  disabled?: boolean;
  onTap?: () => void;
}

export interface DotsActionSheetProps {
  /** Variante. Mapa a Dart: standard→DotsActionSheetStandard, list→DotsActionSheetList,
   * input→DotsActionSheetInput, radioButtons→DotsActionSheetRadioButtons,
   * settings→DotsActionSheetSettings, search→DotsActionSheetSearch,
   * spotlight→DotsActionSheetSpotlight. Default 'standard'. */
  variant?: DotsActionSheetVariant;
  /** Grabber 36×4. Default: true en todas menos 'search'. */
  showGrabber?: boolean;
  /** DotsCloseButton medium softContrast arriba a la derecha. Default false. */
  showCloseButton?: boolean;
  /** Tap en el botón de cierre. Dart: onClose / onCloseButtonTap */
  onClose?: () => void;

  /** Título. standard/radioButtons: title02H5 (20 serif); resto: title02H6 (18 serif);
   * settings: titleH5 (20/700 Inter). */
  title?: string;
  /** Texto secundario bajo el título (por variante: description/subtitle Dart). */
  description?: string;
  /** Contenido libre: standard → cuerpo central; list/search → sustituye a `items`. */
  children?: React.ReactNode;

  /** Botón principal (DotsMainButton main mainAction; search: large/h44). */
  primaryLabel?: string;
  onPrimaryTap?: () => void;
  /** Dart: enabled / isMainButtonAvailable / enableMainButton. Default true. */
  primaryEnabled?: boolean;
  /** Botón secundario (DotsMainButton secondary). Dart: secondaryButton */
  secondaryLabel?: string;
  onSecondaryTap?: () => void;
  /** Nodos personalizados que sustituyen a primaryLabel/secondaryLabel. */
  primaryButton?: React.ReactNode;
  secondaryButton?: React.ReactNode;
  /** Dart: DotsActionSheetButtonPositioning (default 'row'). */
  buttonPositioning?: 'row' | 'column';

  // ── standard ──
  /** Nodo superior (icono/imagen). Dart: topWidget */
  topContent?: React.ReactNode;
  /** Nodo inferior a ancho completo. Dart: bottomWidget */
  bottomContent?: React.ReactNode;
  /** 0..1 → barra de progreso. Dart: stepProgress */
  stepProgress?: number;
  /** Espaciados 20 (true) o 16 (false). Dart: bigAspectRatio (default true) */
  bigAspectRatio?: boolean;

  // ── list ──
  /** Dart: ActionSheetListVariant ('main' default | 'ghost'). */
  listVariant?: 'main' | 'ghost';
  /** Flecha atrás a la izquierda del título. Dart: onBackButtonTap */
  showBackButton?: boolean;
  onBack?: () => void;
  /** Botón pequeño arriba a la derecha. Dart: labelButtonText/onLabelButtonTap */
  labelButtonText?: string;
  onLabelButtonTap?: () => void;
  labelButtonEnabled?: boolean;
  /** Campo de búsqueda (DotsTextField píldora). Dart: hintInputText */
  searchHint?: string;
  searchValue?: string;
  /** Dart: onInputChanged / onChanged */
  onSearchChanged?: (text: string) => void;
  /** Icono del campo. Dart: inputIcon (default 'ic-search') */
  searchIcon?: string;
  /** Chips de seleccionados. Dart: selectedItemNames */
  selectedItems?: DotsActionSheetSelectedItem[];
  /** Dart: onBtnChipTap */
  onChipTap?: (id: string | number) => void;
  /** Dart: listTitle */
  listTitle?: string;
  /** Filas DotsActionSheet.ListItem. Dart: listItems. También en 'search'. */
  items?: DotsActionSheetListItemProps[];
  /** Icono del footer ghost. Dart: mainButtonIcon (default 'ic-add') */
  mainButtonIcon?: string;

  // ── input ──
  /** Dart: ActionSheetInputVariant (cubiertas: 'main' default, 'colors'). */
  inputVariant?: 'main' | 'colors';
  /** Icono XL 52px sobre el campo. Dart: iconData */
  icon?: string;
  iconNode?: React.ReactNode;
  /** Color CSS del icono XL. */
  iconColor?: string;
  /** Dart: inputHintText */
  inputHint?: string;
  inputValue?: string;
  onInputChanged?: (text: string) => void;
  maxTextLength?: number;
  /** Círculos de color (variant colors). Dart: DotsColorOptionsRow */
  colors?: string[];
  selectedColorIndex?: number;
  onColorSelect?: (index: number) => void;

  // ── radioButtons ──
  /** Cards RadioCardIcons. Dart: items */
  options?: DotsActionSheetRadioOption[];
  onSelect?: (id: string | number) => void;

  // ── settings / spotlight ──
  /** URL de imagen: settings → avatar circular 100px; spotlight → imagen r24. */
  image?: string;
  /** spotlight: etiqueta 13px textTertiary bajo el título. Dart: label */
  label?: string;
  /** settings: filas DotsSystemButton. Dart: buttons */
  buttons?: DotsActionSheetSystemButton[];

  className?: string;
  style?: React.CSSProperties;
}

export declare const DotsActionSheet: React.ComponentType<DotsActionSheetProps> & {
  /** DotsListItem (dots_list_item.dart) — fila icono 40×40 + bodyLargeBold. */
  ListItem: React.ComponentType<DotsActionSheetListItemProps>;
};
