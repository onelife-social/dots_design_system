// DotsPlanSelector — port of lib/src/components/premium/dots_plan_selector.dart (Dart = source of truth).

/** Dart enum DotsPlanSelectorVariant */
export type DotsPlanSelectorVariant = 'basic' | 'premium' | 'premiumPlus';

export interface DotsPlanSelectorProps {
  /** Plan title (bodyDefaultBold) */
  title: string;
  /** Optional description under the title (labelSmallRegular) */
  description?: string;
  /** Visual variant — Dart enum DotsPlanSelectorVariant (default 'basic') */
  variant: DotsPlanSelectorVariant;
  /** Selected (with enabled, paints the plan's webp background) */
  selected: boolean;
  /** Dart `enabled` (default true). Disabled: textQuarternary text and no background */
  enabled?: boolean;
  /** Dart `onTap` */
  onClick?: () => void;
  className?: string;
}

// DotsPlanSelectorVariant (Dart) → class suffix
const VARIANTS: Record<DotsPlanSelectorVariant, string> = { basic: 'basic', premium: 'premium', premiumPlus: 'premium-plus' };

export function DotsPlanSelector(props: DotsPlanSelectorProps) {
  const variant = (props.variant && VARIANTS[props.variant]) || VARIANTS.basic;
  const enabled = props.enabled !== false; // Dart: default true
  const selected = !!props.selected;
  let cls = 'ds-plan-selector';
  // webp background (bgBasic/bgPremium/bgPremiumPlus) only if selected && enabled (Dart: Ink.image)
  if (selected && enabled) cls += ` ds-plan-selector--selected ds-plan-selector--${variant}`;
  if (!enabled) cls += ' is-disabled';
  if (props.className) cls += ` ${props.className}`;
  return (
    <button type="button" className={cls} disabled={!enabled} onClick={enabled ? props.onClick : undefined}>
      <span className="ds-plan-selector__title">{props.title}</span>
      {props.description ? <span className="ds-plan-selector__desc">{props.description}</span> : null}
    </button>
  );
}
