import * as React from 'react';

/**
 * MessagePreview — port web de MessagePreview (Flutter). Fila de preview de chat
 * (h92): imagen del álbum 56 squircle16, cabecera álbum/hora, último mensaje y badge.
 */
export interface MessagePreviewProps {
  /** URL de la imagen del álbum. Sin `src` → placeholder degradado con la inicial. */
  src?: string;
  /** Nombre del álbum (bodyLargeBold). */
  album: string;
  /** Nombre del remitente en negrita ('Ana: '). Vacío → no se muestra. */
  senderName?: string;
  /** Último mensaje (máx. 2 líneas con ellipsis). */
  message?: string;
  /** Si no es vacío sustituye a sender + attachment + message ('X está escribiendo…'). */
  typingText?: string;
  /** Mensajes sin leer; > 0 muestra el badge rojo, > 999 → '+999'. */
  newMessages?: number;
  /** Hora / día a la derecha (bodyDefaultRegular). */
  time?: string;
  /** Tipo del adjunto — enum Dart MessageType ('text' no pinta icono). */
  attachmentType?: 'text' | 'image' | 'video' | 'audio' | 'file';
  /** Icono de adjunto explícito (nombre DotsIcon); tiene prioridad sobre attachmentType. */
  attachmentIcon?: string;
  /** Callback al pulsar la fila (Dart onTap). */
  onClick?: () => void;
  /** Callback si la imagen falla al cargar. */
  onError?: (event: unknown) => void;
  className?: string;
}

export declare const MessagePreview: React.ComponentType<MessagePreviewProps>;
