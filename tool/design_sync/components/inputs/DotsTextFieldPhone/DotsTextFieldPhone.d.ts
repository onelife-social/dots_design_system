import * as React from 'react';

/** Country code for the phone input. Dart: PhoneCountryCode */
export interface PhoneCountryCode {
    /** International prefix, e.g. '+34'. Dart: dialCode */
    dialCode: string;
    /** Flag emoji, e.g. '🇪🇸'. Dart: flagEmoji */
    flagEmoji: string;
}
export interface DotsTextFieldPhoneProps {
    /** Controlled value (React). When defined the component is controlled. */
    value?: string;
    /** Initial value in uncontrolled mode. */
    defaultValue?: string;
    /** Selected country (flag + prefix). Dart: countryCode (required) */
    countryCode: PhoneCountryCode;
    /** Tap on the country selector (open picker). Dart: onCountryTap (required) */
    onCountryTap: () => void;
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
    /** Pill background. Dart: background (default true) */
    background?: boolean;
    /** Bottom underline when background is false. Dart: showUnderline (default false) */
    showUnderline?: boolean;
    /** Focus on mount. */
    autoFocus?: boolean;
}
export declare function DotsTextFieldPhone(props: DotsTextFieldPhoneProps): import("react").JSX.Element;
