BadgeProgress from dots_design_system. Use via `window.DotsDesignSystem_9e41da.BadgeProgress` (bundle loaded from the root `_ds_bundle.js`). "current/max" counter pill (h36, radius 22) with a fixed 20px blue `ic-check-circle` icon — no variants.

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `current` | `number` | required | Left number. |
| `max` | `number` | required | Right number. Rendered as `current/max`. |

Background `bgContainerSecondaryOnBackground`, text `textSecondary` (labelDefaultMedium 13/500), icon tinted `labelHighlight`. The icon and layout are fixed by the Dart widget — no icon/variant props.

## Examples

```jsx
const { BadgeProgress } = window.DotsDesignSystem_9e41da;

// Checklist progress
<BadgeProgress current={3} max={5} />

// Completed
<BadgeProgress current={12} max={12} />
```

## Dart mapping

- Widget: `BadgeProgress` (`lib/src/components/badges/badge_progress.dart`).
- `current`/`max` map 1:1.
- Icon: `DotsIconData.checkCircle` → `ic-check-circle` (20px, `labelHighlight`); bg `bgContainerSecondaryOnBackground`; text `labelDefaultMedium` + `textSecondary`; gap 2, padding 0 6, height 36, radius 22.
