// DotsToast — port of lib/src/components/toast/ (Dart = source of truth).
// Unifies DotsToast + DotsToastInfo (isAction: false) + DotsToastAction (isAction: true):
// the Dart wrappers only fix isAction, here it is a prop.
import type { ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsMainButton } from '../DotsMainButton/DotsMainButton';
import { pressable } from '../../internal/pressable';

/** Dart enum DotsToastVariant */
export type DotsToastVariant = 'success' | 'error' | 'info' | 'progress' | 'connectionResumed' | 'connectionLost' | 'widget';

export interface DotsToastProps {
  /** Toast text, bodyDefaultMedium textPrimary — Dart `title` */
  title: string;
  /** Variant — Dart enum DotsToastVariant (default 'info') */
  variant: DotsToastVariant;
  /** true → DotsToastAction (160px column); false/omitted → DotsToastInfo (358px row) — Dart `isAction` */
  isAction?: boolean;
  /** DotsIcon name overriding the variant icon — Dart `customIconData` */
  customIcon?: string;
  /** CSS color overriding the variant tint — Dart `customIconColor` */
  customIconColor?: string;
  /** Ghost button text — only variant progress with isAction: false — Dart `btnTitle` */
  btnTitle?: string;
  /** Node shown instead of the icon — only variant widget with isAction: true — Dart `customWidget` */
  customWidget?: ReactNode;
  /** Tap on the toast (and on the ghost button) — Dart `onTap` */
  onClick?: () => void;
  className?: string;
}

const VARIANTS: DotsToastVariant[] = ['success', 'error', 'info', 'progress', 'connectionResumed', 'connectionLost', 'widget'];

// DotsToast.iconData(variant, isAction) — real names from assets/icons
function iconName(variant: DotsToastVariant, isAction: boolean): string {
  switch (variant) {
    case 'success':
      return 'ic-check-circle';
    case 'error':
      return isAction ? 'ic-trash' : 'ic-cross-circle';
    case 'info':
      return 'ic-alert-circle';
    case 'connectionResumed':
      return 'ic-connection-on';
    case 'connectionLost':
      return 'ic-connection-off';
    default:
      return 'ic-slot'; // progress | widget → DotsIconData.progressSpinner ('ic-slot.svg')
  }
}

// DotsToast.iconColor(theme)
function iconColor(variant: DotsToastVariant): string {
  switch (variant) {
    case 'success':
    case 'connectionResumed':
      return 'var(--label-highlight)';
    case 'error':
    case 'connectionLost':
      return 'var(--label-destructive)';
    default:
      return 'var(--text-tertiary)'; // info | progress | widget
  }
}

function iconEl(name: string, size: number, color: string | undefined, spin: boolean) {
  return (
    <span className={`ds-toast__icon${spin ? ' ds-toast__icon--spin' : ''}`} aria-hidden="true">
      <DotsIcon name={name} size={size} color={color} />
    </span>
  );
}

export function DotsToast(props: DotsToastProps) {
  const variant: DotsToastVariant = VARIANTS.includes(props.variant) ? props.variant : 'info';
  const isAction = !!props.isAction;
  const isProgress = variant === 'progress';
  const name = props.customIcon || iconName(variant, isAction);
  const color = props.customIconColor || iconColor(variant);

  let className = `ds-toast ${isAction ? 'ds-toast--action' : 'ds-toast--info'}`;
  if (props.onClick) className += ' ds-toast--clickable';
  if (props.className) className += ` ${props.className}`;

  const titleEl = <span className="ds-toast__title">{props.title}</span>;

  let children: ReactNode;
  if (isAction) {
    // 160 column: icon (or customWidget if variant widget) + title. Icon: progress 20, others 24.
    const top = variant === 'widget' ? (props.customWidget ?? null) : iconEl(name, isProgress ? 20 : 24, color, false);
    children = (
      <>
        {top}
        {titleEl}
      </>
    );
  } else {
    // 358 row: icon + title + ghost button (progress only). In progress the icon rotates
    // and is NOT tinted (ic-slot keeps its own colors), like _RotatingIcon in Dart.
    const lead = isProgress ? iconEl(name, 24, undefined, true) : iconEl(name, 20, color, false);
    const btn =
      props.btnTitle != null && isProgress ? (
        <DotsMainButton
          label={props.btnTitle}
          variant="ghost"
          size="medium"
          adaptPaddingForText
          expand={false}
          onClick={(e) => {
            // The toast itself also handles onClick: stop the bubble so it is dispatched exactly once
            e?.stopPropagation();
            props.onClick?.();
          }}
        />
      ) : null;
    children = (
      <>
        {lead}
        {titleEl}
        {btn}
      </>
    );
  }

  // Static toast: role="status" (polite live region). Tappable toast (Dart onTap): a complete button
  // (role, tab stop, Enter/Space) that keeps being announced through aria-live.
  const semantics = props.onClick ? { ...pressable(props.onClick), 'aria-live': 'polite' as const } : { role: 'status' };

  return (
    <div className={className} {...semantics}>
      {children}
    </div>
  );
}
