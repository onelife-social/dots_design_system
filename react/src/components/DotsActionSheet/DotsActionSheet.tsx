// DotsActionSheet — port of lib/src/components/action_sheet/ (Dart = source of truth).
// Single API with `variant`: standard | list | input | radioButtons | settings | search | spotlight.
// Dart mapping: standard→DotsActionSheetStandard, list→DotsActionSheetList, input→DotsActionSheetInput,
// radioButtons→DotsActionSheetRadioButtons, settings→DotsActionSheetSettings, search→DotsActionSheetSearch,
// spotlight→DotsActionSheetSpotlight. Rendered as a static mountable sheet (relative position, no scrim).
import type { CSSProperties, ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsMainButton } from '../DotsMainButton/DotsMainButton';
import { DotsTextField } from '../DotsTextField/DotsTextField';

export type DotsActionSheetVariant = 'standard' | 'list' | 'input' | 'radioButtons' | 'settings' | 'search' | 'spotlight';

export interface DotsActionSheetListItemProps {
  /** Real Dots icon name (20px on a 40×40 r12 box). Dart: DotsListItem.icon */
  icon?: string;
  /** Alternative node for the icon box (e.g. an image). */
  iconNode?: ReactNode;
  /** Text (bodyLargeBold). Dart: text */
  label: string;
  /** 14px lock after the text. Dart: showLockIcon */
  showLockIcon?: boolean;
  /** Dart: onTap */
  onClick?: () => void;
}
export interface DotsActionSheetSelectedItem {
  id: string | number;
  name: string;
}
export interface DotsActionSheetRadioOption {
  id?: string | number;
  /** Card title (bodyDefaultBold). Dart: RadioCardIcons */
  title: string;
  /** 16px icon next to the title. */
  titleIcon?: string;
  /** Detail lines (13px textTertiary), optional 16px icon. */
  details?: Array<{ icon?: string; label: string }>;
  /** Right control: radio (default) or toggle. */
  control?: 'radio' | 'toggle';
  selected?: boolean;
}
export interface DotsActionSheetSystemButton {
  icon?: string;
  label: string;
  /** Text/icon in labelDestructive. Dart: DotsSystemButton destructive */
  destructive?: boolean;
  disabled?: boolean;
  onTap?: () => void;
}

