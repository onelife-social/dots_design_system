// DotsAlert — port of lib/src/components/alerts/dots_alert.dart (Dart = source of truth).
// 320px dialog card: highlighted icon chip, title/message and per-variant actions. The Dart named
// factories (DotsAlert.oneButton, .twoVerticalButtons, …) are expressed with the `variant` prop.
// Deviation: Dart always paints a full-screen Stack with a 50% black scrim; here the scrim is opt-in
// (`showScrim`) so the bare card can be composed in designs.
import { useState } from 'react';
import { DotsCloseButton } from '../DotsCloseButton/DotsCloseButton';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsMainButton, type DotsMainButtonVariant } from '../DotsMainButton/DotsMainButton';
import { DotsTextFieldButton } from '../DotsTextFieldButton/DotsTextFieldButton';

/** Dart enum DotsAlertVariant */
export type DotsAlertVariant =
  | 'noButtons'
  | 'oneButton'
  | 'twoHorizontalButtons'
  | 'twoHorizontalButtonsDestructive'
  | 'twoVerticalButtons'
  | 'twoVerticalButtonsNoActive'
  | 'twoVerticalButtonsDestructive'
  | 'input'
  | 'selector';

const VARIANTS: DotsAlertVariant[] = [
  'noButtons',
  'oneButton',
  'twoHorizontalButtons',
  'twoHorizontalButtonsDestructive',
  'twoVerticalButtons',
  'twoVerticalButtonsNoActive',
  'twoVerticalButtonsDestructive',
  'input',
  'selector',
];

/** Dart DotsListItemModel (selector variant) */
export interface DotsAlertSelectorItem {
  /** Dart `label` */
  label: string;
  /** 40×40 thumbnail URL (placeholder when omitted) — Dart `image` */
  image?: string;
  /** Dart `onTap` */
  onClick?: () => void;
}

export interface DotsAlertProps {
  /** Dart enum DotsAlertVariant (default 'noButtons') */
  variant?: DotsAlertVariant;
  /** DotsIcon name of the 48px highlight chip — Dart `iconData` */
  icon: string;
  /** 48×48 image URL replacing the chip (falls back to the chip on error) — Dart `iconImage` */
  iconImage?: string;
  /** bodyLargeBold — Dart `title` */
  title?: string;
  /** bodyDefaultRegular; not shown by the input variant — Dart `message` */
  message?: string;
  /** Close (X button, and tap outside with `showScrim`) — Dart `onClose` */
  onClose?: () => void;
  /** With `showScrim`, tap outside runs onClose (default true) — Dart `enableCloseOnTapOutside` */
  enableCloseOnTapOutside?: boolean;
  /** (input) Text change — Dart `onInputChanged` */
  onInputChanged?: (value: string) => void;
  /** (input) Placeholder — Dart `inputHint` */
  inputHint?: string;
  /** (selector) Rows — Dart `selectorItemList` */
  selectorItems?: DotsAlertSelectorItem[];
  /** Dart `mainButtonText` */
  mainButtonText?: string;
  /** Dart `mainButtonOnTap` */
  onMainButtonClick?: () => void;
  /** Dart `secondaryButtonText` */
  secondaryButtonText?: string;
  /** Dart `secondaryButtonOnTap` */
  onSecondaryButtonClick?: () => void;
  /** Top-right DotsCloseButton (medium, softContrast) — Dart `showCloseButton` (default false) */
  showCloseButton?: boolean;
  /** Backdrop blur 50 behind the card — Dart `showBlurBackground` (default true) */
  showBlurBackground?: boolean;
  /** Fixed 50% black scrim with the card centered (always present in Dart; opt-in here) */
  showScrim?: boolean;
  className?: string;
}

const hasText = (v?: string) => v != null && v.trim() !== '';

