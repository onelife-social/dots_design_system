DotsAccordion from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsAccordion` (bundle loaded from the root `_ds_bundle.js`). Collapsible sections with animated chevron and CSS expand/collapse; `singleOpen` (default) or multi-open, optional per-section leading icon and 16px horizontal padding.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `sections` | `DotsAccordionSection[]` | — | `{ title, content?, leadingIcon?, expanded? }`. `content` acepta cualquier nodo React; `leadingIcon` es un nombre de asset `ic-…` (20px, textTertiary). |
| `singleOpen` | `boolean` | `true` | Abrir una sección cierra las demás. |
| `animationDuration` | `number` (ms) | `180` | Duración del despliegue y del giro del chevron (easeInOut). |
| `addHorizontalPadding` | `boolean` | `true` | Padding horizontal de 16px en cabeceras y contenido. |
| `onToggle` | `(index, expanded) => void` | — | Extensión web: se invoca al plegar/desplegar una sección. |

## Examples

```jsx
<DotsAccordion
  sections={[
    { title: 'Detalles del pedido', content: <p>Papel mate de 200 g.</p>, leadingIcon: 'ic-calendar', expanded: true },
    { title: 'Plazos de entrega', content: 'Entrega en 5–7 días laborables.', leadingIcon: 'ic-clock-outline' },
    { title: 'Sin icono', content: 'Sección sin leadingIcon.' },
  ]}
/>

// Varias abiertas a la vez, sin padding lateral
<DotsAccordion singleOpen={false} addHorizontalPadding={false} sections={sections} />
```

## Dart mapping

- Widget: `DotsAccordion` + `DotsAccordionSection` (`lib/src/components/accordion/dots_accordion.dart`).
- `animationDuration` (Duration, default 180 ms) → number en ms; `animationCurve` fijado a `ease-in-out` (Curves.easeInOut por defecto).
- Cabecera: padding vertical 20; título `bodyLargeMedium` `textPrimary`; chevron `ic-chevron-down` 16 `textTertiary` con `AnimatedRotation` → `transform: rotate(180deg)`.
- Despliegue: `AnimatedSize` → `grid-template-rows: 0fr→1fr` con transition; contenido con padding inferior 36.
- Separador: `DotsDivider` (dos líneas de 1px `labelSecondary` + `bgStrong`, opacity 0.6).
