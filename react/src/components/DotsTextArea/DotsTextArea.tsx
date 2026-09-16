// DotsTextArea — port of lib/src/components/text_fields/dots_textarea.dart (Dart = source of truth).
import { useId, useRef, useState, type ChangeEvent, type CSSProperties, type KeyboardEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

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

export function DotsTextArea(props: DotsTextAreaProps) {
  const controlled = props.value !== undefined && props.value !== null;
  const [innerText, setText] = useState(props.defaultValue != null ? String(props.defaultValue) : '');
  const areaRef = useRef<HTMLTextAreaElement>(null);
  const labelId = useId();
  const errorId = useId();

  const text = controlled ? String(props.value) : innerText;
  const hasLabel = !!props.label;
  const hasIcon = !!props.icon;
  const isError = !!props.isError;

  function handleChange(e: ChangeEvent<HTMLTextAreaElement>) {
    const v = e.target.value;
    if (!controlled) setText(v);
    props.onChanged?.(v);
  }
  function handleKeyDown(e: KeyboardEvent<HTMLTextAreaElement>) {
    // Dart: keyboardType multiline — Enter inserts a newline; web submit = Ctrl/Cmd+Enter
    if (e.key === 'Enter' && (e.metaKey || e.ctrlKey) && props.onSubmitted) {
      e.preventDefault(); // submitting must not also insert a newline (and fire onChanged)
      props.onSubmitted(e.currentTarget.value);
    }
  }
  function handleBoxClick() {
    // Dart: GestureDetector → focusNode.requestFocus()
    areaRef.current?.focus();
  }

  // Dart: minHeight = minHeight ?? maxHeight ?? 50; maxHeight → internal scroll
  const boxStyle: CSSProperties = { minHeight: `${props.minHeight ?? props.maxHeight ?? 50}px` };
  if (props.maxHeight != null) boxStyle.maxHeight = `${props.maxHeight}px`;

  // Dart: remaining = (maxTextLength - text.length).clamp(0, maxTextLength)
  const remaining = props.maxTextLength != null ? Math.min(Math.max(props.maxTextLength - text.length, 0), props.maxTextLength) : null;

  const area = (
    <div className="ds-textarea__grow" data-value={text}>
      <textarea
        aria-labelledby={hasLabel ? labelId : undefined}
        aria-invalid={isError || undefined}
        aria-describedby={isError && props.errorText ? errorId : undefined}
        ref={areaRef}
        className="ds-textarea__input"
        value={text}
        rows={1}
        placeholder={props.hintText}
        maxLength={props.maxTextLength}
        autoFocus={!!props.autoFocus}
        autoCapitalize={props.textCapitalization || 'none'} // Dart: TextCapitalization.none
        onChange={handleChange}
        onKeyDown={handleKeyDown}
      />
    </div>
  );

  const leadingIcon = hasIcon ? (
    <span className="ds-textarea__icon" aria-hidden>
      <DotsIcon name={props.icon ?? ''} size={20} color="currentColor" />
    </span>
  ) : null;

  const body = hasLabel ? (
    <>
      <div className="ds-textarea__label" id={labelId}>
        {leadingIcon}
        {props.label}
      </div>
      <div className={`ds-textarea__body${hasIcon ? ' ds-textarea__body--indent' : ''}`}>{area}</div>
    </>
  ) : (
    <div className="ds-textarea__row">
      {leadingIcon}
      <div className="ds-textarea__body">{area}</div>
    </div>
  );

  return (
    <div className="ds-textarea">
      <div className="ds-textarea__box" style={boxStyle} onClick={handleBoxClick}>
        {body}
        {remaining != null ? <span className="ds-textarea__counter">{String(remaining)}</span> : null}
      </div>
      {isError && props.errorText ? <div className="ds-textarea__error-text" id={errorId}>{props.errorText}</div> : null}
    </div>
  );
}
