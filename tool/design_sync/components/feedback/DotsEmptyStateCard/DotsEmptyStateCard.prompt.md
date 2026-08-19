DotsEmptyStateCard from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsEmptyStateCard` (bundle loaded from the root `_ds_bundle.js`). Centered empty state: image (`variant: 'image'`) or icon (`variant: 'icon'`) over a P22 Mackinac title, a quarternary description and an optional button.

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `variant` | `'image' \| 'icon'` | — | Dart enum `DotsEmptyStateCardVariant`. |
| `image` | `string` | — | Image URL (variant `image`). |
| `icon` | `string \| ReactNode` | — | Variant `icon`: DotsIcon name (rendered 48px textQuarternary) or a prebuilt node. |
| `title` | `string` | — | title02H5 (P22 Mackinac 20/500) textPrimary. |
| `description` | `string` | — | bodyDefaultRegular (14/400) textQuarternary. |
| `titleColor` / `descriptionColor` | `string` | — | CSS color overrides. |
| `button` | `ReactNode` | — | Optional CTA, typically a `DotsMainButton`; 16px above it. |
| `extraSpaceAfterImage` | `number` | `0` | Extra px between image and title (base gap: image 4, icon 16). |
| `imageWidth` | `number` | — | Image width in px. |
| `descriptionSpans` | `ReactNode` | — | Rich description rendered instead of `description` (kept as aria-label). |

The card is `width: 100%` (Dart sizes it to 82% of the screen width) — size it with its parent container.

## Examples

```jsx
const { DotsEmptyStateCard, DotsMainButton } = window.DotsDesignSystem_9e41da;

// Icon empty state
<DotsEmptyStateCard variant="icon" icon="ic-search"
  title="Sin resultados" description="Prueba con otra búsqueda o cambia los filtros." />

// Image + CTA
<DotsEmptyStateCard variant="image" image="/img/empty-memories.png" imageWidth={140}
  title="Aún no hay recuerdos" description="Crea tu primer recuerdo para empezar tu historia."
  button={<DotsMainButton label="Crear recuerdo" size="large" adaptPaddingForText expand={false} />} />
```

## Dart mapping

- Widget: `DotsEmptyStateCard` (`lib/src/components/empty_state/empty_state_card.dart`); enum `DotsEmptyStateCardVariant`.
- `imageProvider` (ImageProvider) → `image` (URL); `icon` (a `DotsIcon` widget) → `icon` (name string or node); `button` (a `DotsMainButton` widget) → `button` (node); `descriptionSpans` (`List<InlineSpan>`) → `descriptionSpans` (node); the rest keep their names.
- Layout: gaps image→title 4 (+`extraSpaceAfterImage`) / icon→title 16, title→description 8, description→button 16; horizontal padding 20 (phone ratio of `getByRatio`).
