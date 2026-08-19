BadgeTag from dots_design_system. Use via `window.DotsDesignSystem_9e41da.BadgeTag` (bundle loaded from the root `_ds_bundle.js`). Red notification counter (labelDestructive, min 18×18, radius 22, 11/600 white text): standalone, or floating over its `children` at the top-right corner (default offset -5,-5).

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `tag` | `string` | required | Counter text (`'9'`, `'99+'`). Empty string renders an empty 18×18 dot. |
| `children` | `ReactNode` | — | Main content; when present the tag floats at its top-right. Dart: `child`. |
| `size` | `{ width?, height? }` | `-5 / -5` | Offset from the top-right corner when floating: `right = width`, `top = height`. Dart: `size (Size)`. |

This is the official standalone tag. `DotsSegmentedControl` (`buttonTag`/option tags) and `DotsIconButton` (`tag`) draw their own inline equivalents (`.ds-seg__tag`, `.ds-icon-btn__tag`) — keep using their props there; use `BadgeTag` everywhere else.

## Examples

```jsx
const { BadgeTag, BadgeIcon } = window.DotsDesignSystem_9e41da;

// Standalone counter
<BadgeTag tag="99+" />

// Floating over content (default -5,-5)
<BadgeTag tag="9">
  <BadgeIcon icon="ic-camera" />
</BadgeTag>

// Custom offset (flush with the corner)
<BadgeTag tag="3" size={{ width: 0, height: 0 }}>
  <Avatar />
</BadgeTag>
```

## Dart mapping

- Widget: `BadgeTag` (`lib/src/components/badges/badge_tag.dart`).
- `tag` → `tag`; `child` → `children`; `size: Size?` → `size` (`Positioned(right: size?.width ?? -5, top: size?.height ?? -5)`).
- Body (`_BadgeBody`): bg `labelDestructive`, text `labelSmallMedium` (11/600) + `labelAlwaysWhite`, padding 1×5, min 18×18, `DotsBorderRadius.r22`.
