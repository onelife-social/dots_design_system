ImageThumbnail from dots_design_system. Use via `window.DotsDesignSystem_9e41da.ImageThumbnail` (bundle loaded from the root `_ds_bundle.js`). Square r12 thumbnail with two variants: `image` (cover photo, optional 30% dark overlay) and `icon` (centered DotsIcon over the secondary container background).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `variant` | `'image' \| 'icon'` | `'image'` | Enum Dart `DotsImageThumbnailVariant`. |
| `src` | `string` | — | URL de la imagen (solo `image`). |
| `alt` | `string` | `''` | Alt de la imagen. |
| `size` | `number` | `40` | Lado en px. |
| `icon` | `string` | `'ic-user'` | Nombre de DotsIcon (solo `icon`). |
| `iconSize` | `number` | `20` | Tamaño del icono. |
| `iconColor` | `string` | `text-secondary` | Color CSS del icono. |
| `coverImage` | `boolean` | `false` | Overlay negro al 30 % sobre la imagen. |
| `onError` | `handler` | — | Error de carga de la imagen. |
| `className` | `string` | — | Clases extra sobre `.ds-image-thumbnail`. |

Variant `icon`: fondo `bgContainerSecondaryOnBackground`; variant `image`: fondo transparente con la foto en cover. Radio `DotsBorderRadius.r12`.

## Examples

```jsx
const { ImageThumbnail } = window.DotsDesignSystem_9e41da;

// Miniatura de foto
<ImageThumbnail variant="image" src={photoUrl} />

// Con overlay oscuro (seleccionada / de fondo bajo texto)
<ImageThumbnail variant="image" src={photoUrl} coverImage />

// Placeholder de usuario
<ImageThumbnail variant="icon" />

// Icono custom más grande
<ImageThumbnail variant="icon" icon="ic-camera" size={56} iconSize={28} />
```

## Dart mapping

| Web | Dart (`lib/src/components/image_thumbnail/image_thumbnail.dart`) |
| --- | --- |
| `ImageThumbnail` | `DotsImageThumbnail` |
| `variant` | `DotsImageThumbnailVariant.image/.icon` |
| `src` | `image` (`ImageProvider`) |
| `icon` | `iconData` (`DotsIconData.user` por defecto → `ic-user`) |
| `size`/`iconSize`/`iconColor`/`coverImage`/`onError` | mismos nombres |
| Fondo icon / radio | `bgContainerSecondaryOnBackground` / `DotsBorderRadius.r12` |
| Overlay `coverImage` | `Colors.black` al 30 % (sin token) |