export function DotsAlert(props: DotsAlertProps) {
  const [imgFailed, setImgFailed] = useState(false);
  const variant: DotsAlertVariant = props.variant && VARIANTS.includes(props.variant) ? props.variant : 'noButtons';
  const isInput = variant === 'input';
  const isSelector = variant === 'selector';
  const showBlur = props.showBlurBackground !== false; // Dart: showBlurBackground = true

  // _mainButton: DotsMainButton(adaptPaddingForText, size large)
  const button = (key: string, v: DotsMainButtonVariant, text?: string, onClick?: () => void) => (
    <DotsMainButton key={key} label={text ?? ''} variant={v} size="large" adaptPaddingForText onClick={onClick} />
  );

  // _icon: Padding(8) > chip 48×48 r24.5 (labelHighlight 20% = bgHighlight) > icon 24 labelHighlight;
  // iconImage 48×48 cover, errorBuilder → chip
  const chip = (
    <div className="ds-alert__icon-chip">
      <DotsIcon name={props.icon} size={24} color="currentColor" />
    </div>
  );
  const header = (
    <div className="ds-alert__header">
      {props.showCloseButton ? <span className="ds-alert__header-spacer" /> : null}
      <div className="ds-alert__icon-center">
        <div className="ds-alert__icon-pad">
          {props.iconImage && !imgFailed ? <img className="ds-alert__icon-img" src={props.iconImage} alt="" onError={() => setImgFailed(true)} /> : chip}
        </div>
      </div>
      {props.showCloseButton ? <DotsCloseButton icon="ic-cross" size="medium" variant="softContrast" onClick={props.onClose} /> : null}
    </div>
  );

  // _description
  let description = null;
  if (isInput) {
    // Dart: Row(children: [DotsTextFieldButton(iconData: search, hintText, onChanged)])
    description = (
      <div className="ds-alert__input">
        <DotsTextFieldButton icon="ic-search" hintText={props.inputHint} onChanged={props.onInputChanged} />
      </div>
    );
  } else if (isSelector) {
    // Dart: message (padding 16 horizontal) + DotsMainContainer(r24, padding 12) with DotsListsItem rows (gap 8).
    // The rows approximate DotsListsItem.main (40px thumb + bodyDefaultMedium label) until it is ported.
    const items = props.selectorItems ?? [];
    description = (
      <div className="ds-alert__selector">
        {hasText(props.message) ? <p className="ds-alert__msg ds-alert__selector-msg">{props.message}</p> : null}
        <div className="ds-alert__list">
          {items.map((it, i) => (
            <button key={i} type="button" className="ds-alert__list-item" onClick={it.onClick}>
              {it.image ? <img className="ds-alert__list-thumb" src={it.image} alt="" /> : <span className="ds-alert__list-thumb" />}
              <span className="ds-alert__list-label">{it.label}</span>
            </button>
          ))}
        </div>
      </div>
    );
  } else if (hasText(props.message)) {
    description = <p className="ds-alert__msg">{props.message}</p>;
  }

  // _actions
  let actions = null;
  switch (variant) {
    case 'oneButton':
      actions = <div className="ds-alert__actions">{button('m', 'main', props.mainButtonText, props.onMainButtonClick)}</div>;
      break;
    case 'twoHorizontalButtons':
    case 'twoHorizontalButtonsDestructive':
    case 'input':
    case 'selector':
      actions = (
        <div className="ds-alert__actions ds-alert__actions--row">
          {button('s', 'secondary', props.secondaryButtonText, props.onSecondaryButtonClick)}
          {button('m', variant === 'twoHorizontalButtonsDestructive' ? 'destructive' : 'main', props.mainButtonText, props.onMainButtonClick)}
        </div>
      );
      break;
    case 'twoVerticalButtons':
      actions = (
        <div className="ds-alert__actions ds-alert__actions--col">
          {button('m', 'main', props.mainButtonText, props.onMainButtonClick)}
          {button('s', 'ghost', props.secondaryButtonText, props.onSecondaryButtonClick)}
        </div>
      );
      break;
    case 'twoVerticalButtonsDestructive':
      actions = (
        <div className="ds-alert__actions ds-alert__actions--col">
          {button('m', 'destructive', props.mainButtonText, props.onMainButtonClick)}
          {button('s', 'ghost', props.secondaryButtonText, props.onSecondaryButtonClick)}
        </div>
      );
      break;
    case 'twoVerticalButtonsNoActive':
      actions = (
        <div className="ds-alert__actions ds-alert__actions--col ds-alert__actions--gap8">
          {button('m', 'secondary', props.mainButtonText, props.onMainButtonClick)}
          {button('s', 'secondary', props.secondaryButtonText, props.onSecondaryButtonClick)}
        </div>
      );
      break;
    default:
      actions = null; // noButtons
  }

  const card = (
    <div
      className={`ds-alert ds-alert--${variant}${showBlur ? ' ds-alert--blur' : ''}${props.className ? ` ${props.className}` : ''}`}
      role="alertdialog"
      aria-label={props.title}
    >
      {header}
      <div className="ds-alert__body">
        {hasText(props.title) ? <p className="ds-alert__title">{props.title}</p> : null}
        {description}
      </div>
      {actions}
    </div>
  );

  if (!props.showScrim) return card;
  // Stack: Positioned.fill black 50% (tap outside → onClose when enableCloseOnTapOutside) + Center
  return (
    <div
      className="ds-alert__scrim"
      onClick={(e) => {
        if (e.target === e.currentTarget && props.enableCloseOnTapOutside !== false) props.onClose?.();
      }}
    >
      {card}
    </div>
  );
}
