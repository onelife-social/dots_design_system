// BtnFolder — port of lib/src/components/buttons/btn_folder/ (Dart = source of truth).
import { useEffect, useRef } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface BtnFolderProps {
  /** DotsIcon name (real asset, e.g. 'ic-family') */
  icon: string;
  /** Folder text (truncated to 20 characters with '…') */
  text?: string;
  /** Dart `onTap` */
  onClick?: () => void;
  /** Dart `onLongPress` (long-press ~500ms; also the edit badge click) */
  onLongPress?: () => void;
  /** Selected folder: bgStrong background + shadow + icon in iconSelectedColor */
  isSelected?: boolean;
  /** Icon only 44×44 (e.g. the '+' button) */
  isNonExpandable?: boolean;
  /** CSS color of the icon when isSelected — required in Dart; default '#3E9ACB' (home folder blue) */
  iconSelectedColor?: string;
  /** Shows the edit badge (requires isEditable) */
  showEditIcon?: boolean;
  /** The folder is editable */
  isEditable?: boolean;
  /** Accessible name of the edit badge (default 'Editar carpeta'; localize from the app) */
  editLabel?: string;
  /** Accessible name for icon-only folders (isNonExpandable / no text), e.g. 'Nueva carpeta' */
  ariaLabel?: string;
}

const LONG_PRESS_MS = 500;

export function BtnFolder(props: BtnFolderProps) {
  const timer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const fired = useRef(false);

  function startPress() {
    fired.current = false;
    if (!props.onLongPress) return;
    timer.current = setTimeout(() => {
      fired.current = true;
      props.onLongPress?.();
    }, LONG_PRESS_MS);
  }
  function cancelPress() {
    if (timer.current) {
      clearTimeout(timer.current);
      timer.current = null;
    }
  }
  // A pending long-press must not fire after the component is gone.
  useEffect(() => cancelPress, []);
  function handleClick() {
    if (fired.current) {
      fired.current = false; // the long-press already consumed the gesture
      return;
    }
    props.onClick?.();
  }

  const isSelected = !!props.isSelected;
  const isNonExpandable = !!props.isNonExpandable;
  // iconSelectedColor is required in Dart; #3E9ACB = home folder blue (child006, no token)
  const selColor = props.iconSelectedColor || '#3E9ACB';
  let text = props.text != null ? String(props.text) : null;
  if (text && text.length > 20) text = `${text.substring(0, 20)}…`;

  const pill = (
    <button
      type="button"
      className={
        'ds-btn-folder__pill' +
        (isSelected ? ' ds-btn-folder__pill--selected' : '') +
        (isNonExpandable ? ' ds-btn-folder__pill--nonexp' : '')
      }
      aria-label={props.ariaLabel}
      onClick={handleClick}
      onPointerDown={startPress}
      onPointerUp={cancelPress}
      onPointerLeave={cancelPress}
      onPointerCancel={cancelPress}
      onContextMenu={(e) => {
        if (props.onLongPress) e.preventDefault();
      }}
    >
      <span className="ds-btn-folder__icon" style={isSelected && !isNonExpandable ? { color: selColor } : undefined}>
        <DotsIcon name={props.icon} size={20} />
      </span>
      {!isNonExpandable && text ? <span className="ds-btn-folder__text">{text}</span> : null}
    </button>
  );

  const edit =
    props.showEditIcon && props.isEditable ? (
      <button type="button" className="ds-btn-folder__edit" onClick={props.onLongPress} aria-label={props.editLabel ?? 'Editar carpeta'}>
        <DotsIcon name="ic-pencil" size={10} />
      </button>
    ) : null;

  return (
    <span className="ds-btn-folder">
      <span className="ds-btn-folder__clip">{pill}</span>
      {edit}
    </span>
  );
}
