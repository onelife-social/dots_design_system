import * as React from 'react';

import { type SyntheticEvent } from 'react';
/** Dart enum MessageType ('text' paints no attachment icon) */
export type MessagePreviewAttachmentType = 'text' | 'image' | 'video' | 'audio' | 'file';
/**
 * MessagePreview — web port of MessagePreview (Flutter). Chat preview row (h92): album
 * image 56 squircle16, album/time header, last message and unread badge.
 */
export interface MessagePreviewProps {
    /** Album image URL. Without `src` → gradient placeholder with the initial */
    src?: string;
    /** Album name (bodyLargeBold) */
    album: string;
    /** Sender name in bold ('Ana: '). Empty → not shown */
    senderName?: string;
    /** Last message (max 2 lines with ellipsis) */
    message?: string;
    /** When not empty it replaces sender + attachment + message ('X is typing…') */
    typingText?: string;
    /** Unread messages; > 0 shows the red badge, > 999 → '+999' */
    newMessages?: number;
    /** Time / day on the right (bodyDefaultRegular) */
    time?: string;
    /** Attachment type — Dart enum MessageType ('text' paints no icon) */
    attachmentType?: MessagePreviewAttachmentType;
    /** Explicit attachment icon (DotsIcon name); takes precedence over attachmentType */
    attachmentIcon?: string;
    /** Row tap callback (Dart onTap) */
    onClick?: () => void;
    /** Image load error callback */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
    className?: string;
}
export declare function MessagePreview(props: MessagePreviewProps): import("react").JSX.Element;
