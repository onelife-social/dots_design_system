// FolderCarrousel — port of lib/src/components/carrousels/folder_carrousel.dart (Dart = source of truth).
import type { ReactNode } from 'react';
import { BtnFolder } from '../BtnFolder/BtnFolder';

/** FolderCarrousel item — mirror of BtnFolderData (Dart). */
export interface FolderCarrouselItem {
  /** Real DS icon name (e.g. 'ic-family') — Dart `icon` */
  icon: string;
  /** Folder text (BtnFolder truncates it to 20 characters) */
  text?: string;
  /** Item tap — Dart `onTap`. When missing, the carrousel's `onSelect(i)` is used */
  onClick?: () => void;
  /** Item long-press — Dart `onPressed` */
  onLongPress?: () => void;
  /** Selected folder (bgStrong + shadow + icon in iconSelectedColor) */
  isSelected?: boolean;
  /** CSS color of the icon when selected — required in Dart; default '#3E9ACB' (home) */
  iconSelectedColor?: string;
  /** Icon only 44×44 (e.g. the '+' button) — BtnFolder prop */
  isNonExpandable?: boolean;
  /** The folder is editable (shows the pencil badge when showEditIcon) */
  isEditable?: boolean;
}

export interface FolderCarrouselProps {
  /** Folders rendered as BtnFolder — Dart `buttonsData` */
  items: FolderCarrouselItem[];
  /** Shows the edit badge on editable items — Dart `showEditIcon` (default false) */
  showEditIcon?: boolean;
  /** Convenience: click on item i (when the item has no onClick of its own) */
  onSelect?: (index: number) => void;
  /** Extra nodes at the end of the row — Dart `customWidgets` (DefaultFolderWidget) */
  children?: ReactNode;
  className?: string;
}

export function FolderCarrousel(props: FolderCarrouselProps) {
  const items = props.items || [];
  const showEditIcon = !!props.showEditIcon;
  const onSelect = props.onSelect;

  const nodes = items.map((item, i) => {
    const handleClick = item.onClick || (onSelect ? () => onSelect(i) : undefined);
    return (
      <BtnFolder
        key={i}
        icon={item.icon}
        text={item.text}
        onClick={handleClick}
        onLongPress={item.onLongPress} // BtnFolderData.onPressed
        isSelected={!!item.isSelected}
        // iconSelectedColor required in Dart; #3E9ACB = home folder blue (child006, no token)
        iconSelectedColor={item.iconSelectedColor || '#3E9ACB'}
        isNonExpandable={!!item.isNonExpandable}
        isEditable={!!item.isEditable}
        showEditIcon={showEditIcon}
      />
    );
  });

  return (
    <div className={`ds-folder-carrousel${props.className ? ` ${props.className}` : ''}`}>
      {nodes}
      {/* customWidgets (DefaultFolderWidget) — extra nodes at the end of the row */}
      {props.children}
    </div>
  );
}
