// DotsTextFieldButton — port of lib/src/components/text_fields/dots_textfield_button.dart (Dart = source of truth).
// 44px pill text field with a clear button (DotsCloseButton) while focused, an optional suffix icon
// (takes the clear button's place), an optional end text button behind a divider, and an error state.
import { useRef, useState, type ChangeEvent, type KeyboardEvent } from 'react';
import { DotsCloseButton, type DotsCloseButtonSize, type DotsCloseButtonVariant } from '../DotsCloseButton/DotsCloseButton';
import { DotsIcon } from '../DotsIcon/DotsIcon';

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

export function DotsTextFieldButton(props: DotsTextFieldButtonProps) {
  const controlled = props.value !== undefined && props.value !== null;
  const [innerText, setText] = useState(props.defaultValue != null ? String(props.defaultValue) : '');
  const [focused, setFocused] = useState(false);
  const inputRef = useRef<HTMLInputElement>(null);

  const text = controlled ? String(props.value) : innerText;
  const enabled = props.enabled !== false; // Dart: enabled = true
  const background = props.background !== false; // Dart: background = true
  const isError = !!props.isError; // Dart: isError = false
  const alignCenter = !!props.alignCenter; // Dart: alignCenter = false
  const applyErrorColor = props.applyErrorColor !== false; // Dart: applyErrorColor = true
  const applyErrorAsterisk = props.applyErrorAsterisk !== false; // Dart: applyErrorAsterisk = true
  const showClear = text.length > 0 && focused; // Dart: _showClearButton

  function handleChange(e: ChangeEvent<HTMLInputElement>) {
    const v = e.target.value;
    if (!controlled) setText(v);
    props.onChanged?.(v);
  }
  function handleKeyDown(e: KeyboardEvent<HTMLInputElement>) {
    if (e.key === 'Enter') props.onSubmitted?.(e.currentTarget.value);
  }
  function handleClear() {
    // Dart: _defaultClear — controller.clear() + onChanged('')
    if (!controlled) setText('');
    props.onChanged?.('');
    inputRef.current?.focus();
  }
  function handleBoxClick() {
    if (enabled) inputRef.current?.focus();
  }

  // suffixIcon has priority over the clear button (Dart)
  let suffix = null;
  if (props.suffixIcon) {
    suffix = (
      <span className="ds-tf-btn__suffix" style={props.suffixIconColor ? { color: props.suffixIconColor } : undefined} aria-hidden>
        <DotsIcon name={props.suffixIcon} size={16} color="currentColor" />
      </span>
    );
  } else if (showClear) {
    suffix = (
      <span className="ds-tf-btn__clear" onMouseDown={(e) => e.preventDefault()}>
        <DotsCloseButton
          icon={props.iconButton ?? 'ic-cross'} // Dart: iconDataButton = DotsIconData.cross
          variant={props.buttonVariant ?? 'inverted'} // Dart: DotsCloseButtonVariant.inverted
          size={props.buttonSize ?? 'extraSmall'} // Dart: DotsCloseButtonSize.extraSmall
          onClick={props.onButtonClick ?? handleClear} // Dart: onTapBtn ?? _defaultClear
          ariaLabel="Clear text"
        />
      </span>
    );
  }

  const inputCls = 'ds-tf-btn__input' + (applyErrorColor && isError ? ' ds-tf-btn__input--error' : '') + (isError ? ' ds-tf-btn__input--hint-error' : '');

  return (
    <div className={`ds-tf-btn${alignCenter ? ' ds-tf-btn--center' : ''}`}>
      <div className={`ds-tf-btn__box${background ? '' : ' ds-tf-btn__box--no-bg'}`} onClick={handleBoxClick}>
        {props.icon ? (
          <span className={`ds-tf-btn__icon${isError ? ' ds-tf-btn__icon--error' : ''}`} aria-hidden>
            <DotsIcon name={props.icon} size={20} color="currentColor" />
          </span>
        ) : null}
        <input
          ref={inputRef}
          className={inputCls}
          type="text"
          value={text}
          placeholder={props.hintText ?? ''} // Dart: hintText = ''
          maxLength={props.maxTextLength}
          disabled={!enabled}
          autoFocus={!!props.autoFocus}
          autoCapitalize={props.textCapitalization ?? 'none'} // Dart: TextCapitalization.none
          onChange={handleChange}
          onKeyDown={handleKeyDown}
          onFocus={() => setFocused(true)}
          onBlur={() => setFocused(false)}
        />
        {suffix}
        {props.endButtonText != null ? (
          <>
            <span className="ds-tf-btn__end-divider" />
            <button
              type="button"
              className="ds-tf-btn__end-btn"
              style={props.endButtonTextColor ? { color: props.endButtonTextColor } : undefined}
              onMouseDown={(e) => e.preventDefault()}
              onClick={props.onEndButtonClick} // Dart: onEndButtonTap
            >
              {props.endButtonText}
            </button>
          </>
        ) : null}
      </div>
      {isError && props.errorText != null ? <div className="ds-tf-btn__error-text">{applyErrorAsterisk ? `* ${props.errorText}` : props.errorText}</div> : null}
    </div>
  );
}
