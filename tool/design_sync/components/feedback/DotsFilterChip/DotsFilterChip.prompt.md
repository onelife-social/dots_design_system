DotsFilterChip from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsFilterChip` (bundle loaded from the root `_ds_bundle.js`). Active-filter chip: bgContainerSecondary pill (radius 22) with a bold 13px label and a 16px close button; the whole chip fires `onClick` (typically to remove the filter).

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `label` | `string` | `''` | Filter text, labelDefaultBold (13/600) textSecondary. |
| `onClick` | `() => void` | — | Fired when the chip (including the cross) is tapped. |

The close affordance is a DotsCloseButton `extraSmall` + `highContrast` (16px circle, `ic-cross` at 10px, bgSecondaryBtn / textTertiary) and is decorative — it has no separate handler, matching the Dart widget.

## Examples

```jsx
const { DotsFilterChip } = window.DotsDesignSystem_9e41da;

// Removable active filter
<DotsFilterChip label="Familia" onClick={() => removeFilter('familia')} />

// Filter bar
<div style={{ display: 'flex', gap: 8 }}>
  {filters.map((f) => (
    <DotsFilterChip key={f} label={f} onClick={() => removeFilter(f)} />
  ))}
</div>
```

## Dart mapping

- Widget: `DotsFilterChip` (`lib/src/components/dots_filter_chip/dots_filter_chip.dart`).
- `onTap` → `onClick`; `label` → `label`.
- Cross = `DotsCloseButton(icon: DotsIconData.cross, size: extraSmall, variant: highContrast)` — rendered inline with `ic-cross`.
