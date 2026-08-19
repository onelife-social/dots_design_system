DotsItemInput from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsItemInput` (bundle loaded from the root `_ds_bundle.js`). 42px clickable form row — icon + label + 120px value box — designed to stack in groups where `position` (`onlyOne` | `first` | `middle` | `last`) controls which corners get the 16px radius.

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `label` | `string` | `''` | Row text (bodyDefaultMedium, textPrimary), truncates with ellipsis. |
| `value` | `string` | `''` | Text in the right value box (120px wide, r7, labelDefaultBold, bgContainerSecondaryOnBackground). |
| `icon` | `string` | `'ic-calendar'` | Dots icon asset name, 20px, textQuarternary. |
| `position` | `'onlyOne' \| 'first' \| 'middle' \| 'last'` | `'onlyOne'` | Corner radius: all 16 / top 16 / none / bottom 16. |
| `onClick` | `() => void` | — | Row click (e.g. open a picker). Row gets `role="button"` + pointer cursor when set. |

Stack grouped rows in a flex column with a 1px gap so the flat middle edges read as one card.

## Examples

```jsx
const { DotsItemInput } = window.DotsDesignSystem_9e41da;

// Grouped date / time / place rows
<div style={{ display: 'flex', flexDirection: 'column', gap: 1 }}>
  <DotsItemInput position="first" icon="ic-calendar" label="Fecha" value="12/03/2026" onClick={pickDate} />
  <DotsItemInput position="middle" icon="ic-clock-outline" label="Hora" value="18:30" onClick={pickTime} />
  <DotsItemInput position="last" icon="ic-location-pin" label="Lugar" value="Madrid" onClick={pickPlace} />
</div>

// Standalone row
<DotsItemInput icon="ic-calendar" label="Fecha" value="12/03/2026" onClick={pickDate} />
```

## Dart mapping

- Widget: `DotsItemInput` (`lib/src/components/text_fields/dots_item_input.dart`); `DotsItemInputPosition` → `position` (same names).
- `onTap` → `onClick`; `icon: DotsIconData` → `icon` (real asset name; Dart default `DotsIconData.calendar` → `'ic-calendar'`).
- Row: h42, bgContainerSecondary, padding 8/8/8/12; value box: 120 × full height, `DotsBorderRadius.r7`, bgContainerSecondaryOnBackground.
