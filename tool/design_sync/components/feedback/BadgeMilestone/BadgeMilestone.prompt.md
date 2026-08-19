BadgeMilestone from dots_design_system. Use via `window.DotsDesignSystem_9e41da.BadgeMilestone` (bundle loaded from the root `_ds_bundle.js`). Milestone pill (radius 22, bgBase + 25px backdrop blur, textTertiary 13/400) in 2 variants: `main` (1px bgSecondaryBtn border, 9px vertical padding) and `ghost` (borderless, 6px vertical padding).

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `content` | `string` | required | Milestone text, single line with ellipsis. |
| `variant` | `'main' \| 'ghost'` | `'main'` | main adds the 1px border; ghost is flatter (pad 6×12 vs 9×12). |

Sits on a 25px backdrop blur so it floats over milestone photos. The orange starburst seen on milestone cards is a separate asset (`assets/images/milestones/badge-milestone-1.svg`, rendered by `MilestoneCard`'s `_CardBadge` at top 5 / right 5) — the BadgeMilestone card demo embeds it as a data URI for context; it is NOT part of this component.

## Examples

```jsx
const { BadgeMilestone } = window.DotsDesignSystem_9e41da;

// Default (main): border + blur pill
<BadgeMilestone content="100 recuerdos" />

// Ghost over a photo
<div style={{ position: 'relative' }}>
  <img src={photo} />
  <div style={{ position: 'absolute', left: 12, bottom: 12 }}>
    <BadgeMilestone content="1 año juntos" variant="ghost" />
  </div>
</div>
```

## Dart mapping

- Widget: `BadgeMilestone` (`lib/src/components/badges/badge_milestone/badge_milestone.dart`).
- `variant: BadgeMilestoneVariant` → `variant` string (same enum names).
- Colors/paddings from `getBadgeMilestoneThemeByVariant` (`badge_milestone_theme.dart`): bg `bgBase`, text `textTertiary`, border `bgSecondaryBtn` (main only); blur = `ImageFilter.blur(25)` (no `--blur-25` token, literal px in CSS); typography `labelDefaultRegular` (13/400/1.31).
