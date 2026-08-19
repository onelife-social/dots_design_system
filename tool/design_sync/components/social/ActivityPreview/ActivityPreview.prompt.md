ActivityPreview from dots_design_system. Use via `window.DotsDesignSystem_9e41da.ActivityPreview` (bundle loaded from the root `_ds_bundle.js`). 3:4 activity card (r24, blur pill) with variants reactions/views/favs, plus `ActivityPreview.OverviewItem` — photo stack 53×68 with variant badge, counters and overlapping avatars.

## Props — ActivityPreview

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `variant` | `'reactions' \| 'views' \| 'favs'` | `'reactions'` | Enum Dart `ActivityPreviewVariant` |
| `src` | `string` | — | Imagen de fondo (cover). Sin `src` → placeholder degradado |
| `reactions` | `string[]` | — | Emojis en la píldora (solo `reactions`) — Nunito numLabelDefault |
| `number` | `string` | `''` | Número YA formateado (`'1.2K'`) — Nunito numBodyDefault, blanco |
| `onCardClick` | `() => void` | — | `onCardTap` de Dart |
| `onError` | `(e) => void` | — | Error de carga de la imagen |

La tarjeta llena el ancho de su contenedor (AspectRatio de Dart): dale un wrapper con ancho fijo, p. ej. 108px.

## Props — ActivityPreview.OverviewItem

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `images` | `string[]` | `[]` | Fotos: primera delante; con >1, la última detrás rotada -5° |
| `icon` | `string` | — (requerido) | Nombre DotsIcon del badge (en Dart es un `Widget`), p. ej. `'ic-heart'`, `'ic-eye'` |
| `iconColor` | `string` | blanco | Color del icono del badge |
| `variant` | `'reactions' \| 'views' \| 'favs'` | — (requerido) | Fondo del badge: friends001 `#FAA25E` / hobby002 `#9297EF` / couple001 `#F43C51` |
| `count` | `number` | — (requerido) | Se formatea `1.2k / 1.2M / 1.2B` |
| `title` | `string` | — (requerido) | bodyDefaultMedium, textSecondary, 1 línea |
| `reactionsCount` | `number` | — (requerido) | > 0 muestra `+N` (labelHighlight) + avatares |
| `userImages` | `string[]` | — (requerido) | Avatares 17px solapados (offset 10px) |
| `width` / `height` | `number` | `53` / `68` | Tamaño de la foto |
| `borderRadius` / `borderWidth` | `number` | `12` / `1` | Radio y borde blanco interior |
| `maxUserImages` | `number` | `2` | Máximo de avatares |

## Examples

```jsx
const { ActivityPreview } = window.DotsDesignSystem_9e41da;

// Fila de previews de actividad (ancho fijo por tarjeta)
<div style={{ display: 'flex', gap: 12 }}>
  <div style={{ width: 108 }}><ActivityPreview variant="reactions" reactions={['❤️', '😂']} number="12" src={photo1} onCardClick={open} /></div>
  <div style={{ width: 108 }}><ActivityPreview variant="views" number="1.2K" src={photo2} /></div>
  <div style={{ width: 108 }}><ActivityPreview variant="favs" number="48" src={photo3} /></div>
</div>

// Resumen de actividad con pila de fotos y avatares
<ActivityPreview.OverviewItem
  variant="reactions" icon="ic-heart"
  count={1234} title="Reacciones" reactionsCount={2100}
  images={[photoA, photoB]} userImages={[user1, user2]}
/>
```

## Dart mapping

- Widgets: `ActivityPreview` (`lib/src/components/notifications/activity_preview.dart`) y `ActivityOverviewItem` (`activity_overview_item.dart`, expuesto como `ActivityPreview.OverviewItem`)
- Enum: `ActivityPreviewVariant` (reactions/views/favs)
- Mapeo de props: `image`/`images` → `src`/`images` (URLs); `onCardTap` → `onCardClick`; `icon: Widget` → `icon: string` (nombre DotsIcon); `formatCount` portado 1:1
- Iconos de la píldora: views → `ic-eye`, favs → `ic-heart` (14px, labelAlwaysWhite)
- Badge OverviewItem: colores de categoría `friends001`/`hobby002`/`couple001` (sin token en tokens.css, iguales light/dark)
- Píldora: `bgSecondaryBtn` + `backdrop-filter: blur(10)` · sombra tarjeta `shadowPrimary`
