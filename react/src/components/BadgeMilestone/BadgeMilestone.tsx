// BadgeMilestone — port of lib/src/components/badges/badge_milestone/ (Dart = source of truth).

/** Dart enum BadgeMilestoneVariant */
export type BadgeMilestoneVariant = 'main' | 'ghost';

export interface BadgeMilestoneProps {
  /** Milestone text — Dart `content` */
  content: string;
  /** Variant — Dart enum BadgeMilestoneVariant. main: 1px bgSecondaryBtn border, v-pad 9 · ghost: no border, v-pad 6 */
  variant?: BadgeMilestoneVariant;
}

const VARIANTS: Record<BadgeMilestoneVariant, true> = { main: true, ghost: true };

export function BadgeMilestone(props: BadgeMilestoneProps) {
  const variant: BadgeMilestoneVariant = props.variant && VARIANTS[props.variant] ? props.variant : 'main'; // Dart: default main
  return (
    <span className={`ds-badge-milestone ds-badge-milestone--${variant}`}>
      <span className="ds-badge-milestone__text">{props.content}</span>
    </span>
  );
}
