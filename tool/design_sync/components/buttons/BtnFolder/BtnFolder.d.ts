import * as React from 'react';

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
}
export declare function BtnFolder(props: BtnFolderProps): import("react").JSX.Element;
