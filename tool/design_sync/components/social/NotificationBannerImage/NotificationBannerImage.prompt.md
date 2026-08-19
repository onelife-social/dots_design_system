NotificationBannerImage from dots_design_system. Use via `window.DotsDesignSystem_9e41da.NotificationBannerImage` (bundle loaded from the root `_ds_bundle.js`). r24 banner with top image, titleH6 title, optional description with highlighted appended text, action button (main/secondary via `isBtnActive`) and close button — the home "recaps" banner.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `src` | `string` | — | URL de la imagen (`imageProvider` de Dart). Sin `src` → placeholder degradado tipo recap |
| `imageSize` | `number` | — | Lado en px (imagen cuadrada, cover). Sin él, ancho completo |
| `imagePadding` | `number` | `20` | Padding horizontal de la imagen |
| `title` | `string` | — (requerido) | titleH6 (18/600), textPrimary, pad horizontal 28 |
| `description` | `string` | — | bodyDefaultRegular (14/400), textTertiary |
| `appendedDescription` | `string` | — | Se añade con espacio, color labelHighlight |
| `actionButtonText` | `string` | — | Si existe, muestra `DotsMainButton` (`expand: false`) |
| `actionButtonSize` | `'mainAction' \| 'large' \| 'medium' \| 'small'` | `'medium'` | Enum Dart `DotsMainButtonSize` |
| `isBtnActive` | `boolean` | `true` | `true` → variant `main` · `false` → `secondary` |
| `onActionClick` | `() => void` | — | `onActionTap`; además hace clicable el banner entero (GestureDetector de Dart) |
| `onClose` | `() => void` | — | Tap en `DotsCloseButton` softContrast · medium (top 12 / right 12) |
| `showCloseButton` | `boolean` | `true` | Mostrar el botón de cierre |
| `onError` | `(e) => void` | — | Error de imagen (se oculta, como el `errorBuilder` Dart) |

## Examples

```jsx
const { NotificationBannerImage } = window.DotsDesignSystem_9e41da;

// Banner de recaps del home (screens/home.html)
<NotificationBannerImage
  title="¡Revive tus mejores recuerdos en vídeo! Descubre uno nuevo cada vez."
  actionButtonText="Elegir mi álbum"
  actionButtonSize="large"
  onActionClick={openRecaps}
/>

// Con imagen cuadrada y descripción con apéndice destacado
<NotificationBannerImage
  src={recapCover}
  imageSize={88}
  title="Tu recap de agosto está listo"
  description="Un vídeo con tus mejores momentos."
  appendedDescription="Ver ahora"
  actionButtonText="Reproducir"
/>
```

## Dart mapping

- Widget: `NotificationBannerImage` (`lib/src/components/notifications/notification_banner_image.dart`)
- Fondo `bgContainerSecondaryOnBackground` · r24 · pad top 20 / bottom 16 · `Column(spacing: 12)` · contenido con pad horizontal 20, título 28 extra
- Mapeo de props: `imageProvider` → `src`; `onActionTap` → `onActionClick`; resto 1:1
- Composición: `DotsMainButton(variant: isBtnActive ? main : secondary, expand: false)` + `DotsCloseButton(icon: cross, size: medium, variant: softContrast)`
- Usado por `HomeRecapsBanner` (ver `screens/home.html`)
