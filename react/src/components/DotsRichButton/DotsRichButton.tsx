// DotsRichButton — port of lib/src/components/buttons/dots_rich_button/dots_rich_button.dart (Dart = source of truth).
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface DotsRichButtonProps {
  /** Size — Dart enum DotsRichButtonSize (large 358×75 r100 · medium 358×60 r32 · small 248×60 r32) */
  size?: 'large' | 'medium' | 'small';
  /** Center text size — Dart enum DotsRichButtonTextSize */
  textSize?: 'large' | 'medium';
  /** Leading DotsIcon name (e.g. 'ic-pics') — Dart `icon` */
  icon?: string;
  /** CSS color of the leading icon — Dart `iconColor` (default textSecondary) */
  iconColor?: string;
  /** Leading 32×32 image URL (takes precedence over `icon`) — Dart `image` */
  image?: string;
  /** Main text — Dart `content` */
  content: string;
  /** Secondary text under the main one — Dart `details` */
  details?: string;
  /** Trailing text; without it a chevron is shown. Also enables the red dot — Dart `trailingText` */
  trailingText?: string;
  /** Tap — Dart `onTap` */
  onClick?: () => void;
}

export function DotsRichButton(props: DotsRichButtonProps) {
  const size = props.size === 'large' || props.size === 'small' ? props.size : 'medium';
  const textSize = props.textSize === 'large' ? 'large' : 'medium'; // DotsRichButtonTextSize
  const hasTrailing = props.trailingText != null && props.trailingText !== '';

  // Leading: image > icon > nothing (as in Dart)
  const lead = props.image ? (
    <img className="ds-rich-btn__img" src={props.image} alt="" />
  ) : props.icon ? (
    <DotsIcon name={props.icon} size={24} color={props.iconColor ?? 'var(--text-secondary)'} /> // Dart: default textSecondary
  ) : null;

  return (
    <button type="button" className={`ds-rich-btn ds-rich-btn--${size}`} onClick={props.onClick}>
      {lead}
      <span className="ds-rich-btn__mid">
        <span className={`ds-rich-btn__content ds-rich-btn__content--${textSize}`}>
          {props.content}
          {/* Dart: red dot when there is trailingText */}
          {hasTrailing ? <span className="ds-rich-btn__reddot" /> : null}
        </span>
        {props.details ? <span className="ds-rich-btn__details">{props.details}</span> : null}
      </span>
      {hasTrailing ? (
        <span className="ds-rich-btn__trail">{props.trailingText}</span>
      ) : (
        <DotsIcon name="ic-chevron-right" size={20} color="var(--text-tertiary)" />
      )}
    </button>
  );
}
