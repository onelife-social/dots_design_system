// DotsTextFieldPhone — port of lib/src/components/text_fields/dots_textfield_phone.dart (Dart = source of truth).
import type { KeyboardEvent, MouseEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsTextField } from '../DotsTextField/DotsTextField';

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

// Dart: FilteringTextInputFormatter.digitsOnly — letters typed or pasted never reach value/onChanged
const digitsOnly = (text: string) => text.replace(/\D+/g, '');

export function DotsTextFieldPhone(props: DotsTextFieldPhoneProps) {
  const enabled = props.enabled !== false; // Dart: enabled = true
  const cc = props.countryCode || { dialCode: '', flagEmoji: '' };

  function handleCountryClick(e: MouseEvent<HTMLSpanElement>) {
    e.stopPropagation(); // do not steal the click from the box (which focuses the input)
    if (enabled) props.onCountryTap?.();
  }
  function handleCountryKeyDown(e: KeyboardEvent<HTMLSpanElement>) {
    if ((e.key === 'Enter' || e.key === ' ') && enabled) {
      e.preventDefault();
      props.onCountryTap?.();
    }
  }

  // Dart: leading = flag + ' (dialCode)' + chevron-down 14 + divider 0.5 labelSecondary·0.3
  const leading = (
    <span
      className={`ds-tf-phone__lead${enabled ? '' : ' ds-tf-phone__lead--disabled'}`}
      role="button"
      aria-disabled={enabled ? undefined : true}
      tabIndex={enabled ? 0 : undefined}
      onClick={handleCountryClick}
      onKeyDown={handleCountryKeyDown}
    >
      <span className="ds-tf-phone__flag">{cc.flagEmoji}</span>
      <span className="ds-tf-phone__dial">{` (${cc.dialCode})`}</span>
      <span className="ds-tf-phone__chev" aria-hidden>
        <DotsIcon name="ic-chevron-down" size={14} color="currentColor" />
      </span>
      <span className="ds-tf-phone__divider" />
    </span>
  );

  // Dart: delegates to DotsTextField with keyboardType phone + digitsOnly
  return (
    <DotsTextField
      leading={leading}
      value={props.value}
      defaultValue={props.defaultValue}
      hintText={props.hintText}
      addHintTextColorError={props.addHintTextColorError}
      onChanged={props.onChanged}
      onSubmitted={props.onSubmitted}
      onFocusLost={props.onFocusLost}
      maxTextLength={props.maxTextLength}
      isError={props.isError}
      errorText={props.errorText}
      enabled={enabled}
      background={props.background}
      showUnderline={props.showUnderline}
      keyboardType="phone" // TextInputType.phone → type=tel/inputMode tel
      inputFilter={digitsOnly} // Dart: FilteringTextInputFormatter.digitsOnly
      autoFocus={props.autoFocus}
    />
  );
}