export interface DotsActionSheetProps {
  /** Variant. Default 'standard'. */
  variant?: DotsActionSheetVariant;
  /** 36×4 grabber. Default: true on every variant but 'search'. */
  showGrabber?: boolean;
  /** DotsCloseButton medium softContrast top-right. Default false. */
  showCloseButton?: boolean;
  /** Tap on the close button. Dart: onClose / onCloseButtonTap */
  onClose?: () => void;
  /** Title. standard/radioButtons: title02H5 (20 serif); others: title02H6 (18 serif); settings: titleH5 (20/700 Inter). */
  title?: string;
  /** Secondary text under the title (per variant: description/subtitle in Dart). */
  description?: string;
  /** Free content: standard → central body; list/search → replaces `items`. */
  children?: ReactNode;
  /** Primary button (DotsMainButton main mainAction; search: large/h44). */
  primaryLabel?: string;
  onPrimaryTap?: () => void;
  /** Dart: enabled / isMainButtonAvailable / enableMainButton. Default true. */
  primaryEnabled?: boolean;
  /** Secondary button (DotsMainButton secondary). Dart: secondaryButton */
  secondaryLabel?: string;
  onSecondaryTap?: () => void;
  /** Custom nodes replacing primaryLabel/secondaryLabel. */
  primaryButton?: ReactNode;
  secondaryButton?: ReactNode;
  /** Dart: DotsActionSheetButtonPositioning (default 'row'). */
  buttonPositioning?: 'row' | 'column';
  // ── standard ──
  /** Top node (icon/image). Dart: topWidget */
  topContent?: ReactNode;
  /** Full-width bottom node. Dart: bottomWidget */
  bottomContent?: ReactNode;
  /** 0..1 → progress bar. Dart: stepProgress */
  stepProgress?: number;
  /** Spacing 20 (true) or 16 (false). Dart: bigAspectRatio (default true) */
  bigAspectRatio?: boolean;
  // ── list ──
  /** Dart: ActionSheetListVariant ('main' default | 'ghost'). */
  listVariant?: 'main' | 'ghost';
  /** Back arrow left of the title. Dart: onBackButtonTap */
  showBackButton?: boolean;
  onBack?: () => void;
  /** Small button top-right. Dart: labelButtonText/onLabelButtonTap */
  labelButtonText?: string;
  onLabelButtonTap?: () => void;
  labelButtonEnabled?: boolean;
  /** Search field (DotsTextField pill). Dart: hintInputText */
  searchHint?: string;
  searchValue?: string;
  /** Dart: onInputChanged / onChanged */
  onSearchChanged?: (text: string) => void;
  /** Field icon. Dart: inputIcon (default 'ic-search') */
  searchIcon?: string;
  /** Selected chips. Dart: selectedItemNames */
  selectedItems?: DotsActionSheetSelectedItem[];
  /** Dart: onBtnChipTap */
  onChipTap?: (id: string | number) => void;
  /** Dart: listTitle */
  listTitle?: string;
  /** DotsActionSheet.ListItem rows. Dart: listItems. Also in 'search'. */
  items?: DotsActionSheetListItemProps[];
  /** Ghost footer icon. Dart: mainButtonIcon (default 'ic-add') */
  mainButtonIcon?: string;
  // ── input ──
  /** Dart: ActionSheetInputVariant (covered: 'main' default, 'colors'). */
  inputVariant?: 'main' | 'colors';
  /** XL 52px icon above the field. Dart: iconData */
  icon?: string;
  iconNode?: ReactNode;
  /** CSS color of the XL icon. */
  iconColor?: string;
  /** Dart: inputHintText */
  inputHint?: string;
  inputValue?: string;
  onInputChanged?: (text: string) => void;
  maxTextLength?: number;
  /** Color circles (variant colors). Dart: DotsColorOptionsRow */
  colors?: string[];
  selectedColorIndex?: number;
  onColorSelect?: (index: number) => void;
  // ── radioButtons ──
  /** RadioCardIcons cards. Dart: items */
  options?: DotsActionSheetRadioOption[];
  onSelect?: (id: string | number) => void;
  // ── settings / spotlight ──
  /** Image URL: settings → 100px circular avatar; spotlight → r24 image. */
  image?: string;
  /** spotlight: 13px textTertiary label under the title. Dart: label */
  label?: string;
  /** settings: DotsSystemButton rows. Dart: buttons */
  buttons?: DotsActionSheetSystemButton[];
  className?: string;
  style?: CSSProperties;
}

// TODO(port): DotsCloseButton and DotsRadioButton are still legacy → simple fallbacks here until they are ported.
const CloseButton = ({ onClose, top }: { onClose?: () => void; top: number | null }) => (
  <span className="ds-action-sheet__close" style={top ? { top } : undefined}>
    <button type="button" className="ds-action-sheet__close-fallback" aria-label="Cerrar" onClick={onClose}>
      ×
    </button>
  </span>
);
const RadioControl = ({ selected }: { selected: boolean }) => <span className={`ds-action-sheet__radio-fallback${selected ? ' is-on' : ''}`} />;

// ── DotsActionSheet.ListItem — dots_list_item.dart ─────────────────────────
export function DotsActionSheetListItem(p: DotsActionSheetListItemProps) {
  return (
    <div className="ds-action-sheet__list-item" role="button" tabIndex={0} onClick={p.onClick}>
      <span className="ds-action-sheet__list-item-icon">{p.iconNode ?? (p.icon ? <DotsIcon name={p.icon} size={20} color="var(--text-tertiary)" /> : null)}</span>
      <span className="ds-action-sheet__list-item-label">
        {p.label}
        {p.showLockIcon ? <DotsIcon name="ic-lock" size={14} color="var(--text-secondary)" className="ds-action-sheet__list-item-lock" /> : null}
      </span>
    </div>
  );
}

