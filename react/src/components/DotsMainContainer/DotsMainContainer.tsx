// DotsMainContainer — port of lib/src/components/containers/dots_main_container/ (Dart = source of truth).
import type { CSSProperties, ReactNode } from 'react';

/** Dart enum DotsMainContainerVariant */
export type DotsMainContainerVariant = 'main' | 'secondary' | 'onBackground' | 'tertiary';

export interface DotsMainContainerProps {
  /** Background variant (default 'main') — Dart enum DotsMainContainerVariant */
  variant?: DotsMainContainerVariant;
  /** CSS width or px (default 100%; Dart: screen width) */
  width?: number | string;
  /** CSS height or px; only applied with forceHeight (Dart: screen height) */
  height?: number | string;
  /** Content padding in px; only applied when there are children (default 16) */
  padding?: number | string;
  /** Radius in px (default: 24 when height ≤ 100, else 32) */
  radius?: number | string;
  /** CSS color overriding the variant background */
  backgroundColor?: string;
  /** Background image: URL/data URI or any CSS background-image value */
  backgroundImage?: string;
  /** Tap callback — Dart `onTap` (GestureDetector) */
  onClick?: () => void;
  /** Apply `height` when defined (default true) — Dart `forceHeight` */
  forceHeight?: boolean;
  /** Content — Dart `child` */
  children?: ReactNode;
  /** Extra inline style */
  style?: CSSProperties;
  className?: string;
}

const VARIANTS: readonly DotsMainContainerVariant[] = ['main', 'secondary', 'onBackground', 'tertiary'];
const toCssSize = (v: number | string) => (typeof v === 'number' ? `${v}px` : v);

export function DotsMainContainer(props: DotsMainContainerProps) {
  const variant = props.variant && VARIANTS.includes(props.variant) ? props.variant : 'main'; // DotsMainContainerVariant.main
  const forceHeight = props.forceHeight !== false;
  const padding = props.padding ?? 16;
  // Dart: radius ?? (containerHeight > 100 ? 32 : 24); without height → screen height → 32
  const radius = props.radius ?? (typeof props.height === 'number' && props.height <= 100 ? 24 : 32);

  let className = `ds-main-container ds-main-container--${variant}`;
  if (props.onClick) className += ' ds-main-container--clickable';
  if (props.className) className += ` ${props.className}`;

  const style: CSSProperties = { borderRadius: toCssSize(radius) };
  if (props.width != null) style.width = toCssSize(props.width);
  if (props.height != null && forceHeight) style.height = toCssSize(props.height);
  if (props.children != null) style.padding = toCssSize(padding); // Dart: Padding only with child
  if (props.backgroundColor) style.backgroundColor = props.backgroundColor;
  if (props.backgroundImage) {
    // accepts a CSS background-image value or a bare URL/data URI
    style.backgroundImage = props.backgroundImage.includes('(') ? props.backgroundImage : `url(${props.backgroundImage})`;
  }
  Object.assign(style, props.style);

  return (
    <div
      className={className}
      style={style}
      onClick={props.onClick} // Dart: GestureDetector(onTap)
      role={props.onClick ? 'button' : undefined}
      tabIndex={props.onClick ? 0 : undefined}
    >
      {props.children}
    </div>
  );
}
