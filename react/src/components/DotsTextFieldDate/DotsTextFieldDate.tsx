// DotsTextFieldDate — port of lib/src/components/text_fields/dots_textfield_date.dart (Dart = source of truth).
import type { KeyboardEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface DotsTextFieldDateProps {
  /** Real Dots icon name (e.g. 'ic-calendar'). Dart: iconData */
  icon?: string;
  /** Text on the left. Dart: label */
  label?: string;
  /** Date shown as a chip. Dart: date (required) */
  date: string;
  /** Time shown as a second chip. Dart: time */
  time?: string;
  /** Tap on the field (open the date picker). Dart: onTap (required) */
  onClick: () => void;
  /** Error state: paints the chip text in labelDestructive. Dart: isError (default false) */
  isError?: boolean;
  /** Error text under the field (only with background). Dart: errorText */
  errorText?: string;
  /** Pill background bgContainerSecondaryOnBackground. Dart: background (default true) */
  background?: boolean;
}

export function DotsTextFieldDate(props: DotsTextFieldDateProps) {
  const background = props.background !== false; // Dart: background = true
  const isError = !!props.isError; // Dart: isError = false

  // Dart: buildTextWidget — chip bgSecondaryBtn r24, minWidth 56, padding 10x4, bodyDefaultMedium, destructive text if isError
  const chip = (text?: string) =>
    text ? <span className={`ds-tf-date__chip${isError ? ' ds-tf-date__chip--error' : ''}`}>{text}</span> : null;

  function handleKeyDown(e: KeyboardEvent<HTMLDivElement>) {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      props.onClick();
    }
  }

  return (
    <div className="ds-tf-date">
      <div
        className={`ds-tf-date__box${background ? '' : ' ds-tf-date__box--no-bg'}`}
        role="button"
        tabIndex={0}
        onClick={props.onClick} // Dart: onTap
        onKeyDown={handleKeyDown}
      >
        {props.icon ? (
          <span className="ds-tf-date__icon" aria-hidden>
            <DotsIcon name={props.icon} size={20} color="currentColor" />
          </span>
        ) : null}
        {props.label ? <span className="ds-tf-date__label">{props.label}</span> : null}
        <span className="ds-tf-date__spacer" />
        <span className="ds-tf-date__chips">
          {chip(props.date)}
          {chip(props.time)}
        </span>
      </div>
      {background && isError && props.errorText ? <div className="ds-tf-date__error-text">{props.errorText}</div> : null}
    </div>
  );
}