// Standard footer (DotsActionSheetStandardButtons): row (secondary | primary) or column
function FooterButtons({ props, size }: { props: DotsActionSheetProps; size?: 'mainAction' | 'large' }) {
  const primary =
    props.primaryButton ??
    (props.primaryLabel != null ? (
      <DotsMainButton label={props.primaryLabel} variant="main" size={size ?? 'mainAction'} enabled={props.primaryEnabled !== false} onClick={props.onPrimaryTap} />
    ) : null);
  const secondary =
    props.secondaryButton ??
    (props.secondaryLabel != null ? <DotsMainButton label={props.secondaryLabel} variant="secondary" size={size ?? 'mainAction'} onClick={props.onSecondaryTap} /> : null);
  if (!primary && !secondary) return null;
  const column = props.buttonPositioning === 'column';
  return (
    <div className={`ds-action-sheet__buttons${column ? ' ds-action-sheet__buttons--column' : ''}`}>
      {column ? primary : secondary}
      {column ? secondary : primary}
    </div>
  );
}

const Title = ({ title, cls }: { title?: string; cls: string }) => (title != null ? <p className={cls}>{title}</p> : null);

function renderStandard(props: DotsActionSheetProps) {
  // DotsActionSheetStandardContent: grabber → topWidget → title (title02H5) → description → bottomWidget → stepProgress → buttons
  const spacing = props.bigAspectRatio === false ? 16 : 20; // Dart: bigAspectRatio default true
  const gap = { marginTop: spacing };
  return (
    <>
      {props.topContent ? <div className="ds-action-sheet__pad16" style={gap}>{props.topContent}</div> : null}
      <div className="ds-action-sheet__pad16" style={gap}>
        <Title title={props.title} cls="ds-action-sheet__title-h5" />
        {props.description ? <p className="ds-action-sheet__description">{props.description}</p> : null}
      </div>
      {props.children ? <div className="ds-action-sheet__pad16" style={gap}>{props.children}</div> : null}
      {props.bottomContent ? <div className="ds-action-sheet__full" style={gap}>{props.bottomContent}</div> : null}
      {props.stepProgress && props.stepProgress > 0 ? (
        <div className="ds-action-sheet__progress" style={gap}>
          <div className="ds-action-sheet__progress-fill" style={{ width: `${Math.min(props.stepProgress, 1) * 100}%` }} />
        </div>
      ) : null}
      <div className="ds-action-sheet__pad16 ds-action-sheet__footer" style={{ marginTop: spacing }}>
        <FooterButtons props={props} />
      </div>
    </>
  );
}

function renderList(props: DotsActionSheetProps) {
  // DotsActionSheetListContent: header (h6 title + back/label btn + search + chips) → DotsListItem list → mainAction button (or icon-label if ghost)
  const isGhost = props.listVariant === 'ghost'; // ActionSheetListVariant
  const chips = props.selectedItems ?? [];
  const items = props.items ?? [];
  return (
    <>
      <div className="ds-action-sheet__list-header">
        {props.showBackButton ? (
          <button type="button" className="ds-action-sheet__back" aria-label="Atrás" onClick={props.onBack}>
            <DotsIcon name="ic-chevron-left" size={20} color="var(--text-primary)" />
          </button>
        ) : null}
        <Title title={props.title} cls="ds-action-sheet__title-h6" />
        {props.labelButtonText != null ? (
          <span className="ds-action-sheet__label-btn">
            <DotsMainButton label={props.labelButtonText} variant="main" size="small" expand={false} enabled={props.labelButtonEnabled !== false} onClick={props.onLabelButtonTap} />
          </span>
        ) : null}
      </div>
      {props.description ? <p className="ds-action-sheet__description ds-action-sheet__description--quarternary">{props.description}</p> : null}
      <div className="ds-action-sheet__pad16 ds-action-sheet__search-row">
        <DotsTextField icon={props.searchIcon ?? 'ic-search'} hintText={props.searchHint} value={props.searchValue} onChanged={props.onSearchChanged} />
      </div>
      {chips.length ? (
        <div className="ds-action-sheet__chips">
          {chips.map((c, i) => (
            <span key={c.id ?? i} className="ds-action-sheet__chip">
              {c.name}
              <span className="ds-action-sheet__chip-close" role="button" onClick={() => props.onChipTap?.(c.id)}>
                <DotsIcon name="ic-cross" size={10} color="currentColor" />
              </span>
            </span>
          ))}
        </div>
      ) : null}
      <div className="ds-action-sheet__list">
        {props.listTitle ? <span className="ds-action-sheet__list-title">{props.listTitle}</span> : null}
        {props.children ?? items.map((it, i) => <DotsActionSheetListItem key={i} {...it} />)}
      </div>
      <div className="ds-action-sheet__pad16 ds-action-sheet__footer">
        {isGhost && props.primaryLabel != null ? (
          <button type="button" className="ds-action-sheet__ghost-btn" onClick={props.onPrimaryTap}>
            <span className="ds-action-sheet__ghost-btn-icon">
              <DotsIcon name={props.mainButtonIcon ?? 'ic-add'} size={14} color="var(--label-highlight)" />
            </span>
            {props.primaryLabel}
          </button>
        ) : (
          <FooterButtons props={props} />
        )}
      </div>
    </>
  );
}

