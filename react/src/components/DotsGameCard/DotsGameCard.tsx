// DotsGameCard — port of lib/src/components/cards/game_card/game_card.dart (Dart = source of truth).
import type { ReactNode } from 'react';
import { useState } from 'react';
import { BadgeLabel } from '../BadgeLabel/BadgeLabel';
import type { BadgeLabelVariant } from '../BadgeLabel/BadgeLabel';
import { DotsMainButton } from '../DotsMainButton/DotsMainButton';

/** Dart enum DotsGameCardStatus — provisioning state of the game the card represents */
export type DotsGameCardStatus = 'processing' | 'error' | 'active';

export interface DotsGameCardProps {
  /** Which of the three variants to render — Dart enum DotsGameCardStatus. Picks the badge variant and the action block */
  status: DotsGameCardStatus;
  /** Game artwork URL, drawn inside a 138×100 box without cropping (BoxFit.contain). Without it, or if it fails to load, a gradient placeholder is painted */
  imageSrc?: string;
  /** Own node instead of `imageSrc` — mirror of the Dart `image` slot (Widget). Takes precedence when truthy */
  image?: ReactNode;
  /** Alt text of the `imageSrc` image (default '': decorative, the title names the game) */
  imageAlt?: string;
  /** Badge copy — `PREPARANDO` / `NO DISPONIBLE` / `ACTIVO`. The variant is chosen by `status` — Dart `badgeText` */
  badgeText: string;
  /** Mackinac 23/500, centered — Dart `title` */
  title: string;
  /** Inter 14/400 textTertiary, centered — Dart `description` */
  description: string;
  /** Button copy, or the progress label while `status` is 'processing' — Dart `actionText` */
  actionText: string;
  /** Dart `onActionTap`. IGNORED while `status` is 'processing': that variant reports progress and takes no tap */
  onActionClick?: () => void;
  /**
   * Leading indicator of the 'processing' row — Dart `progressIndicator`. The package ships no
   * indeterminate spinner (DotsSpinner is determinate), so the host passes its own. Omitted → a 16px
   * ring is painted as design placeholder; `null` → no indicator at all.
   */
  progressIndicator?: ReactNode;
  className?: string;
}

// Dart _badgeVariant: one BadgeLabel variant per status
const BADGE_VARIANT: Record<DotsGameCardStatus, BadgeLabelVariant> = {
  processing: 'secondary',
  error: 'warningMaterial',
  active: 'greenMaterial',
};

export function DotsGameCard(props: DotsGameCardProps) {
  // Dart: status is required; an unknown value from an untyped caller (the design bundle) reads as active
  const status: DotsGameCardStatus = props.status && BADGE_VARIANT[props.status] ? props.status : 'active';
  // Keep the failed URL (not a boolean) so a new `imageSrc` is attempted after a broken one
  const [failedSrc, setFailedSrc] = useState<string | null>(null);
  const imgError = !!props.imageSrc && failedSrc === props.imageSrc;

  // Truthy check (like the `badge` / `icon` slots of other ports): undefined, null and `false` all
  // fall back to imageSrc, so both `image={cond ? <X/> : null}` and `image={cond && <X/>}` work.
  let art: ReactNode;
  if (props.image) {
    art = props.image;
  } else if (props.imageSrc && !imgError) {
    art = (
      <img
        className="ds-game-card__img"
        src={props.imageSrc}
        alt={props.imageAlt ?? ''}
        onError={() => setFailedSrc(props.imageSrc ?? null)}
      />
    );
  } else {
    art = <div className="ds-game-card__img ds-game-card__img--ph" />;
  }

  let action: ReactNode;
  if (status !== 'processing') {
    // Dart: DotsMainButton(content, size: large, expand: false, onTap)
    action = <DotsMainButton label={props.actionText} size="large" expand={false} onClick={props.onActionClick} />;
  } else {
    // Dart: while processing the card informs and takes no tap — onActionTap is ignored.
    // Only the default ring is decorative; a host-provided indicator keeps its own semantics.
    const indicator =
      props.progressIndicator === undefined ? <span className="ds-game-card__spinner" aria-hidden /> : props.progressIndicator;
    action = (
      <div className="ds-game-card__processing">
        {indicator ? <span className="ds-game-card__progress">{indicator}</span> : null}
        <span className="ds-game-card__progress-text">{props.actionText}</span>
      </div>
    );
  }

  return (
    <div className={`ds-game-card${props.className ? ` ${props.className}` : ''}`}>
      <div className="ds-game-card__art">{art}</div>
      <div className="ds-game-card__content">
        <div className="ds-game-card__badge">
          <BadgeLabel content={props.badgeText} size="medium" variant={BADGE_VARIANT[status]} />
        </div>
        <div className="ds-game-card__title">{props.title ?? ''}</div>
        <div className="ds-game-card__desc">{props.description ?? ''}</div>
      </div>
      <div className="ds-game-card__action">{action}</div>
    </div>
  );
}
