// PageControl — port of lib/src/components/dot_book/page_control.dart (+ page_control_theme.dart).
import type { CSSProperties } from 'react';

export interface PageControlProps {
  /** Total number of dots — Dart `count` */
  count: number;
  /** Active index, clamped to [0, count-1] — Dart `activeIndex`. Default: 0 */
  activeIndex?: number;
  /** Variant — Dart enum PageControlVariant. Default: 'main' */
  variant?: 'main' | 'background';
  /** Color of inactive dots — Dart `dotColor`. Default: labelSecondary */
  dotColor?: string;
  /** Color of the active dot — Dart `activeColor`. Default: labelPrimary (main) / labelActive (background) */
  activeColor?: string;
  className?: string;
}

// getPageControlTheme (page_control_theme.dart)
const THEMES = {
  main: { dotSize: 8, dotSpacing: 8, activeColor: 'var(--label-primary)', dotColor: 'var(--label-secondary)', activeBackgroundColor: undefined },
  background: { dotSize: 6, dotSpacing: 12, activeColor: 'var(--label-active)', dotColor: 'var(--label-secondary)', activeBackgroundColor: 'var(--bg-active)' },
} as const;

// _getBorderRadius (Dart): continuous pill from the first dot to the active one
function cellRadius(i: number, activeIndex: number, radius: number) {
  const r = `${radius}px`;
  if (i === 0) return i === activeIndex ? r : `${r} 0 0 ${r}`;
  if (i === activeIndex) return `0 ${r} ${r} 0`;
  return '0';
}

export function PageControl({ count = 0, activeIndex: rawIndex = 0, variant: rawVariant, dotColor, activeColor, className }: PageControlProps) {
  const variant = rawVariant === 'background' ? 'background' : 'main';
  const t = THEMES[variant];
  const isBg = variant === 'background';
  // activeIndex clamp as in the Dart constructor
  const activeIndex = count <= 0 || rawIndex < 0 ? 0 : Math.min(rawIndex, count - 1);
  const inactive = dotColor ?? t.dotColor;
  const active = activeColor ?? t.activeColor;

  const dots = [];
  for (let i = 0; i < count; i++) {
    // background: every dot up to activeIndex is active; main: only the active one
    const isActive = isBg ? i <= activeIndex : i === activeIndex;
    const cellStyle: CSSProperties = isBg ? { padding: t.dotSpacing / 2 } : { padding: `0 ${t.dotSpacing / 2}px` };
    if (isBg && isActive) {
      cellStyle.background = t.activeBackgroundColor;
      cellStyle.borderRadius = cellRadius(i, activeIndex, (t.dotSize + t.dotSpacing) / 2);
    }
    dots.push(
      <span key={i} className="ds-page-control__cell" style={cellStyle}>
        <span className="ds-page-control__dot" style={{ width: t.dotSize, height: t.dotSize, background: isActive ? active : inactive }} />
      </span>,
    );
  }

  return (
    <span
      className={`ds-page-control ds-page-control--${variant}${className ? ` ${className}` : ''}`}
      // count <= 0: reserve the dot height (+ spacing on background), like the Dart SizedBox
      style={count <= 0 ? { height: t.dotSize + (isBg ? t.dotSpacing : 0) } : undefined}
      role="tablist"
    >
      {dots}
    </span>
  );
}
