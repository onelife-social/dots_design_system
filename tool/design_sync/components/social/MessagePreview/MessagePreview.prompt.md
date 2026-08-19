MessagePreview from dots_design_system. Use via `window.DotsDesignSystem_9e41da.MessagePreview` (bundle loaded from the root `_ds_bundle.js`). Chat conversation preview row (92px tall): 56px squircle album image, album name + time header, last message (sender bold, optional attachment icon, 2-line clamp) and a red unread badge capped at '+999'; `typingText` replaces the message line.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `album` | `string` | — (requerido) | Nombre del álbum (bodyLargeBold 16/700). |
| `src` | `string` | — | Imagen del álbum. Sin `src` → placeholder degradado + inicial del álbum. |
| `senderName` | `string` | — | Remitente en negrita antes del mensaje (`'Ana: '`). |
| `message` | `string` | `''` | Último mensaje (bodyDefaultRegular, máx. 2 líneas). |
| `typingText` | `string` | — | Si no es vacío sustituye sender + adjunto + mensaje. |
| `newMessages` | `number` | `0` | > 0 → badge labelDestructive; > 999 → '+999'. |
| `time` | `string` | `''` | Hora/día a la derecha (textSecondary). |
| `attachmentType` | `'text'\|'image'\|'video'\|'audio'\|'file'` | — | Enum Dart MessageType; pinta icono 13 antes del mensaje (image → `ic-pic`, video → `ic-video`, audio → `ic-mic`, file → `ic-pages`). |
| `attachmentIcon` | `string` | — | Nombre DotsIcon explícito; prioridad sobre `attachmentType`. |
| `onClick` | `() => void` | — | Tap en la fila (Dart `onTap`). |

## Examples

```jsx
const { MessagePreview } = window.DotsDesignSystem_9e41da;

// Mensaje con badge de no leídos
<MessagePreview album="Verano en familia" senderName="Ana" time="14:32"
  message="¡Qué ganas de ver las fotos del viaje!" newMessages={3} onClick={openChat} />

// Escribiendo…
<MessagePreview album="Amigos de siempre" time="Ayer" typingText="Marta está escribiendo…" />

// Adjunto de imagen
<MessagePreview album="Boda de Lucía" senderName="Pablo" time="Lun"
  message="Foto" attachmentType="image" newMessages={1200} />
```

## Dart mapping

| Web | Dart (`lib/src/components/chat/`) |
| --- | --- |
| `MessagePreview` | `MessagePreview` (`message_preview.dart`) |
| `src` | `image` (Widget) — aquí imagen/placeholder 56 squircle16 (`_ImageAlbum`) |
| `attachmentType` / `attachmentIcon` | `attachmentMessage` (Widget) + enum `MessageType` (`enum/message_type_enum.dart`) |
| badge | `BadgeTag(tag: newMessages > 999 ? '+999' : …)` |
| `onClick` | `onTap` |
| tipografías | album bodyLargeBold · time/message bodyDefaultRegular · sender bodyDefaultBold |
