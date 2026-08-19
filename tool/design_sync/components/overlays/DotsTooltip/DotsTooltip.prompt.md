DotsTooltip from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsTooltip` (bundle loaded from the root `_ds_bundle.js`). Coach-mark tooltip with a triangular tail in 10 positions (`tailPosition`), optional 32px highlight icon, and a small close button.

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `text` | `string` | — | Required. labelDefaultMedium (13/500), textPrimary. |
| `tailPosition` | `'topAlignLeadingEdge' \| 'topAlignLeading' \| 'topAlignCenter' \| 'topAlignTrailing' \| 'topAlignTrailingEdge' \| 'bottomAlignLeadingEdge' \| 'bottomAlignLeading' \| 'bottomAlignCenter' \| 'bottomAlignTrailing' \| 'bottomAlignTrailingEdge'` | — | Required. `top*` draws the tail above (pointing up), `bottom*` below. `*Edge` also rounds that corner to 14px. |
| `icon` | `string` | — | Dots icon asset name (e.g. `'ic-info-circle'`), 32px in labelHighlight. |
| `iconNode` | `ReactNode` | — | Custom icon node; wins over `icon`. |
| `showCloseButton` | `boolean` | `true` | DotsCloseButton small softContrast, top-right. |
| `maxWidth` | `number` | `288` | Min width 185, min height 64. |
| `onClick` | `() => void` | — | Tap on the tooltip body. |
| `onClose` | `() => void` | — | Tap on the close button. |

Leave ~14px of clearance on the tail side when placing it (the tail overflows 12px).

## Examples

```jsx
const { DotsTooltip } = window.DotsDesignSystem_9e41da;

// Pointing down at the element below it
<DotsTooltip
  text="Toca aquí para añadir tu primer recuerdo"
  icon="ic-info-circle"
  tailPosition="bottomAlignCenter"
  onClose={dismiss}
/>

// Below a button on the top-left, no close button
<DotsTooltip text="Comparte el álbum" tailPosition="topAlignLeadingEdge" showCloseButton={false} />
```

## Dart mapping

- Widget: `DotsTooltip` (`lib/src/components/tooltip/dots_tooltip.dart`); enum `DotsToolTipTailPosition` (`dots_tooltip_enums.dart`).
- `onTap` → `onClick`; `iconWidget` → `iconNode`; `icon: DotsIconData` → `icon` (real asset name).
- Tail = `TrianglePainter` 21×13 (fill bgBaseContrast, stroke 2 bgContainerSecondary); alignment.x −0.82/−0.56/0/0.56/0.82 → left 9%/22%/50%/78%/91%.
