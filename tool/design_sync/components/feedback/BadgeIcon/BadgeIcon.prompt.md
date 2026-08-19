BadgeIcon from dots_design_system. Use via `window.DotsDesignSystem_9e41da.BadgeIcon` (bundle loaded from the root `_ds_bundle.js`). White circular icon badge with soft shadow in 3 sizes (`large` 44 / `medium` 36 / `small` 28); pass `icons` (1-3 names) to render the stacked BadgeIconGroup (63×70 canvas) used on milestone cards.

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `icon` | `string` | required (single mode) | Dots icon asset name, e.g. `'ic-heart'`. |
| `size` | `'large' \| 'medium' \| 'small'` | `'large'` | Circle/icon px: large 44/24, medium 36/20, small 28/16. |
| `style` | `'white'` | `'white'` | Only style today: bg `labelAlwaysWhite`, icon `#000000D9` (hardcoded in Dart). |
| `iconColor` | `string` | style foreground | CSS color override for the icon. |
| `onClick` | `() => void` | — | Dart `onTap`. |
| `icons` | `string[]` | — | Group mode (1-3 icons). `icons[0]` medium bottom-left; up to two smalls stacked above. Ignores `icon`/`size`. |
| `iconColors` | `(string \| null)[]` | — | Group mode: per-icon color, `null` = default. |

Shadow is `0 0 20px #00000033` (hardcoded in Dart, no token). Group layout (63×70): 2 icons → small at left 31 / bottom 31; 3 icons → smalls at left 4 / bottom 42 and left 35 / bottom 26.

## Examples

```jsx
const { BadgeIcon } = window.DotsDesignSystem_9e41da;

// Single badge over a photo
<BadgeIcon icon="ic-heart" />

// Small tinted badge
<BadgeIcon icon="ic-balloons" size="small" iconColor="#0072EF" />

// Milestone-card icon group (BadgeIconGroup)
<BadgeIcon icons={["ic-camera", "ic-heart", "ic-gift"]} iconColors={[null, "#ED2B32", null]} />
```

## Dart mapping

- Widget: `BadgeIcon` (`lib/src/components/badges/badge_icon/badge_icon.dart`); group mode = `BadgeIconGroup` (`badge_icon_group.dart`, used by `MilestoneCard`).
- `icon: DotsIconData` → `icon` (real asset name); `size: BadgeIconSize` → `size`; `style: BadgeIconStyle` → `style`; `iconColor: Color?` → `iconColor`; `onTap` → `onClick`.
- Colors from `getBadgeIconThemeByStyle` (`badge_icon_theme.dart`): white = `labelAlwaysWhite` bg + `0xD9000000` icon.
