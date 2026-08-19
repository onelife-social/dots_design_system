DotsProfilePhoto from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsProfilePhoto` (bundle loaded from the root `_ds_bundle.js`). Circular profile photo (default 32×32) with a `bited` variant (44×44, bottom-right bite + emoji reaction) and a deterministic gradient placeholder when no `src` is given.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `src` | `string` | — | URL de la imagen. Sin `src` (o si falla) → placeholder degradado determinista. |
| `alt` | `string` | `''` | Texto alternativo; semilla del degradado del placeholder. |
| `width` / `height` | `number` | `32` (`44` si `bited`) | Dimensiones en px. |
| `bited` | `boolean` | `false` | Variante DotsProfilePhotoBited: círculo con mordida abajo-derecha. |
| `reaction` | `string` | — | (Solo `bited`) Emoji centrado en la mordida (labelDefaultBold 13/600). |
| `biteSize` | `number` | `0.25` | (Solo `bited`) Radio de la mordida como fracción del diámetro. |
| `biteOffset` | `{x,y}` | `{x:0.85,y:0.85}` | (Solo `bited`) Centro de la mordida en fracciones del diámetro. |
| `onClick` | `() => void` | — | Tap sobre la foto (Dart `onTap`). |
| `onError` | `(e) => void` | — | Fallo de carga de imagen; se activa el placeholder. |

## Examples

```jsx
const { DotsProfilePhoto } = window.DotsDesignSystem_9e41da;

// Avatar 32 con imagen
<DotsProfilePhoto src="https://…/ana.jpg" alt="Ana" />

// Avatar 44 sin imagen (placeholder degradado)
<DotsProfilePhoto width={44} height={44} alt="Lucía" onClick={() => openProfile()} />

// Variante bited con reacción
<DotsProfilePhoto bited reaction="😂" src="https://…/marta.jpg" />
```

## Dart mapping

| Web | Dart (`lib/src/components/photos_components/`) |
| --- | --- |
| `DotsProfilePhoto` | `DotsProfilePhoto` (`dots_profile_photo.dart`) |
| `bited: true` | `DotsProfilePhotoBited` (`dots_profile_photo_bited.dart`) |
| `src` | `imageProvider` (ImageProvider) |
| `onClick` / `onError` | `onTap` / `onError` |
| `biteSize` / `biteOffset` / `reaction` | mismos nombres (`Offset` → `{x,y}`); mordida vía CSS mask ≈ `_BiteCircleClipper` |
| Placeholder degradado | extensión web (Dart delega el error en `onError`) |
