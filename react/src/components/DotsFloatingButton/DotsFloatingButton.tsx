// DotsFloatingButton — port of lib/src/components/buttons/dots_floating_button/ (Dart = source of truth).
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface DotsFloatingButtonProps {
  /** Button text (labelDefaultBold 13/600, 1-line ellipsis) */
  content: string;
  /** DotsIcon name (20px), optional — e.g. 'ic-map' */
  icon?: string;
  /** Dart `onTap` */
  onClick?: () => void;
  /** Backdrop blur + 50% white layer under the background (default true) */
  blur?: boolean;
}

export function DotsFloatingButton(props: DotsFloatingButtonProps) {
  const blur = props.blur !== false;
  return (
    <button type="button" className={`ds-floating-btn${blur ? ' ds-floating-btn--blur' : ''}`} onClick={props.onClick}>
      {props.icon ? <DotsIcon name={props.icon} size={20} /> : null}
      <span className="ds-floating-btn__label">{props.content}</span>
    </button>
  );
}
