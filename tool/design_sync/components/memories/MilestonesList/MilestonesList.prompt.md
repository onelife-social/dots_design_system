MilestonesList from dots_design_system. Use via `window.DotsDesignSystem_9e41da.MilestonesList` (bundle loaded from the root `_ds_bundle.js`). Vertical milestone timeline: a dotted bezier line meanders through seeded pseudo-random x-offsets connecting age badges (strings, rendered as ghost pills) and MilestoneCards, each centered on its point.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `list` | `Array<string \| MilestoneCardProps \| ReactElement>` | — (requerido) | En orden vertical. `string` ⇒ badge de edad (BadgeMilestone ghost: píldora r22, bgBase, textTertiary). Objeto ⇒ se renderiza `MilestoneCard` con esas props (width por defecto 244.5 = alto 326 con aspect 3:4). Un elemento React se pinta tal cual. |
| `seed` | `number` | `1` | Semilla del layout: gaps 20–34 entre cards y alternancia de los patrones x `[0,−23,37,16,−38]` / `[0,−38,37,−39,29,37]`. Misma semilla ⇒ mismo trazado. |
| `width` | `number` | medido | Ancho px del lienzo; sin él se mide el contenedor (centerX = ancho/2). |
| `className` | `string` | — | Clases extra sobre `.ds-milestones-list`. |

Geometría Dart: cardHeight 326, badgeHeight 17, separación 64 entre badge y card, cola de +64 tras la última card; línea punteada de puntos r1 cada 8px en labelSecondary con curvas cuadráticas (control = punto medio ± 20). El alto total se calcula solo — el scroll lo pone el contenedor padre (en Flutter es un SingleChildScrollView).

## Examples

```jsx
const { MilestonesList } = window.DotsDesignSystem_9e41da;

<div style={{ height: 600, overflowY: 'auto' }}>
  <MilestonesList
    seed={7}
    list={[
      '6 meses',
      { src: fotoA, title: 'Primeros pasos', date: '12 mar 2026', badgeTypes: ['video'] },
      { src: fotoB, title: 'Su primer diente', showBadge: true },
      '12 meses',
      { src: fotoC, title: 'Primera palabra', badgeTypes: ['audio', 'description'] },
    ]}
  />
</div>
```

## Dart mapping

| Web | Dart (`lib/src/components/milestones/milestones_list.dart`) |
| --- | --- |
| `MilestonesList` | `MilestonesList` |
| `list` (string ⇒ badge ghost, objeto ⇒ MilestoneCard) | `list` (`String` ⇒ `BadgeMilestone(variant: ghost)`, `MilestoneCard`) |
| `seed` + PRNG mulberry32 | `seed` + `Random(seed)` (determinista por semilla; secuencia no idéntica bit a bit a Dart) |
| path SVG `Q` + dasharray `0.1 8` linecap round | `_BezierTimelinePainter` (bend 20, dotRadius 1, spacing 8, labelSecondary) |
| constantes 326 / 17 / 64 | `cardHeight` / `badgeHeight` / `tailExtension` |
| Omitido | auto-scroll a `isSelected` (`Scrollable.ensureVisible`) |