function renderInput(props: DotsActionSheetProps) {
  // DotsActionSheetInput (covered variants: main, colors)
  const colors = props.colors ?? [];
  return (
    <>
      <Title title={props.title} cls="ds-action-sheet__title-h6 ds-action-sheet__mt16" />
      {props.icon || props.iconNode ? (
        <div className="ds-action-sheet__big-icon" style={props.iconColor ? { color: props.iconColor } : undefined}>
          {props.iconNode ?? (props.icon ? <DotsIcon name={props.icon} size={32} color="currentColor" /> : null)}
        </div>
      ) : null}
      <div className="ds-action-sheet__pad16">
        <DotsTextField hintText={props.inputHint} value={props.inputValue} onChanged={props.onInputChanged} alignCenter maxTextLength={props.maxTextLength} />
      </div>
      {props.inputVariant === 'colors' && colors.length ? (
        <div className="ds-action-sheet__colors">
          {colors.map((c, i) => {
            const sel = i === props.selectedColorIndex;
            return (
              <span key={i} className={`ds-action-sheet__color${sel ? ' is-selected' : ''}`} style={{ background: c }} role="button" aria-pressed={sel} onClick={() => props.onColorSelect?.(i)}>
                {sel ? <DotsIcon name="ic-check-thick" size={16} color="var(--label-always-white)" /> : null}
              </span>
            );
          })}
        </div>
      ) : null}
      <div className="ds-action-sheet__pad16 ds-action-sheet__footer ds-action-sheet__mt16">
        <FooterButtons props={props} />
      </div>
    </>
  );
}

function renderRadioButtons(props: DotsActionSheetProps) {
  // DotsActionSheetRadioButtons: h5 title + subtitle + RadioCardIcons + button
  const options = props.options ?? [];
  return (
    <>
      <div className="ds-action-sheet__pad16 ds-action-sheet__radio-head">
        <Title title={props.title} cls="ds-action-sheet__title-h5" />
        {props.description ? <p className="ds-action-sheet__subtitle">{props.description}</p> : null}
      </div>
      <div className="ds-action-sheet__options">
        {options.map((opt, i) => {
          const isToggle = opt.control === 'toggle';
          const selected = !!opt.selected;
          const handle = () => props.onSelect?.(opt.id ?? i);
          return (
            <div key={opt.id ?? i} className={`ds-action-sheet__radio-card${selected && !isToggle ? ' is-selected' : ''}`} onClick={handle}>
              <div className="ds-action-sheet__radio-card-inner">
                <div className="ds-action-sheet__radio-card-col">
                  <div className="ds-action-sheet__radio-line ds-action-sheet__radio-line--title">
                    {opt.titleIcon ? <DotsIcon name={opt.titleIcon} size={16} color="currentColor" /> : null}
                    {opt.title}
                  </div>
                  {(opt.details ?? []).map((d, j) => (
                    <div key={j} className="ds-action-sheet__radio-line">
                      {d.icon ? <DotsIcon name={d.icon} size={16} color="currentColor" /> : null}
                      {d.label}
                    </div>
                  ))}
                </div>
                {isToggle ? (
                  <span className={`ds-action-sheet__toggle${selected ? ' is-on' : ''}`} role="switch" aria-checked={selected}>
                    <span className="ds-action-sheet__toggle-knob" />
                  </span>
                ) : (
                  <RadioControl selected={selected} />
                )}
              </div>
            </div>
          );
        })}
      </div>
      <div className="ds-action-sheet__pad16 ds-action-sheet__footer ds-action-sheet__mt20">
        <FooterButtons props={props} />
      </div>
    </>
  );
}

