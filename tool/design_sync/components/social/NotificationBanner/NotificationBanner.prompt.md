NotificationBanner from dots_design_system. Use via `window.DotsDesignSystem_9e41da.NotificationBanner` (bundle loaded from the root `_ds_bundle.js`). Centered info banner (r24) with title, optional body, optional action button (DotsMainButton main·medium) and optional close button.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `title` | `string` | — (requerido) | Título centrado — bodyLargeBold (16/700), textPrimary |
| `body` | `string` | — | Cuerpo — bodyDefaultRegular (14/400), textSecondary |
| `actionButtonText` | `string` | — | Si existe, muestra `DotsMainButton` variant `main`, size `medium`, `expand: false` |
| `onActionClick` | `() => void` | — | `onActionTap` de Dart |
| `onClose` | `() => void` | — | Tap en el `DotsCloseButton` (softContrast · medium · ic-cross, en top 12 / right 12) |
| `showCloseButton` | `boolean` | `true` | Mostrar el botón de cierre |

## Examples

```jsx
const { NotificationBanner } = window.DotsDesignSystem_9e41da;

// Banner de permiso con acción
<NotificationBanner
  title="Activa las notificaciones"
  body="No te pierdas los nuevos recuerdos de tus álbumes compartidos."
  actionButtonText="Activar"
  onActionClick={enableNotifications}
  onClose={dismiss}
/>

// Aviso simple sin acción ni cierre
<NotificationBanner title="Copia de seguridad activada" body="Tus fotos se guardan en la nube." showCloseButton={false} />
```

## Dart mapping

- Widget: `NotificationBanner` (`lib/src/components/notifications/notification_banner.dart`)
- Fondo `bgContainerSecondaryOnBackground` · radio 24 · padding 20/20/16 · título con pad horizontal 16 y gap 8 · gap 16 antes del botón
- Mapeo de props: `onActionTap` → `onActionClick`; resto 1:1
- Composición: `DotsMainButton(content, size: medium, variant: main, expand: false)` + `DotsCloseButton(icon: cross, size: medium, variant: softContrast)`
