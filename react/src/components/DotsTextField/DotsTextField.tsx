// DotsTextField — port of lib/src/components/text_fields/dots_textfield.dart (Dart = source of truth).
import { useRef, useState, type ChangeEvent, type FocusEvent, type KeyboardEvent, type ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

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

// TextInputType (Dart) → <input> attributes
const KEYBOARD: Record<string, { type: string; inputMode?: 'email' | 'tel' | 'numeric' | 'url' }> = {
  emailAddress: { type: 'email', inputMode: 'email' },
  phone: { type: 'tel', inputMode: 'tel' },
  number: { type: 'text', inputMode: 'numeric' },
  url: { type: 'url', inputMode: 'url' },
};

export function DotsTextField(props: DotsTextFieldProps) {
  const controlled = props.value !== undefined && props.value !== null;
  const [innerText, setText] = useState(props.defaultValue != null ? String(props.defaultValue) : '');
  const [focused, setFocused] = useState(false);
  const inputRef = useRef<HTMLInputElement>(null);

  const text = controlled ? String(props.value) : innerText;
  const enabled = props.enabled !== false; // Dart: enabled = true
  const background = props.background !== false; // Dart: background = true
  const showUnderline = !!props.showUnderline; // Dart: showUnderline = false
  const alignCenter = !!props.alignCenter; // Dart: alignCenter = false
  const isError = !!props.isError; // Dart: isError = false

  const showClear = enabled && focused && text.length > 0; // Dart: _showClearButton
  const kb = (props.keyboardType && KEYBOARD[props.keyboardType]) || { type: 'text', inputMode: undefined };

  function handleChange(e: ChangeEvent<HTMLInputElement>) {
    const v = e.target.value;
    if (!controlled) setText(v);
    props.onChanged?.(v);
  }
  function handleKeyDown(e: KeyboardEvent<HTMLInputElement>) {
    if (e.key === 'Enter') props.onSubmitted?.(e.currentTarget.value);
  }
  function handleBlur(e: FocusEvent<HTMLInputElement>) {
    setFocused(false);
    props.onFocusLost?.(e.target.value); // Dart: onFocusLost
  }
  function handleClear() {
    if (!controlled) setText('');
    props.onChanged?.('');
    inputRef.current?.focus();
  }
  function handleBoxClick() {
    // Dart: GestureDetector → focusNode.requestFocus()
    if (enabled) inputRef.current?.focus();
  }

  const rootCls = `ds-textfield${alignCenter ? ' ds-textfield--center' : ''}`;
  const boxCls =
    'ds-textfield__box' + (background ? '' : ' ds-textfield__box--no-bg') + (!background && showUnderline ? ' ds-textfield__box--underline' : '');
  // Dart: text color = labelDestructive only if isError && !background && !focus
  const inputCls =
    'ds-textfield__input' +
    (isError && !background && !focused ? ' ds-textfield__input--error' : '') +
    (props.addHintTextColorError === true && isError && !focused ? ' ds-textfield__input--hint-error' : '');
  // Dart: destructive icon only if !background && isError
  const iconCls = `ds-textfield__icon${!background && isError ? ' ds-textfield__icon--error' : ''}`;

  return (
    <div className={rootCls}>
      <div className={boxCls} onClick={handleBoxClick}>
        {props.leading ?? null}
        {props.icon ? (
          <span className={iconCls} aria-hidden>
            <DotsIcon name={props.icon} size={20} color="currentColor" />
          </span>
        ) : null}
        <input
          ref={inputRef}
          className={inputCls}
          type={kb.type}
          inputMode={kb.inputMode}
          value={text}
          placeholder={props.hintText}
          maxLength={props.maxTextLength}
          disabled={!enabled}
          autoFocus={!!props.autoFocus}
          autoCapitalize={props.textCapitalization ?? 'none'} // Dart: TextCapitalization.none
          onChange={handleChange}
          onKeyDown={handleKeyDown}
          onFocus={() => setFocused(true)}
          onBlur={handleBlur}
        />
        {showClear ? (
          <button
            type="button"
            // Dart: DotsCloseButton extraSmall — inverted (with background) / softContrast (without)
            className={`ds-textfield__clear ${background ? 'ds-textfield__clear--inverted' : 'ds-textfield__clear--soft'}`}
            aria-label="Clear text"
            onMouseDown={(e) => e.preventDefault()} // do not steal focus from the input
            onClick={handleClear}
          >
            <DotsIcon name="ic-cross" size={10} color="currentColor" />
          </button>
        ) : null}
      </div>
      {background && isError && props.errorText ? <div className="ds-textfield__error-text">{props.errorText}</div> : null}
    </div>
  );
}
