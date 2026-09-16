// MilestoneCard — port of lib/src/components/milestones/milestone_card.dart
// (+ milestone_badge_type.dart / milestone_badge_info.dart) (Dart = source of truth).
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsIconButton } from '../DotsIconButton/DotsIconButton';
import { activateOnKey } from '../../internal/pressable';

/** Mirror of the Dart enum MilestoneBadgeType */
export type MilestoneBadgeType = 'video' | 'description' | 'audio';

export interface MilestoneCardProps {
  /** Width in px — Dart `width`. > 150 ⇒ big (r32); otherwise small (r24). Height = 4/3 of the width. Default 170 */
  width?: number;
  /** Photo URL — Dart `imageProvider`. Without src the placeholder (defaultImage) is painted */
  src?: string;
  /** Title centered over the top blur — Dart `title` */
  title?: string;
  /** Limit the title to 1 line with ellipsis — Dart `limitTitle` (default false) */
  limitTitle?: boolean;
  /** Date under the title — Dart `date` */
  date?: string;
  /** Dart `onTap` (tap on the photo/card) */
  onClick?: () => void;
  /** Accessible name of the card action (`onClick`). Defaults to `title`; set it when the card has no title */
  ariaLabel?: string;
  /** Show the badge-milestone-1.svg badge top-right — Dart `showBadge` (default false) */
  showBadge?: boolean;
  /** Show the edit button (DotsIconButton pencil) — Dart `showEdit` (default false) */
  showEdit?: boolean;
  /** Dart `onTapEdit` */
  onClickEdit?: () => void;
  /** Selection mark (Flutter uses it for the list auto-scroll) */
  isSelected?: boolean;
  /** Content badges, max 3 — Dart `badgeTypes` (default []) */
  badgeTypes?: MilestoneBadgeType[];
  /** Dart `onBadgesTap` */
  onBadgesClick?: () => void;
  /** Accessible name of the badge group (icon-only control); applied only with `onBadgesClick` */
  badgesLabel?: string;
  className?: string;
}

// MilestoneBadgeType (Dart): icon + color. Colors child010/couple001/friends005 do not exist
// as CSS tokens (same hex in light and dark in Dart) — documented exception.
const BADGE_TYPES: Record<MilestoneBadgeType, { icon: string; color: string }> = {
  video: { icon: 'ic-video', color: '#4FAEF8' /* child010 */ },
  audio: { icon: 'ic-mic', color: '#F43C51' /* couple001 */ },
  description: { icon: 'ic-pages', color: '#F7954A' /* friends005 */ },
};

// BadgeIconGroup (badges/badge_icon_group.dart): 63×70, [0] medium(36/20) left0 bottom0,
// [1] small(28/16) left 4|31 bottom 42|31 depending on n, [2] small left35 bottom26
function badgeGroup(types: MilestoneBadgeType[], onClick?: () => void, label?: string) {
  const list = types.slice(0, 3).filter((t) => BADGE_TYPES[t]);
  if (!list.length) return null;
  const pos = [
    { left: 0, bottom: 0, size: 36, iconSize: 20 },
    list.length === 3 ? { left: 4, bottom: 42, size: 28, iconSize: 16 } : { left: 31, bottom: 31, size: 28, iconSize: 16 },
    { left: 35, bottom: 26, size: 28, iconSize: 16 },
  ];
  // Own control (role=button) nested in the card; it sits above the card's hit overlay (z-index),
  // so its clicks and keys are its own and never reach the card action.
  return (
    <span
      className="ds-milestone-card__badges"
      role={onClick ? 'button' : undefined}
      tabIndex={onClick ? 0 : undefined}
      aria-label={onClick ? label : undefined}
      onClick={onClick}
      onKeyDown={onClick ? activateOnKey(onClick) : undefined}
    >
      {list.map((t, i) => {
        const b = BADGE_TYPES[t];
        const p = pos[i];
        return (
          <span
            key={t + i}
            className="ds-milestone-card__badge-icon"
            style={{ left: `${p.left}px`, bottom: `${p.bottom}px`, width: `${p.size}px`, height: `${p.size}px` }}
          >
            <DotsIcon name={b.icon} size={p.iconSize} color={b.color} />
          </span>
        );
      })}
    </span>
  );
}

export function MilestoneCard(props: MilestoneCardProps) {
  const width = props.width ?? 170;
  const isBig = width > 150; // Dart: squircle32 / squircle24
  const hasTitle = props.title != null && props.title !== '';

  const cls =
    `ds-milestone-card ds-milestone-card--${isBig ? 'big' : 'small'}` +
    (props.isSelected ? ' is-selected' : '') +
    (props.className ? ` ${props.className}` : '');

  return (
    <span className={cls} style={{ width: `${width}px` }}>
      {/* Card action (Dart onTap): a transparent native button that covers the card, rendered as a
          sibling of the edit button and the badge group — not as a role=button ancestor, which would
          make them presentational. Both sit above it (z-index) and get their own clicks. */}
      {props.onClick ? (
        <button type="button" className="ds-milestone-card__hit" aria-label={props.ariaLabel ?? props.title} onClick={props.onClick} />
      ) : null}
      {props.src ? (
        <img className="ds-milestone-card__img" src={props.src} alt={props.title || ''} />
      ) : (
        <span className="ds-milestone-card__img ds-milestone-card__img--default" />
      )}
      {/* _CardWithBlur: DotsLinearGradientBlur sigma 15, tint black 35%, faded up to 108px */}
      {hasTitle ? <span className="ds-milestone-card__top-blur" aria-hidden /> : null}
      {hasTitle ? (
        <span className="ds-milestone-card__title-box">
          <span className={`ds-milestone-card__title${props.limitTitle ? ' is-limited' : ''}`}>{props.title}</span>
          {props.date ? <span className="ds-milestone-card__date">{props.date}</span> : null}
        </span>
      ) : null}
      {/* _CardBadge: badge-milestone-1.svg (data URI in the CSS), top 5 right 5 */}
      {props.showBadge ? <span className="ds-milestone-card__badge1" aria-hidden /> : null}
      {/* _BtnEdit: DotsIconButton pencil (size default large), bgBtnImage; the wrapper sits above the card's hit */}
      {props.showEdit ? (
        <span className="ds-milestone-card__edit">
          <DotsIconButton icon="ic-pencil" backgroundColor="var(--bg-btn-image)" onClick={props.onClickEdit} />
        </span>
      ) : null}
      {props.badgeTypes && props.badgeTypes.length ? badgeGroup(props.badgeTypes, props.onBadgesClick, props.badgesLabel) : null}
    </span>
  );
}
/** Icon + color catalog per type (mirror of MilestoneBadgeType) */
MilestoneCard.badgeTypes = BADGE_TYPES;
