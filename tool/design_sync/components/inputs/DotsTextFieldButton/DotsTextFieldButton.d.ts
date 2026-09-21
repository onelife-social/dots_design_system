import * as React from 'react';

import { type DotsCloseButtonSize, type DotsCloseButtonVariant } from '../../buttons/DotsCloseButton/DotsCloseButton';
export interface DotsTextFieldButtonProps {
    /** Controlled value (React). When defined the component is controlled. */
    value?: string;
    /** Initial value in uncontrolled mode (mirror of the initial TextEditingController). */
    defaultValue?: string;
    /** Leading Dots icon name (e.g. 'ic-send'). Dart: iconData */
    icon?: string;
    /** Icon of the clear button. Dart: iconDataButton (default cross) */
    iconButton?: string;
    /** Tap on the clear button; clears the field by default. Dart: onTapBtn */
    onButtonClick?: () => void;
    /** DotsCloseButton variant. Dart: buttonVariant (default 'inverted') */
    buttonVariant?: DotsCloseButtonVariant;
    /** DotsCloseButton size. Dart: buttonSize (default 'extraSmall') */
    buttonSize?: DotsCloseButtonSize;
    /** Placeholder. Dart: hintText (default '') */
    hintText?: string;
    /** Max length. Dart: maxTextLength */
    maxTextLength?: number;
    /** Auto capitalization. Dart: textCapitalization (default 'none') */
    textCapitalization?: 'none' | 'words' | 'sentences' | 'characters';
    /** Text change. Dart: onChanged */
    onChanged?: (text: string) => void;
    /** Enter/submit. Dart: onSubmitted */
    onSubmitted?: (text: string) => void;
    /** Error state. Dart: isError (default false) */
    isError?: boolean;
    /** Error text under the field. Dart: errorText */
    errorText?: string;
    /** Centered text. Dart: alignCenter (default false) */
    alignCenter?: boolean;
    /** Pill background bgContainerSecondaryOnBackground. Dart: background (default true) */
    background?: boolean;
    /** End text button (behind a divider). Dart: endButtonText */
    endButtonText?: string;
    /** CSS color of the end button. Dart: endButtonTextColor (default labelHighlight) */
    endButtonTextColor?: string;
    /** Tap on the end button. Dart: onEndButtonTap */
    onEndButtonClick?: () => void;
    /** 16px suffix icon (replaces the clear button). Dart: suffixIcon */
    suffixIcon?: string;
    /** CSS color of the suffix icon. Dart: suffixIconColor (default labelHighlight) */
    suffixIconColor?: string;
    /** Enabled. Dart: enabled (default true) */
    enabled?: boolean;
    /** Paint the text in destructive when isError. Dart: applyErrorColor (default true) */
    applyErrorColor?: boolean;
    /** Prefix '* ' to errorText. Dart: applyErrorAsterisk (default true) */
    applyErrorAsterisk?: boolean;
    /** Focus on mount. */
    autoFocus?: boolean;
}
export declare function DotsTextFieldButton(props: DotsTextFieldButtonProps): import("react").JSX.Element;
