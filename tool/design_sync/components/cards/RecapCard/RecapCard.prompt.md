RecapCard from dots_design_system. Use via `window.DotsDesignSystem_9e41da.RecapCard` (bundle loaded from the root `_ds_bundle.js`). Recap photo card: without `locked` a 4:5 squircle52 card with dark overlay in 4 variants (active with premium badge + CTA, blocked with blurred photo + lock, generated with share + createdBy, onlyTitle); with `locked` a 7:8 card with a centered live CountdownRecap in 3 variants (countdown, locked with blurred photo + gallery CTA, soon).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `locked` | `boolean` | `false` | `true` → RecapCardLocked (7:8, countdown); si no, RecapCard (4:5, overlay) |
| `variant` | `'active' \| 'blocked' \| 'generated' \| 'onlyTitle'` | `'active'` | Sin locked (enum Dart `RecapCardVariant`; `onlyTitle` = active sin título/badge/botón) |
| `lockedVariant` | `'countdown' \| 'locked' \| 'soon'` | `'countdown'` | Con locked (enum Dart `RecapCardLockedVariant`; `soon` oculta el botón info) |
| `width` | `number` | `220` | Ancho en px (Dart `width`) |
| `imageSrc` | `string` | — | Foto de fondo; sin ella, placeholder degradado. `blocked` la difumina (blur 15) |
| `textImageSrc` | `string` | — | Imagen de texto superpuesta (Dart `textImageProvider`, solo sin locked) |
| `title` | `string` | — | Sin locked: fila superior con `ic-clock--timer` 16 · locked: título del countdown |
| `badgeText` | `string` | — | BadgeLabel premium large arriba-derecha (no en blocked) |
| `buttonText` | `string` | — | DotsMainButton main inferior (active/blocked con blur; locked·locked con `ic-gallery`) |
| `albumName` / `createdBy` | `string` | — | Textos inferiores de la variante generated |
| `description` | `string` | — | Cuerpo del countdown sin cuenta atrás (locked/soon o countdown terminado) |
| `countdownDate` | `string \| number \| Date` | — | Fecha objetivo; la cuenta atrás se actualiza cada segundo |
| `daysLabel` / `hoursLabel` / `minutesLabel` / `secondsLabel` | `string` | — | Etiquetas bajo las cifras |
| `blurImage` | `boolean` | `false` | Difumina la foto (Dart `blurImageProvider`, solo locked) |
| `onClick` | `() => void` | — | Tap en tarjeta/CTA sin locked (Dart `onTap`) |
| `onInfoClick` | `() => void` | — | Tap en share/lock/info (Dart `onInfoTap`) |
| `onButtonClick` | `() => void` | — | Tap en el CTA con locked (Dart `onButtonTap`) |

## Examples

```jsx
const { RecapCard } = window.DotsDesignSystem_9e41da;

// Recap activo con badge premium y CTA
<RecapCard variant="active" title="Recap 2025" badgeText="Premium" buttonText="Ver recap" imageSrc={url} onClick={open} />

// Recap generado (share + autoría)
<RecapCard variant="generated" title="Recap 2025" albumName="Verano en familia" createdBy="Creado por Ana" onInfoClick={share} />

// Recap bloqueado con cuenta atrás en vivo
<RecapCard
  locked
  lockedVariant="countdown"
  title="Recap de agosto"
  countdownDate="2026-09-01T00:00:00Z"
  daysLabel="días" hoursLabel="h" minutesLabel="min" secondsLabel="seg"
  onInfoClick={showInfo}
/>

// Bloqueado por falta de fotos (imagen difuminada + CTA gallery)
<RecapCard locked lockedVariant="locked" blurImage title="Recap bloqueado"
  description="Añade más fotos para desbloquearlo" buttonText="Añadir fotos" onButtonClick={addPhotos} />
```

## Dart mapping

- Widgets: `RecapCard` (`lib/src/components/cards/recap/recap_card.dart`, factories `.active/.blocked/.generated/.onlyTitle` → prop `variant`) y `RecapCardLocked` (`recap_card_locked.dart` → `locked: true` + `lockedVariant`). `CountdownRecap` (`lib/src/components/countdown/countdown_recap.dart`) va embebido.
- Props: `imageProvider`→`imageSrc`, `textImageProvider`→`textImageSrc`, `onTap`→`onClick`, `onInfoTap`→`onInfoClick`, `onButtonTap`→`onButtonClick`, `blurImageProvider`→`blurImage`; resto 1:1. `defaultImage`/`errorBuilder`/`onError` no se portan.
- Detalles fieles: overlay negro 30% + borde 2 `borderButton` (sin locked); share/lock = DotsIconButton floating large Ø44 (lock con `bgBtnImage` al 50%); info = medium Ø36; countdown w192 r24 borde blanco 30% + blur20; cifras `titleH4` 23/700, etiquetas `labelSmallMedium` al 70%.
- Aproximaciones: squircle52 → border-radius; ImageFilter.blur(15) → `filter: blur(15px)` + scale(1.15).
