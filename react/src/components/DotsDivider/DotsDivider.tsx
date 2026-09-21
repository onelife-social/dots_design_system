// DotsDivider — port of lib/src/components/divider/dots_divider.dart (Dart = source of truth).
import type { CSSProperties } from 'react';

export interface DotsDividerProps {
  /** CSS width or px (default 100% — Dart double.infinity) */
  width?: number | string;
  /** Extra CSS class */
  className?: string;
}

export function DotsDivider(props: DotsDividerProps) {
  let style: CSSProperties | undefined;
  if (props.width != null) {
    style = { width: typeof props.width === 'number' ? `${props.width}px` : props.width };
  }
  return (
    <div className={`ds-divider${props.className ? ` ${props.className}` : ''}`} style={style} role="separator" aria-orientation="horizontal">
      <div className="ds-divider__line1" />
      <div className="ds-divider__line2" />
    </div>
  );
}
