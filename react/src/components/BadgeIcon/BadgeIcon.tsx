// BadgeIcon — port of lib/src/components/badges/badge_icon/ (Dart = source of truth).
// Includes the group mode (`icons` prop) mirroring BadgeIconGroup (badge_icon_group.dart).
import type { CSSProperties } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { pressable } from '../../internal/pressable';

/** Dart enum BadgeIconSize (circle 44/36/28 · icon 24/20/16) */
export type BadgeIconSize = 'large' | 'medium' | 'small';
/** Dart enum BadgeIconStyle (only white for now) */
export type BadgeIconStyle = 'white';

export interface BadgeIconProps {
  /** Real Dots icon name (e.g. 'ic-heart') — Dart `icon` (DotsIconData). Required in single mode */
  icon?: string;
  /** Size — Dart enum BadgeIconSize (large 44/24 · medium 36/20 · small 28/16) */
  size?: BadgeIconSize;
  /** Visual style — Dart enum BadgeIconStyle (only 'white') */
  style?: BadgeIconStyle;
  /** Optional CSS color for the icon — Dart `iconColor` */
  iconColor?: string;
  /** Dart `onTap` */
  onClick?: () => void;
  /** Accessible name of the clickable badge (the control is icon-only); applied only with `onClick` */
  ariaLabel?: string;
  /**
   * Group mode (Dart BadgeIconGroup): 1-3 icon names stacked on a 63×70 canvas.
   * icons[0] medium bottom-left; icons[1]/icons[2] small. Ignores `icon`/`size`.
   */
  icons?: string[];
  /** Group mode: color per icon (null = style default) — Dart `iconColors` */
  iconColors?: Array<string | null | undefined>;
}

// BadgeIconSize (Dart): circle size / iconSize
const SIZES: Record<BadgeIconSize, { size: number; iconSize: number }> = {
  large: { size: 44, iconSize: 24 },
  medium: { size: 36, iconSize: 20 },
  small: { size: 28, iconSize: 16 },
};
const STYLES: Record<BadgeIconStyle, true> = { white: true };

function single(
  name: string | undefined,
  sizeName: BadgeIconSize | undefined,
  style: BadgeIconStyle | undefined,
  iconColor: string | null | undefined,
  onClick?: () => void,
  posStyle?: CSSProperties,
  ariaLabel?: string,
) {
  const s = (sizeName && SIZES[sizeName]) || SIZES.large; // Dart: default large
  return (
    <span
      className={`ds-badge-icon ds-badge-icon--${style && STYLES[style] ? style : 'white'}`}
      style={{ width: `${s.size}px`, height: `${s.size}px`, ...posStyle }}
      {...pressable(onClick)}
      aria-label={onClick ? ariaLabel : undefined}
    >
      <DotsIcon name={name ?? ''} size={s.iconSize} color={iconColor || 'currentColor'} />
    </span>
  );
}

export function BadgeIcon(props: BadgeIconProps) {
  // Group mode — BadgeIconGroup (Dart): 1-3 icons stacked on a 63x70 canvas.
  if (props.icons) {
    const icons = props.icons.slice(0, 3);
    if (!icons.length) return null; // Dart: SizedBox.shrink()
    const colors = props.iconColors ?? [];
    return (
      <span className="ds-badge-icon-group" {...pressable(props.onClick)} aria-label={props.onClick ? props.ariaLabel : undefined}>
        {single(icons[0], 'medium', props.style, colors[0], undefined, { left: 0, bottom: 0 })}
        {icons.length >= 2
          ? single(
              icons[1],
              'small',
              props.style,
              colors[1],
              undefined,
              icons.length === 3 ? { left: '4px', bottom: '42px' } : { left: '31px', bottom: '31px' },
            )
          : null}
        {icons.length === 3 ? single(icons[2], 'small', props.style, colors[2], undefined, { left: '35px', bottom: '26px' }) : null}
      </span>
    );
  }
  return single(props.icon, props.size, props.style, props.iconColor, props.onClick, undefined, props.ariaLabel);
}
