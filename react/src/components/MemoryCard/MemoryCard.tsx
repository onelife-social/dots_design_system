// MemoryCard — port of lib/src/components/cards/memory_card/memory_card.dart (Dart = source of truth).

/** Dart enum MemoryCardVariant */
export type MemoryCardVariant = 'memory' | 'recap';

export interface MemoryCardProps {
  /** Photo URL (Dart image: Widget). Without it a gradient placeholder is painted */
  imageSrc?: string;
  /** Group name under the card */
  groupName: string;
  /** Border variant — Dart enum MemoryCardVariant (default 'memory') */
  variant?: MemoryCardVariant;
  /** Tap on the card (Dart onTap) */
  onClick?: () => void;
  className?: string;
}

export function MemoryCard(props: MemoryCardProps) {
  const variant: MemoryCardVariant = props.variant === 'recap' ? 'recap' : 'memory'; // MemoryCardVariant
  return (
    <div
      className={`ds-memory-card${props.className ? ` ${props.className}` : ''}`}
      onClick={props.onClick}
      role={props.onClick ? 'button' : undefined}
    >
      {/* _MemoryCardBorder 67.53×87.39 r18 w1.45 (memory: linear green · recap: sweep) */}
      <div className={`ds-memory-card__border ds-memory-card__border--${variant}`}>
        <div className="ds-memory-card__inner">
          {/* _Card 60.39×80 r15 — image or gradient placeholder */}
          <div
            className={`ds-memory-card__img${props.imageSrc ? '' : ' ds-memory-card__img--ph'}`}
            style={props.imageSrc ? { backgroundImage: `url("${props.imageSrc}")` } : undefined}
          />
        </div>
      </div>
      <div className="ds-memory-card__name">{props.groupName ?? ''}</div>
    </div>
  );
}
