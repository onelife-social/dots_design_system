DotsUploadItem from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsUploadItem` (bundle loaded from the root `_ds_bundle.js`). Upload status row (photo 64 squircle16 + date + status icon/text) with variants `processing` (spinning icon + single-part progress bar + %), `success` (checkCircle + timeElapsed + secondary button) and `error` (crossCircle + dark overlay on photo + main button).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `variant` | `'processing' \| 'success' \| 'error'` | — (requerido) | Enum Dart UploadItemVariant. |
| `src` | `string` | — | Imagen 64×64 squircle16. Sin `src` → placeholder degradado. |
| `percentage` | `number` | — | (processing) 0..1; barra `DotsProgressBar(parts: 1)` + 'NN%'. |
| `textDate` | `string` | `''` | Línea superior (bodyDefaultMedium, textPrimary). |
| `processText` | `string` | `''` | Estado junto al icono 14 (labelDefaultRegular, textSecondary). |
| `processTextMaxLines` | `number \| null` | `1` | Una línea con ellipsis; `n>1` recorta a n líneas; `null` hace wrap libre. Con multilínea la fila se alinea arriba y el icono cae en la primera línea |
| `timeElapsed` | `string` | `''` | (success) Bajo el estado (textQuarternary). |
| `btnText` | `string` | `''` | (success → secondary · error → main) DotsMainButton medium. |
| `onBtnClick` | `() => void` | — | Tap del botón (Dart `btnOnTap`). |
| `onError` | `(e) => void` | — | Fallo de carga de la imagen. |

Iconos por variante: `processing` → `ic-spinner` girando (textSecondary) · `success` → `ic-check-circle` (labelHighlight) · `error` → `ic-cross-circle` (labelDestructive) + overlay `ic-cloud-fail` sobre la foto.

## Examples

```jsx
const { DotsUploadItem } = window.DotsDesignSystem_9e41da;

// Subiendo con progreso
<DotsUploadItem variant="processing" percentage={0.64}
  textDate="12 de marzo, 2024" processText="Subiendo 12 recuerdos…" src="https://…/1.jpg" />

// Completada
<DotsUploadItem variant="success" textDate="12 de marzo, 2024"
  processText="Subida completada" timeElapsed="hace 2 min" btnText="Ver" onBtnClick={openAlbum} />

// Error
<DotsUploadItem variant="error" textDate="12 de marzo, 2024"
  processText="Error al subir" btnText="Reintentar" onBtnClick={retry} />
```

## Dart mapping

| Web | Dart (`lib/src/components/upload_items/`) |
| --- | --- |
| `DotsUploadItem` | `DotsUploadItem` (`dots_upload_item.dart`) |
| `variant` | enum `UploadItemVariant` (`upload_item_variant.dart`) |
| `src` | `image` (ImageProvider) vía `DotsSquircleImage(size: 64, squircle16, uploadError: variant.isError)` |
| `btnText` / `onBtnClick` | `btnText` / `btnOnTap` (`DotsMainButton` medium, secondary/main) |
| Icono girando | `_RotatingIcon` (AnimationController 1s) → CSS `animation: spin 1s linear infinite` |
| Barra de progreso | `DotsProgressBar(percentage, parts: 1)` |
