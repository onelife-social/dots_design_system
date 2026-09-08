import * as React from 'react';

import type { CSSProperties, ReactNode } from 'react';
export type DotsActionSheetVariant = 'standard' | 'list' | 'input' | 'radioButtons' | 'settings' | 'search' | 'spotlight';
export interface DotsActionSheetListItemProps {
    /** Real Dots icon name (20px on a 40×40 r12 box). Dart: DotsListItem.icon */
    icon?: string;
    /** Alternative node for the icon box (e.g. an image). */
    iconNode?: ReactNode;
    /** Text (bodyLargeBold). Dart: text */
    label: string;
    /** 14px lock after the text. Dart: showLockIcon */
    showLockIcon?: boolean;
    /** Dart: onTap */
    onClick?: () => void;
}
export interface DotsActionSheetSelectedItem {
    id: string | number;
    name: string;
}
export interface DotsActionSheetRadioOption {
    id?: string | number;
    /** Card title (bodyDefaultBold). Dart: RadioCardIcons */
    title: string;
    /** 16px icon next to the title. */
    titleIcon?: string;
    /** Detail lines (13px textTertiary), optional 16px icon. */
    details?: Array<{
        icon?: string;
        label: string;
    }>;
    /** Right control: radio (default) or toggle. */
    control?: 'radio' | 'toggle';
    selected?: boolean;
}
export interface DotsActionSheetSystemButton {
    icon?: string;
    label: string;
    /** Text/icon in labelDestructive. Dart: DotsSystemButton destructive */
    destructive?: boolean;
    disabled?: boolean;
    onTap?: () => void;
}
export interface DotsActionSheetProps {
    /** Variant. Default 'standard'. */
    variant?: DotsActionSheetVariant;
    /** 36×4 grabber. Default: true on every variant but 'search'. */
    showGrabber?: boolean;
    /** DotsCloseButton medium softContrast top-right. Default false. */
    showCloseButton?: boolean;
    /** Tap on the close button. Dart: onClose / onCloseButtonTap */
    onClose?: () => void;
    /** Title. standard/radioButtons: title02H5 (20 serif); others: title02H6 (18 serif); settings: titleH5 (20/700 Inter). */
    title?: string;
    /** Secondary text under the title (per variant: description/subtitle in Dart). */
    description?: string;
    /** Free content: standard → central body; list/search → replaces `items`. */
    children?: ReactNode;
    /** Primary button (DotsMainButton main mainAction; search: large/h44). */
    primaryLabel?: string;
    onPrimaryTap?: () => void;
    /** Dart: enabled / isMainButtonAvailable / enableMainButton. Default true. */
    primaryEnabled?: boolean;
    /** Secondary button (DotsMainButton secondary). Dart: secondaryButton */
    secondaryLabel?: string;
    onSecondaryTap?: () => void;
    /** Custom nodes replacing primaryLabel/secondaryLabel. */
    primaryButton?: ReactNode;
    secondaryButton?: ReactNode;
    /** Dart: DotsActionSheetButtonPositioning (default 'row'). */
    buttonPositioning?: 'row' | 'column';
    /** Top node (icon/image). Dart: topWidget */
    topContent?: ReactNode;
    /** Full-width bottom node. Dart: bottomWidget */
    bottomContent?: ReactNode;
    /** 0..1 → progress bar. Dart: stepProgress */
    stepProgress?: number;
    /** Spacing 20 (true) or 16 (false). Dart: bigAspectRatio (default true) */
    bigAspectRatio?: boolean;
    /** Dart: ActionSheetListVariant ('main' default | 'ghost'). */
    listVariant?: 'main' | 'ghost';
    /** Back arrow left of the title. Dart: onBackButtonTap */
    showBackButton?: boolean;
    onBack?: () => void;
    /** Small button top-right. Dart: labelButtonText/onLabelButtonTap */
    labelButtonText?: string;
    onLabelButtonTap?: () => void;
    labelButtonEnabled?: boolean;
    /** Search field (DotsTextField pill). Dart: hintInputText */
    searchHint?: string;
    searchValue?: string;
    /** Dart: onInputChanged / onChanged */
    onSearchChanged?: (text: string) => void;
    /** Field icon. Dart: inputIcon (default 'ic-search') */
    searchIcon?: string;
    /** Selected chips. Dart: selectedItemNames */
    selectedItems?: DotsActionSheetSelectedItem[];
    /** Dart: onBtnChipTap */
    onChipTap?: (id: string | number) => void;
    /** Dart: listTitle */
    listTitle?: string;
    /** DotsActionSheet.ListItem rows. Dart: listItems. Also in 'search'. */
    items?: DotsActionSheetListItemProps[];
    /** Ghost footer icon. Dart: mainButtonIcon (default 'ic-add') */
    mainButtonIcon?: string;
    /** Dart: ActionSheetInputVariant (covered: 'main' default, 'colors'). */
    inputVariant?: 'main' | 'colors';
    /** XL 52px icon above the field. Dart: iconData */
    icon?: string;
    iconNode?: ReactNode;
    /** CSS color of the XL icon. */
    iconColor?: string;
    /** Dart: inputHintText */
    inputHint?: string;
    inputValue?: string;
    onInputChanged?: (text: string) => void;
    maxTextLength?: number;
    /** Color circles (variant colors). Dart: DotsColorOptionsRow */
    colors?: string[];
    selectedColorIndex?: number;
    onColorSelect?: (index: number) => void;
    /** RadioCardIcons cards. Dart: items */
    options?: DotsActionSheetRadioOption[];
    onSelect?: (id: string | number) => void;
    /** Image URL: settings → 100px circular avatar; spotlight → r24 image. */
    image?: string;
    /** spotlight: 13px textTertiary label under the title. Dart: label */
    label?: string;
    /** settings: DotsSystemButton rows. Dart: buttons */
    buttons?: DotsActionSheetSystemButton[];
    className?: string;
    style?: CSSProperties;
}
export declare function DotsActionSheetListItem(p: DotsActionSheetListItemProps): import("react").JSX.Element;
export declare function DotsActionSheet(props: DotsActionSheetProps): import("react").JSX.Element;
export declare namespace DotsActionSheet {
    var ListItem: typeof DotsActionSheetListItem;
}
