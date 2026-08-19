ImageWithIcon from dots_design_system. Use via `window.DotsDesignSystem_9e41da.ImageWithIcon` (bundle loaded from the root `_ds_bundle.js`). 53×68 thumbnail (or circular) with top gradient, inner white border and a corner badge with a DotsIcon; without `src` it can show an initial (`aliasLabelImageText`).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `src` | `string` | — | URL de la imagen (`image` de Dart). Si falla → `defaultImage` (default_user_item.webp embebido) |
| `icon` | `string` | — | Nombre DotsIcon del badge (en Dart es un `Widget`), p. ej. `'ic-heart'` |
| `iconColor` | `string` | tema | Color del icono |
| `iconSize` | `number` | `18` | Badge interior = `iconSize × 1.5`, borde = `iconSize × 0.1` |
| `iconOffset` | `number` | mitad del badge | Desplazamiento del badge desde la esquina |
| `width` / `height` | `number` | `53` / `68` | Tamaño |
| `borderRadius` | `number` | `12` | Con `circularImage` se usa `width / 2` |
| `borderWidth` | `number` | `2` | Borde blanco interior (Colors.white60) |
| `circularImage` | `boolean` | `false` | Forma circular |
| `showIcon` | `boolean` | `true` | Mostrar el badge |
| `aliasLabelImageText` | `string` | — | Inicial cuando no hay `src` — fondo bgSecondaryBtn, Nunito 600 40 textTertiary |
| `aliasLabelImageTextStyle` | `CSSProperties` | — | Sustituye el estilo del alias |
| `onError` | `(e) => void` | — | Error de carga de la imagen |

## Examples

```jsx
const { ImageWithIcon } = window.DotsDesignSystem_9e41da;

// Miniatura de recuerdo con badge de corazón
<ImageWithIcon src={photoUrl} icon="ic-heart" />

// Avatar circular con inicial (sin foto)
<ImageWithIcon aliasLabelImageText="M" circularImage width={53} height={53} icon="ic-user" />
```

## Dart mapping

- Widget: `ImageWithIcon` (`lib/src/components/notifications/image_with_icon.dart`)
- Mapeo de props: `image` → `src`; `icon: Widget` → `icon: string` (nombre DotsIcon) + `iconColor`; `aliasLabelImageTextStyle: TextStyle` → objeto CSS; resto 1:1
- Geometría del badge portada 1:1: `iconBorderWidth = iconSize*0.1`, contenedor `iconSize*1.5`, posición `-(iconOffset ?? radio) + borde`; aro exterior `bgBase`, interior `bgSecondaryBtn`
- Gradiente superior black26 → transparent (0 → 50%) · borde interior `Colors.white60` (#FFFFFF99, sin token) · sombra ≈ Card elevation 1
- `loadingBuilder`/`errorBuilder` → `defaultImage` (`ImagesPaths.defaultUserItem`), embebido como data URI en el CSS
