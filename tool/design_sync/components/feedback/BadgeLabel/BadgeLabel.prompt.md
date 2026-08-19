BadgeLabel from dots_design_system. Use via `window.DotsDesignSystem_9e41da.BadgeLabel` (bundle loaded from the root `_ds_bundle.js`). Pill status badge in 3 sizes (`large` 34 / `medium` 22 / `small` 18) and 10 variants (`main`, `secondary`, `green`, `white`, `greenMaterial`, `warning`, `warningMaterial`, `red`, `premium`, `premiumPlus`), with optional 16px leading icon.

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `content` | `string` | required | Badge text, single line with ellipsis. |
| `size` | `'large' \| 'medium' \| 'small'` | `'medium'` | large = bodyDefaultMedium (14/500); medium/small = labelSmallMedium (11/600). Radius = height. |
| `variant` | see above | `'main'` | `premium`/`premiumPlus` use the brand gradients; `white` adds a 1px borderButton border. |
| `badgeIcon` | `string` | — | Dots icon asset name (e.g. `'ic-check-circle'`), tinted with the variant foreground. |

All variants sit on a 50px backdrop blur (theme `bgBlur`), so they can float over photos.

## Examples

```jsx
const { BadgeLabel } = window.DotsDesignSystem_9e41da;

// Counter over a photo
<BadgeLabel content="12 fotos" />

// Success state with icon
<BadgeLabel content="Completado" variant="green" badgeIcon="ic-check-circle" />

// Premium plan tag
<BadgeLabel content="Premium" variant="premium" size="large" badgeIcon="ic-diamond" />
```

## Dart mapping

- Widget: `BadgeLabel` (`lib/src/components/badges/badge_label/badge_label.dart`).
- `size: BadgeLabelSize` → `size` string; `variant: BadgeLabelVariant` → `variant` string (same enum names).
- `badgeIcon: DotsIconData` → `badgeIcon` (real asset name).
- Colors from `getBadgeLabelThemeByTagVariant` (`badge_label_theme.dart`); gradients = `theme.styles.bgPremium` / `bgPremiumPlus`; blur = `theme.styles.bgBlur` (50).
