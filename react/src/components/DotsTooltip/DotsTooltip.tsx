// DotsTooltip — port of lib/src/components/tooltip/dots_tooltip.dart (Dart = source of truth).
import type { CSSProperties, ReactNode } from 'react';
import { DotsCloseButton } from '../DotsCloseButton/DotsCloseButton';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Dart enum DotsToolTipTailPosition */
export type DotsToolTipTailPosition =
  | 'topAlignLeadingEdge'
  | 'topAlignLeading'
  | 'topAlignCenter'
  | 'topAlignTrailing'
  | 'topAlignTrailingEdge'
  | 'bottomAlignLeadingEdge'
  | 'bottomAlignLeading'
  | 'bottomAlignCenter'
  | 'bottomAlignTrailing'
  | 'bottomAlignTrailingEdge';

export interface DotsTooltipProps {
  /** Tooltip text (labelDefaultMedium) — Dart `text` */
  text: string;
  /** Tail position — Dart enum DotsToolTipTailPosition. Required. */
  tailPosition: DotsToolTipTailPosition;
  /** DotsIcon name (32px, labelHighlight) — Dart `icon` (DotsIconData) */
  icon?: string;
  /** Custom icon node; wins over `icon` — Dart `iconWidget` */
  iconNode?: ReactNode;
  /** Shows DotsCloseButton small softContrast — Dart `showCloseButton` (default true) */
  showCloseButton?: boolean;
  /** Max width in px — Dart `maxWidth` (default 288) */
  maxWidth?: number;
  /** Tap on the body — Dart `onTap` */
  onClick?: () => void;
  /** Tap on the close button — Dart `onClose` */
  onClose?: () => void;
  className?: string;
}

// DotsToolTipTailPosition → alignment.x (-0.82 … 0.82) → left % (Alignment -1..1 → 0..100%)
const TAIL: Record<DotsToolTipTailPosition, { top: boolean; left: string; corner: 'tl' | 'tr' | 'bl' | 'br' | null }> = {
  topAlignLeadingEdge: { top: true, left: '9%', corner: 'tl' },
  topAlignLeading: { top: true, left: '22%', corner: null },
  topAlignCenter: { top: true, left: '50%', corner: null },
  topAlignTrailing: { top: true, left: '78%', corner: null },
  topAlignTrailingEdge: { top: true, left: '91%', corner: 'tr' },
  bottomAlignLeadingEdge: { top: false, left: '9%', corner: 'bl' },
  bottomAlignLeading: { top: false, left: '22%', corner: null },
  bottomAlignCenter: { top: false, left: '50%', corner: null },
  bottomAlignTrailing: { top: false, left: '78%', corner: null },
  bottomAlignTrailingEdge: { top: false, left: '91%', corner: 'br' },
};

export function DotsTooltip(props: DotsTooltipProps) {
  const tail = TAIL[props.tailPosition] ?? TAIL.bottomAlignCenter;
  const showCloseButton = props.showCloseButton !== false; // Dart: default true
  const maxWidth = props.maxWidth ?? 288; // Dart: default 288

  const iconNode = props.iconNode ?? (props.icon ? <DotsIcon name={props.icon} size={32} color="var(--label-highlight)" /> : null);

  let cls = `ds-tooltip${tail.corner ? ` ds-tooltip--corner-${tail.corner}` : ''}`;
  if (props.className) cls += ` ${props.className}`;

  // Tail — TrianglePainter 21×13 (fill bgBaseContrast + stroke 2 bgContainerSecondary)
  const tailStyle: CSSProperties = { left: tail.left };
  if (tail.top) {
    tailStyle.top = '-12px';
    tailStyle.transform = 'translateX(-50%) rotate(180deg)';
  } else {
    tailStyle.bottom = '-12px';
    tailStyle.transform = 'translateX(-50%)';
  }

  // Dart onTap on the body → a transparent native button overlaid on the body, as a sibling of the
  // close button, never its ancestor (descendants of an ARIA button are presentational). The close
  // button sits above it with z-index, so closing never fires onClick and its keys never bubble here.
  const hitEl = props.onClick ? <button type="button" className="ds-tooltip__hit" aria-label={props.text} onClick={props.onClick} /> : null;

  return (
    <div className={cls} style={{ maxWidth: `${maxWidth}px` }}>
      {hitEl}
      {iconNode}
      <p className="ds-tooltip__text">{props.text}</p>
      {showCloseButton ? (
        <span className="ds-tooltip__close">
          {/* Dart: DotsCloseButton small softContrast addBlur=false */}
          <DotsCloseButton size="small" variant="softContrast" addBlur={false} onClick={props.onClose} />
        </span>
      ) : null}
      <svg className="ds-tooltip__tail" style={tailStyle} viewBox="0 0 21 13" aria-hidden="true">
        <path d="M0 0 L8.5 11 Q10.5 13.4 12.5 11 L21 0" strokeWidth={2} strokeLinejoin="round" />
      </svg>
    </div>
  );
}
