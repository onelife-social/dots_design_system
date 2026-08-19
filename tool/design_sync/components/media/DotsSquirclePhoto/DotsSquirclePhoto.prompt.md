DotsSquirclePhoto from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsSquirclePhoto` (bundle loaded from the root `_ds_bundle.js`). Squircle photo (default 52, r16, default shadow) with optional border and upload-error overlay; `DotsSquirclePhoto.Tag` adds the white-bordered 100px variant with a highlight tag circle (calendarCheck) bottom-right.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `src` | `string` | — | URL de la imagen. Sin `src` (o si falla) → placeholder degradado. |
| `alt` | `string` | `''` | Texto alternativo; semilla del degradado. |
| `size` | `number` | `52` | Lado en px. |
| `borderRadius` | `number \| string` | `16` | Radio (DotsBorderRadius.r16). |
| `hideBorder` | `boolean` | `true` | `false` → borde `borderSize` px color `borderColor`. |
| `borderSize` | `number` | `1` | Grosor del borde. |
| `borderColor` | `string` | `var(--bg-btn-image)` | Color del borde (bgBtnImage al 60%). |
| `uploadError` | `boolean` | `false` | Overlay negro 20% + icono `uploadErrorIcon` 24 blanco. |
| `uploadErrorIcon` | `string` | `'ic-cloud-fail'` | Icono del overlay. |
| `onClick` / `onError` | `fn` | — | Tap / fallo de carga. |

`DotsSquirclePhoto.Tag` (Dart DotsSquircleImageTag): `size` (100), `borderRadius` (24), `borderColor` (`var(--label-always-white)`), `borderSize` (2), `icon` (`'ic-calendar--check'`), `iconSize` (24), `iconColor` (blanco), `tagCircleSize` (40). El lienzo total es `size + 10` px; el círculo tag va a 2px del borde inferior-derecho sobre `var(--label-highlight)`.

## Examples

```jsx
const { DotsSquirclePhoto } = window.DotsDesignSystem_9e41da;

// Imagen 52 r16 con sombra default
<DotsSquirclePhoto src="https://…/foto.jpg" />

// Con borde y overlay de error de subida
<DotsSquirclePhoto src="https://…/foto.jpg" hideBorder={false} uploadError />

// Variante Tag (100, r24, calendarCheck)
<DotsSquirclePhoto.Tag src="https://…/plan.jpg" />
```

## Dart mapping

| Web | Dart (`lib/src/components/photos_components/`) |
| --- | --- |
| `DotsSquirclePhoto` | `DotsSquircleImage` (`dots_squircle_photo.dart`) |
| `DotsSquirclePhoto.Tag` | `DotsSquircleImageTag` (`dots_squircle_photo_tag.dart`) |
| `src` | `image` (ImageProvider); placeholder ≈ `defaultImagePath` |
| `borderRadius` | `DotsBorderRadius.rXX` |
| sombra + squircle | `DotsDecoratedBox(defaultShadow)` + `squircleStyle` (aprox. border-radius) |
| `uploadError` / `uploadErrorIcon` | mismos nombres (`DotsIconData.cloudFail`) |
| Tag `icon`/`iconSize`/`iconColor`/`tagCircleSize` | mismos nombres (icono centrado en vez de `iconLeft`/`iconTop`) |
