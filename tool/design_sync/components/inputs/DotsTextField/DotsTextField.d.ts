import * as React from 'react';

import { type ReactNode } from 'react';
export interface DotsTextFieldProps {
    /** Controlled value (React). When defined the component is controlled. */
    value?: string;
    /** Initial value in uncontrolled mode (mirror of the initial TextEditingController). */
    defaultValue?: string;
    /** Real Dots icon name (e.g. 'ic-search'). Dart: iconData */
    icon?: string;
    /** Optional leading node (e.g. country selector). Dart: leading */
    leading?: ReactNode;
    /** Placeholder. Dart: hintText */
    hintText?: string;
    /** Paint the hint in labelDestructive when isError and unfocused. Dart: addHintTextColorError */
    addHintTextColorError?: boolean;
    /** Text change. Dart: onChanged */
    onChanged?: (text: string) => void;
    /** Enter/submit. Dart: onSubmitted */
    onSubmitted?: (text: string) => void;
    /** Focus lost. Dart: onFocusLost */
    onFocusLost?: (text: string) => void;
    /** Max length. Dart: maxTextLength */
    maxTextLength?: number;
    /** Error state. Dart: isError (default false) */
    isError?: boolean;
    /** Error text under the field (only with background). Dart: errorText */
    errorText?: string;
    /** Enabled. Dart: enabled (default true) */
    enabled?: boolean;
    /** Pill background bgContainerSecondaryOnBackground. Dart: background (default true) */
    background?: boolean;
    /** Bottom underline when background is false. Dart: showUnderline (default false) */
    showUnderline?: boolean;
    /** Centered text. Dart: alignCenter (default false) */
    alignCenter?: boolean;
    /** Keyboard type. Dart: keyboardType (TextInputType) */
    keyboardType?: 'text' | 'number' | 'phone' | 'emailAddress' | 'url';
    /** Auto capitalization. Dart: textCapitalization (default 'none') */
    textCapitalization?: 'none' | 'words' | 'sentences' | 'characters';
    /** Focus on mount (web substitute of the initial FocusNode.requestFocus). */
    autoFocus?: boolean;
}
export declare function DotsTextField(props: DotsTextFieldProps): import("react").JSX.Element;
