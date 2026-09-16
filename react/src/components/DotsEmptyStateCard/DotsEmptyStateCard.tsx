// DotsEmptyStateCard — port of lib/src/components/empty_state/empty_state_card.dart (Dart = source of truth).
// The Dart width (82% of the screen width) becomes width:100% — size it with the parent container.
import type { CSSProperties, ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Dart enum DotsEmptyStateCardVariant */
export type DotsEmptyStateCardVariant = 'image' | 'icon';

export interface DotsEmptyStateCardProps {
  /** Variant — Dart enum DotsEmptyStateCardVariant */
  variant: DotsEmptyStateCardVariant;
  /** Image URL (variant image) — Dart `imageProvider` */
  image?: string;
  /** Variant icon: DotsIcon name (48px textQuarternary) or a prebuilt node — Dart `icon` (a DotsIcon) */
  icon?: string | ReactNode;
  /** Title, title02H5 (P22 Mackinac 20/500) — Dart `title` */
  title: string;
  /** Description, bodyDefaultRegular textQuarternary — Dart `description` */
  description: string;
  /** CSS color of the title — Dart `titleColor` */
  titleColor?: string;
  /** CSS color of the description — Dart `descriptionColor` */
  descriptionColor?: string;
  /** Optional button (usually a DotsMainButton) — Dart `button` */
  button?: ReactNode;
  /** Extra space (px) after the image — Dart `extraSpaceAfterImage` */
  extraSpaceAfterImage?: number;
  /** Image width (px) — Dart `imageWidth` */
  imageWidth?: number;
  /** Rich description rendered instead of `description` (kept as aria-label) — Dart `descriptionSpans` */
  descriptionSpans?: ReactNode;
  className?: string;
}

export function DotsEmptyStateCard(props: DotsEmptyStateCardProps) {
  const variant: DotsEmptyStateCardVariant = props.variant === 'image' ? 'image' : 'icon';
  const extra = props.extraSpaceAfterImage ?? 0;
  // Gap media→title: image 4 (+extraSpaceAfterImage), icon 16
  const gap = variant === 'image' ? 4 + extra : 16;

  let media: ReactNode = null;
  if (variant === 'image' && props.image) {
    media = (
      <img
        className="ds-empty-card__image"
        src={props.image}
        alt=""
        style={props.imageWidth != null ? { width: `${props.imageWidth}px` } : undefined}
      />
    );
  } else if (variant === 'icon' && props.icon) {
    // Dart receives a DotsIcon widget; here: icon name (48px textQuarternary) or a prebuilt node
    media = typeof props.icon === 'string' ? <DotsIcon name={props.icon} size={48} color="var(--text-quarternary)" /> : props.icon;
  }

  const descStyle: CSSProperties | undefined = props.descriptionColor ? { color: props.descriptionColor } : undefined;
  const desc =
    props.descriptionSpans != null ? (
      // descriptionSpans replaces the text; description stays as the accessible label
      <p className="ds-empty-card__desc" style={descStyle} aria-label={props.description}>
        {props.descriptionSpans}
      </p>
    ) : (
      <p className="ds-empty-card__desc" style={descStyle}>
        {props.description}
      </p>
    );

  return (
    <div className={`ds-empty-card${props.className ? ` ${props.className}` : ''}`}>
      {media ? (
        <div className="ds-empty-card__media" style={{ marginBottom: `${gap}px` }}>
          {media}
        </div>
      ) : null}
      <p className="ds-empty-card__title" style={props.titleColor ? { color: props.titleColor } : undefined}>
        {props.title}
      </p>
      {desc}
      {props.button ? <div className="ds-empty-card__button">{props.button}</div> : null}
    </div>
  );
}
