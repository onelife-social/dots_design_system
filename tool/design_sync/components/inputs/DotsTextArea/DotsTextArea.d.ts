import * as React from 'react';

export interface DotsTextAreaProps {
    /** Controlled value (React). When defined the component is controlled. */
    value?: string;
    /** Initial value in uncontrolled mode (mirror of the initial TextEditingController). */
    defaultValue?: string;
    /** Label above the text. Dart: label */
    label?: string;
    /** Real Dots icon name (e.g. 'ic-pencil'). Dart: iconData */
    icon?: string;
    /** Placeholder. Dart: hintText */
    hintText?: string;
    /** Text change. Dart: onChanged */
    onChanged?: (text: string) => void;
    /** Submit (Ctrl/Cmd+Enter on web; Enter inserts a newline). Dart: onSubmitted */
    onSubmitted?: (text: string) => void;
    /** Max length; shows the remaining-characters counter. Dart: maxTextLength */
    maxTextLength?: number;
    /** Auto capitalization. Dart: textCapitalization (default 'none') */
    textCapitalization?: 'none' | 'words' | 'sentences' | 'characters';
    /** Min height in px. Dart: minHeight (default: maxHeight ?? 50) */
    minHeight?: number;
    /** Max height in px; content scrolls inside. Dart: maxHeight */
    maxHeight?: number;
    /** Error state. Dart: isError (default false) */
    isError?: boolean;
    /** Error text under the area. Dart: errorText */
    errorText?: string;
    /** Focus on mount (web substitute of the initial FocusNode.requestFocus). */
    autoFocus?: boolean;
}
export declare function DotsTextArea(props: DotsTextAreaProps): import("react").JSX.Element;
