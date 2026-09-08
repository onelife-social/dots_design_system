// DotsIcon — the design system's real icon catalog (SVGs from assets/icons/** embedded in icons.ts).
import { ICONS, type DotsIconName } from './icons';

export type { DotsIconName };

export interface DotsIconProps {
  /** Asset file name without `.svg` (e.g. 'ic-heart'). Unknown names render a dashed placeholder. */
  name: DotsIconName | (string & {});
  /** Square side in px (default 24) */
  size?: number;
  /** CSS color for monochrome icons (default 'currentColor'; multicolor icons ignore it) */
  color?: string;
  className?: string;
}

/** Every icon name available in the embedded catalog. */
export const dotsIconNames = Object.keys(ICONS) as DotsIconName[];

export function DotsIcon({ name, size = 24, color = 'currentColor', className }: DotsIconProps) {
  const cls = className ? ` ${className}` : '';
  const svg = (ICONS as Record<string, string>)[name];
  if (!svg) {
    return <span className={`ds-icon ds-icon--missing${cls}`} style={{ width: size, height: size }} title={name} />;
  }
  return (
    <span
      className={`ds-icon${cls}`}
      style={{ width: size, height: size, color: color !== 'currentColor' ? color : undefined }}
      dangerouslySetInnerHTML={{ __html: svg }}
    />
  );
}
DotsIcon.names = dotsIconNames;
