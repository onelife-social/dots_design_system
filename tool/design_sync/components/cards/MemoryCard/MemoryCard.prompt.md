MemoryCard from dots_design_system. Use via `window.DotsDesignSystem_9e41da.MemoryCard` (bundle loaded from the root `_ds_bundle.js`). 68px-wide pending-memory thumbnail (photo 60.39×80 r15 inside a 1.45px gradient border) with the group name below, in 2 variants (memory = linear green border, recap = multicolor sweep border).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `groupName` | `string` (requerido) | — | Nombre del grupo (labelDefaultMedium textSecondary, 1 línea con ellipsis) |
| `imageSrc` | `string` | — | URL de la foto; sin ella se pinta placeholder degradado |
| `variant` | `'memory' \| 'recap'` | `'memory'` | Borde degradado: verde lineal / sweep multicolor (enum Dart `MemoryCardVariant`) |
| `onClick` | `() => void` | — | Tap en la tarjeta (Dart `onTap`) |

## Examples

```jsx
const { MemoryCard } = window.DotsDesignSystem_9e41da;

// Carrusel de recuerdos pendientes del home (HomePendingMemoriesBarSection)
<div style={{ display: 'flex', gap: 16 }}>
  <MemoryCard variant="memory" groupName="Familia" imageSrc={url1} onClick={open1} />
  <MemoryCard variant="recap" groupName="Verano" imageSrc={url2} onClick={open2} />
</div>
```

## Dart mapping

- Widget: `MemoryCard` (`lib/src/components/cards/memory_card/memory_card.dart`).
- Props: `image: Widget`→`imageSrc: string`, `onTap`→`onClick`; resto 1:1 (`groupName`, `variant`). `onError` no se porta.
- Enum: `MemoryCardVariant` (memory/recap) — mismos nombres. En Dart `variant` es requerido; aquí default `memory`.
- Colores del borde (sin token CSS): memory = `gradientInitialLinealGreen #77D98A → gradientFinalLinealGreen #28AB87`; recap = `DotsColors.recapGradientColors` como conic-gradient. GradientBoxBorder → padding 1.45px con hueco al color de página (`--bg-base`).
