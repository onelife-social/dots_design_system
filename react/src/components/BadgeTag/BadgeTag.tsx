// BadgeTag — port of lib/src/components/badges/badge_tag.dart (Dart = source of truth).
// Official standalone: DotsSegmentedControl (.ds-seg__tag) and DotsIconButton
// (.ds-icon-btn__tag) paint their own inline tag — different classes, no collision.
import type { ReactNode } from 'react';

export interface BadgeTagProps {
  /** Tag text. Empty string → empty 18×18 pill — Dart `tag` */
  tag: string;
  /**
   * Offset from the top-right corner when there is a child (right = width, top = height).
   * Default -5/-5 — Dart `size` (Size)
   */
  size?: { width?: number; height?: number };
  /** Main content the tag floats over — Dart `child` */
  children?: ReactNode;
}

function body(tag: string, floating: boolean, offset?: BadgeTagProps['size']) {
  return (
    <span
      className={`ds-badge-tag${floating ? ' ds-badge-tag--floating' : ''}`}
      style={
        floating
          ? {
              // Dart: Positioned(right: size?.width ?? -5, top: size?.height ?? -5)
              right: `${offset?.width ?? -5}px`,
              top: `${offset?.height ?? -5}px`,
            }
          : undefined
      }
    >
      {tag ? tag : null /* Dart: tag.isEmpty → SizedBox.shrink() (empty 18x18 pill) */}
    </span>
  );
}

export function BadgeTag(props: BadgeTagProps) {
  if (props.children == null) return body(props.tag, false);
  return (
    <span className="ds-badge-tag-host">
      {props.children}
      {body(props.tag, true, props.size)}
    </span>
  );
}
