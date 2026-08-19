DotsPlanningItem from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsPlanningItem` (bundle loaded from the root `_ds_bundle.js`). Expandable planning row: 52px squircle section image, title with chevron toggle, an always-visible main info row and sub-rows revealed on tap (200ms slide+fade).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `mainText` | `string` | — (requerido) | Título (bodyLargeMedium 16/500, textPrimary). |
| `sectionImage` | `string` (URL) | default_section_planning.webp | Imagen 52×52, squircle 16, borde 1px borderButton. El asset por defecto va incrustado como data URI en el CSS. |
| `mainItem` | `{ icon?, text?, underline? }` | — | Fila de info siempre visible (espejo de `DotsPlanningInfoItem`). |
| `subItems` | `Array<{ icon?, text?, underline? }>` | `[]` | Filas visibles solo al expandir. Filas sin `icon` o sin `text` se omiten (como `DotsPlanningItemRow`). |
| `mainIcon` | `string` | `'ic-chevron-down'` | Icono del título colapsado (DotsIcon 20, textQuarternary). |
| `mainIconActive` | `string` | `'ic-chevron-up'` | Icono del título expandido. |
| `defaultExpanded` | `boolean` | `false` | Estado inicial no controlado; el tap en la fila alterna. |
| `expanded` | `boolean` | — | Modo controlado (anula el estado interno). |
| `onToggle` | `(next: boolean) => void` | — | Notifica cada tap con el próximo estado. |
| `className` | `string` | — | Clases extra sobre `.ds-planning-item`. |

Cada fila de info pinta su icono a 16px en labelPrimary y el texto en bodyDefaultRegular textTertiary; `underline: true` lo subraya (fila de ubicación). Iconos típicos: `ic-calendar`, `ic-clock-outline`, `ic-location-pin`.

## Examples

```jsx
const { DotsPlanningItem } = window.DotsDesignSystem_9e41da;

<DotsPlanningItem
  mainText="Cena en La Terraza"
  mainItem={{ icon: 'ic-calendar', text: 'Sábado 12 de julio' }}
  subItems={[
    { icon: 'ic-clock-outline', text: '21:00 h' },
    { icon: 'ic-location-pin', text: 'Calle Mayor 12, Madrid', underline: true },
  ]}
/>

// Abierto de inicio, con imagen propia
<DotsPlanningItem
  mainText="Excursión al lago"
  sectionImage="https://…/lago.webp"
  defaultExpanded
  subItems={[{ icon: 'ic-location-pin', text: 'Embalse de San Juan', underline: true }]}
/>
```

## Dart mapping

| Web | Dart (`lib/src/components/planning/`) |
| --- | --- |
| `DotsPlanningItem` | `DotsPlanningItem` (dots_planning_item.dart) |
| objeto `{ icon, text, underline }` | `DotsPlanningInfoItem` (dots_planning_info_item.dart) |
| filas (icono 16 + texto, omitidas si vacías) | `DotsPlanningItemRow` (dots_planning_row_builder.dart) |
| `sectionImage` (URL) | `sectionImage` (`ImageProvider`) + `ImagesPaths.defaultSectionPlanning` |
| `mainIcon` / `mainIconActive` | mismos nombres (default `DotsIconData.chevronDown` / `chevronUp`) |
| toggle interno + transición 200ms | `_DotsPlanningItemState.expanded` + `AnimatedSwitcher` (aprox. grid-rows) |
| Omitido | `onError` (callback de carga de imagen) |
