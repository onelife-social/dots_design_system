// MessagePreview — port of lib/src/components/chat/message_preview.dart
// (+ chat/enum/message_type_enum.dart → `attachmentType` prop). Dart = source of truth.
import { useState, type ReactNode, type SyntheticEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { pressable } from '../../internal/pressable';

/** Dart enum MessageType ('text' paints no attachment icon) */
export type MessagePreviewAttachmentType = 'text' | 'image' | 'video' | 'audio' | 'file';

// MessageType (isAttachment = != text) → attachment icon in the preview
const ATTACHMENT_ICONS: Record<Exclude<MessagePreviewAttachmentType, 'text'>, string> = {
  image: 'ic-pic',
  video: 'ic-video',
  audio: 'ic-mic',
  file: 'ic-pages',
};

// Deterministic gradient placeholder variant
function gradVariant(seed: string | undefined) {
  const s = seed ?? '';
  let n = 0;
  for (let i = 0; i < s.length; i++) n = (n + s.charCodeAt(i)) % 997;
  return 'abcd'[n % 4];
}

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

export function MessagePreview(props: MessagePreviewProps) {
  const [hasError, setError] = useState(false);

  const album = props.album || '';
  const newMessages = props.newMessages || 0;
  const typing = props.typingText != null && props.typingText !== '';
  const showImg = !!props.src && !hasError;

  // _ImageAlbum — 56×56 squircle16; gradient placeholder with the album initial
  const image = (
    <span className="ds-msg-preview__img">
      {showImg ? (
        <img
          className="ds-msg-preview__img-el"
          src={props.src}
          alt={album}
          onError={(e) => {
            setError(true);
            props.onError?.(e);
          }}
        />
      ) : (
        <span className={`ds-msg-preview__img-ph ds-msg-preview__img-ph--${gradVariant(album)}`}>
          {album ? album.charAt(0).toUpperCase() : ''}
        </span>
      )}
    </span>
  );

  // _ChatContent — typingText overrides sender + attachment + message (Dart)
  let content: ReactNode[];
  if (typing) {
    content = [<span key="t">{props.typingText}</span>];
  } else {
    content = [];
    if (props.senderName) {
      content.push(
        <span key="s" className="ds-msg-preview__sender">
          {`${props.senderName}: `}
        </span>,
      );
    }
    const attachmentIcon =
      props.attachmentIcon || (props.attachmentType && props.attachmentType !== 'text' ? ATTACHMENT_ICONS[props.attachmentType] : null);
    if (attachmentIcon) {
      content.push(
        <span key="a" className="ds-msg-preview__attach">
          <DotsIcon name={attachmentIcon} size={13} color="currentColor" />
        </span>,
        ' ',
      );
    }
    content.push(props.message || '');
  }

  // Dart onTap → complete button semantics (role, tab stop, Enter/Space); static row otherwise
  return (
    <div className={`ds-msg-preview${props.className ? ` ${props.className}` : ''}`} {...pressable(props.onClick)}>
      <div className="ds-msg-preview__inner">
        {image}
        <div className="ds-msg-preview__col">
          {/* _ChatHeaderInfo — album bodyLargeBold + time bodyDefaultRegular */}
          <div className="ds-msg-preview__header">
            <span className="ds-msg-preview__album">{album}</span>
            <span className="ds-msg-preview__time">{props.time || ''}</span>
          </div>
          <div className="ds-msg-preview__content">
            <span className="ds-msg-preview__text">{content}</span>
            {/* BadgeTag — labelDestructive pill, cap '+999' */}
            {newMessages > 0 ? <span className="ds-msg-preview__badge">{newMessages > 999 ? '+999' : String(newMessages)}</span> : null}
          </div>
        </div>
      </div>
    </div>
  );
}