function renderSettings(props: DotsActionSheetProps) {
  // DotsActionSheetSettings: 100px circular avatar + titleH5 + subtitle + DotsSystemButtons
  return (
    <>
      <div className="ds-action-sheet__avatar" style={props.image ? { backgroundImage: `url(${props.image})` } : undefined} />
      <div className="ds-action-sheet__pad16 ds-action-sheet__mt16">
        <Title title={props.title} cls="ds-action-sheet__settings-title" />
        {props.description ? <p className="ds-action-sheet__settings-sub">{props.description}</p> : null}
      </div>
      <div className="ds-action-sheet__sys-btns">
        {(props.buttons ?? []).map((b, i) => (
          // DotsSystemButton: h44 r16 bgContainerSecondaryOnBackground + blur50
          <button key={i} type="button" className={`ds-action-sheet__sys-btn${b.destructive ? ' is-destructive' : ''}${b.disabled ? ' is-disabled' : ''}`} disabled={!!b.disabled} onClick={b.onTap}>
            {b.icon ? <DotsIcon name={b.icon} size={20} color="currentColor" /> : null}
            {b.label}
          </button>
        ))}
      </div>
    </>
  );
}

function renderSearch(props: DotsActionSheetProps) {
  // DotsActionSheetSearchContent: h6 title (w190) + DotsTextFieldButton + content + fade + h44 button
  return (
    <>
      <Title title={props.title} cls="ds-action-sheet__title-h6 ds-action-sheet__search-title" />
      <div className="ds-action-sheet__pad16 ds-action-sheet__search-row">
        <DotsTextField icon={props.searchIcon ?? 'ic-search'} hintText={props.searchHint} value={props.searchValue} onChanged={props.onSearchChanged} />
      </div>
      <div className="ds-action-sheet__list">{props.children ?? (props.items ?? []).map((it, i) => <DotsActionSheetListItem key={i} {...it} />)}</div>
      {props.primaryLabel != null || props.primaryButton ? (
        <div className="ds-action-sheet__fade-footer">
          {props.primaryButton ?? <DotsMainButton label={props.primaryLabel ?? ''} variant="main" size="large" expand={false} enabled={props.primaryEnabled !== false} onClick={props.onPrimaryTap} />}
        </div>
      ) : null}
    </>
  );
}

function renderSpotlight(props: DotsActionSheetProps) {
  // DotsActionSheetSpotlight: image + h6 title + label + description + button
  return (
    <>
      <div className="ds-action-sheet__pad16 ds-action-sheet__mt16">
        <div className="ds-action-sheet__spot-img" style={props.image ? { backgroundImage: `url(${props.image})` } : undefined} />
      </div>
      <div className="ds-action-sheet__pad16 ds-action-sheet__mt20">
        <Title title={props.title} cls="ds-action-sheet__title-h6" />
        {props.label ? <p className="ds-action-sheet__spot-label">{props.label}</p> : null}
        {props.description ? <p className="ds-action-sheet__spot-desc">{props.description}</p> : null}
      </div>
      <div className="ds-action-sheet__pad16 ds-action-sheet__spot-footer">
        <FooterButtons props={props} />
      </div>
    </>
  );
}

export function DotsActionSheet(props: DotsActionSheetProps) {
  let variant: DotsActionSheetVariant = props.variant ?? 'standard';
  // Grabber: default on every variant but search (Dart: SearchContent does not paint it)
  const showGrabber = props.showGrabber != null ? !!props.showGrabber : variant !== 'search';
  let body: ReactNode;
  let closeTop: number | null = null;
  switch (variant) {
    case 'list': body = renderList(props); break;
    case 'input': body = renderInput(props); break;
    case 'radioButtons': body = renderRadioButtons(props); closeTop = 12; break;
    case 'settings': body = renderSettings(props); break;
    case 'search': body = renderSearch(props); break;
    case 'spotlight': body = renderSpotlight(props); closeTop = 12; break;
    default: variant = 'standard'; body = renderStandard(props);
  }
  return (
    <div className={`ds-action-sheet ds-action-sheet--${variant}${props.className ? ` ${props.className}` : ''}`} style={props.style}>
      {showGrabber ? <div className="ds-action-sheet__grabber" /> : null}
      {body}
      {props.showCloseButton ? <CloseButton onClose={props.onClose} top={closeTop} /> : null}
    </div>
  );
}
DotsActionSheet.ListItem = DotsActionSheetListItem;
