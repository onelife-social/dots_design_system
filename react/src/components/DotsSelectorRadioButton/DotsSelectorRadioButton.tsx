// DotsSelectorRadioButton (+ DotsSelectorRadioButtonLabel, DotsSettingItemRadioBtn) — port of lib/src/components/selectors/ (Dart = source of truth).
import { BadgeLabel, type BadgeLabelVariant } from '../BadgeLabel/BadgeLabel';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsRadioButton } from '../DotsRadioButton/DotsRadioButton';

export interface DotsSelectorRadioButtonProps {
  /** Selected (1.5px labelHighlight border) — Dart `isSelected` */
  isSelected: boolean;
  /** Title — bodyDefaultBold */
  title: string;
  /** Icon of the first detail row — Dart `icon1` (default DotsIconData.clockFilled) */
  icon1?: string;
  /** Size of icon 1 — Dart `icon1Size` (default 16) */
  icon1Size?: number;
  /** Text of the first detail row */
  details1: string;
  /** Icon of the second detail row — Dart `icon2` (default DotsIconData.calendar) */
  icon2?: string;
  /** Size of icon 2 — Dart `icon2Size` (default 16) */
  icon2Size?: number;
  /** Text of the second detail row */
  details2: string;
  /** Tap — Dart `onTap` */
  onClick?: () => void;
}

/** Label variant — Dart enum SelectorRadioButtonLabelVariant */
export type SelectorRadioButtonLabelVariant = 'free' | 'acquired' | 'premium' | 'premiumPlus';

export interface DotsSelectorRadioButtonLabelProps {
  /** Selected (only when `isSelectable`) — Dart `isSelected` */
  isSelected: boolean;
  /** Title — title02H6 (P22 Mackinac) */
  title: string;
  /** Text of the top BadgeLabel — Dart `tagText` */
  tagText: string;
  details1: string;
  details2: string;
  /** When false hides the radio and disables selection — Dart `isSelectable` (default true) */
  isSelectable?: boolean;
  /** free → badge main · acquired → green · premium → premium · premiumPlus → premiumPlus */
  variant: SelectorRadioButtonLabelVariant;
  onClick?: () => void;
}

export interface DotsSettingItemRadioBtnProps {
  isSelected: boolean;
  /** Main label (left) — Dart `leadingLabel` */
  leadingLabel: string;
  /** Secondary label (right) — Dart `trailingLabel` */
  trailingLabel?: string;
  onClick?: () => void;
}

function detailIcon(name: string, size: number) {
  return <DotsIcon name={name} size={size} color="var(--text-tertiary)" />;
}

// DotsSelectorRadioButton — card with title + 2 icon/detail rows + radio
export function DotsSelectorRadioButton(props: DotsSelectorRadioButtonProps) {
  const selected = !!props.isSelected;
  return (
    <div className={`ds-sel-card${selected ? ' is-selected' : ''}`} role="radio" aria-checked={selected} tabIndex={0} onClick={props.onClick}>
      <div className="ds-sel-card__body ds-sel-card__body--gap10">
        <div className="ds-sel-card__title">{props.title}</div>
        <div className="ds-sel-card__detail">
          {detailIcon(props.icon1 || 'ic-clock-filled', props.icon1Size || 16) /* Dart: DotsIconData.clockFilled, 16 */}
          {props.details1}
        </div>
        <div className="ds-sel-card__detail">
          {detailIcon(props.icon2 || 'ic-calendar', props.icon2Size || 16) /* Dart: DotsIconData.calendar, 16 */}
          {props.details2}
        </div>
      </div>
      <DotsRadioButton isSelected={selected} size={24} />
    </div>
  );
}

// SelectorRadioButtonLabelVariant → BadgeLabelVariant (getBadgeLabelVariant in Dart)
const BADGE_VARIANT: Record<SelectorRadioButtonLabelVariant, BadgeLabelVariant> = {
  free: 'main',
  acquired: 'green',
  premium: 'premium',
  premiumPlus: 'premiumPlus',
};

// DotsSelectorRadioButtonLabel — card with BadgeLabel + serif title + details
export function DotsSelectorRadioButtonLabel(props: DotsSelectorRadioButtonLabelProps) {
  const selectable = props.isSelectable !== false;
  const selected = !!props.isSelected && selectable;
  const variant: SelectorRadioButtonLabelVariant = BADGE_VARIANT[props.variant] ? props.variant : 'free';
  return (
    <div
      className={`ds-sel-card${selected ? ' is-selected' : ''}`}
      role={selectable ? 'radio' : undefined}
      aria-checked={selectable ? selected : undefined}
      tabIndex={selectable ? 0 : undefined}
      onClick={selectable ? props.onClick : undefined}
    >
      <div className="ds-sel-card__body ds-sel-card__body--gap8">
        <div>
          <BadgeLabel content={props.tagText} variant={BADGE_VARIANT[variant]} />
        </div>
        <div>
          <div className="ds-sel-card__title-serif">{props.title}</div>
          <div className="ds-sel-card__detail1">{props.details1}</div>
        </div>
        <div className="ds-sel-card__detail2">{props.details2}</div>
      </div>
      {selectable ? <DotsRadioButton isSelected={selected} size={24} /> : null}
    </div>
  );
}

// DotsSettingItemRadioBtn — row: radio 22 + leading + trailing
export function DotsSettingItemRadioBtn(props: DotsSettingItemRadioBtnProps) {
  const selected = !!props.isSelected;
  return (
    <div className="ds-setting-radio" role="radio" aria-checked={selected} tabIndex={0} onClick={props.onClick}>
      <DotsRadioButton isSelected={selected} size={22} />
      <span className="ds-setting-radio__leading">{props.leadingLabel}</span>
      {props.trailingLabel != null ? <span className="ds-setting-radio__trailing">{props.trailingLabel}</span> : null}
    </div>
  );
}
