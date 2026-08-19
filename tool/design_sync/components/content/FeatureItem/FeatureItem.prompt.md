FeatureItem from dots_design_system. Use via `window.DotsDesignSystem_9e41da.FeatureItem` (bundle loaded from the root `_ds_bundle.js`). Label/value row with a 16px icon leading (or a custom 24×24 image via the `image` prop, mirroring the Dart `FeatureItem.image` variant): feature text left-aligned, optional value right-aligned.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `feature` | `string` (requerido) | — | Etiqueta izquierda (bodyDefaultRegular, textTertiary) |
| `value` | `string` | — | Valor derecho (bodyDefaultMedium, textSecondary, alineado a la derecha) |
| `icon` | `string` | — | Nombre de icono DotsIcon (16px, textQuarternary), p.ej. `'ic-calendar'` |
| `image` | `ReactNode` | — | Leading custom 24×24 (avatar, miniatura…); sustituye a `icon` |

Notas:
- Con `value`: feature flex 6 / value flex 4 (como el Row Dart). Sin `value`, feature ocupa todo.
- Pasa `icon` **o** `image` (en Dart son constructores separados).
- Light/dark automático vía tokens: envuelve en `data-theme="dark"` para modo oscuro.

## Examples

```jsx
const { FeatureItem } = window.DotsDesignSystem_9e41da;

// Metadatos de un recuerdo
<FeatureItem feature="Fecha" value="12 mayo 2024" icon="ic-calendar" />
<FeatureItem feature="Lugar" value="Madrid" icon="ic-location-pin" />

// Bullet de features (sin value)
<FeatureItem feature="Recuerdos ilimitados" icon="ic-infinity" />

// Leading custom (variante FeatureItem.image)
<FeatureItem feature="Creado por" value="María" image={<img src={avatarUrl} style={{ width: 24, height: 24, borderRadius: '50%' }} />} />
```

## Dart mapping

- Widget: `FeatureItem` (`lib/src/components/feature_item/feature_item.dart`).
- Props: `feature`/`value` 1:1; `icon: DotsIconData`→`icon: string` (nombre del asset); constructor `FeatureItem.image(image: Widget)`→prop `image: ReactNode`.
- Estilo: Row spacing 8 · DotsIcon 16 `textQuarternary` · feature `bodyDefaultRegular` `textTertiary` (flex 6 con value, 1 sin) · value `bodyDefaultMedium` `textSecondary` (flex 4, derecha).
